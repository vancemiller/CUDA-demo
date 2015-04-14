cpu:
	gcc mult.c -o cpu_mult -Wall -O0
gpu:
	nvcc mult.cu -o gpu_mult
all:
	make cpu
	make gpu
