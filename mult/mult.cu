#include <unistd.h>
#include <stdio.h>

__global__ void addKernel(int *a, int *b, int *c, long int length)
{
    int x = blockIdx.x * blockDim.x + threadIdx.x;
    int y = blockIdx.y * blockDim.y + threadIdx.y;
    int index = x * length + y;
    if (x < length && y < length)
        c[index] = a[x] + b[y];
}

int main(int argc, char **argv)
{
    // initialize host memory
    if (argc == 1) {
        fprintf(stderr, "Call program with size argument\n");
        exit(EXIT_FAILURE);
    }
    long int N;
    if (sscanf(argv[1], "%ld", &N) == 0) {
        fprintf(stderr, "Size argument should be a long int\n");
        exit(EXIT_FAILURE);
    }
    int *a = (int*) malloc(sizeof(int) * N);
    int *b = (int*) malloc(sizeof(int) * N);
    int *results = (int*) malloc(sizeof(int) * N);
    int i;

    // initialize device memory
    int *dev_a;
    int *dev_b;
    int *dev_results;
    cudaMalloc((void**) &dev_a, N * sizeof(int));
    cudaMalloc((void**) &dev_b, N * sizeof(int));
    cudaMalloc((void**) &dev_results, N * sizeof(int));

    // initialize arrays
    for (i = 0; i < N; i++)
    {
        a[i] = i;
        b[i] = i;
    }

    // copy to device for computation
    cudaMemcpy(dev_a, a, N * sizeof(int), cudaMemcpyHostToDevice);
    cudaMemcpy(dev_b, b, N * sizeof(int), cudaMemcpyHostToDevice);

    // do add operation
    addKernel<<<N * N / 512, 512>>>(dev_a, dev_b, dev_results, N);

    cudaMemcpy(results, dev_results, N * sizeof(int), cudaMemcpyDeviceToHost);

    // clean up
    free(a);
    free(b);
    free(results);
    cudaFree(dev_a);
    cudaFree(dev_b);
    cudaFree(dev_results);

    // done
    printf("done\n");
    return EXIT_SUCCESS;
}

