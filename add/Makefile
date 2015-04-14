cpu:
	gcc add.c -o cpu_add -Wall -O0
gpu:
	nvcc add.cu -o gpu_add
all:
	make cpu
	make gpu
