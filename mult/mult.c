#include <stdlib.h>
#include <stdio.h>

void mult(int *a, int *b, int *results, long int length) {
    int i, j;
    for (i = 0; i < length; i++) {
        for (j = 0; j < length; j++) {
            results[i * length + j] = a[i] * b[j];
        }
    }
}


int main(int argc, char** argv)
{
    // intialize host memory
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
    int *results = (int*) malloc(sizeof(int) * N * N);
    int i;

    // initialize arrays
    for (i = 0; i < N; i++) {
        a[i] = i;
        b[i] = i;
    }
 
    // do add operation
    mult(a, b, results, N);

    // clean up
    free(a);
    free(b);
    free(results);

    // done
    printf("done\n");
    return EXIT_SUCCESS;
}

