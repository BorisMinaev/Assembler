#include <iostream>
#include <cmath>
#include <time.h>  

extern "C"
{

	void FDCT(float* data, float* res, int n);
	void transpose(float* data, float* res);
	void copy(float* data, float* res);

}

const int N = 1;
const int SIZE = 8;

void transpose2(float * data, float * res) {
	for (int i = 0; i < 8; i++)
		for (int j = 0; j < 8; j++)
			res[i * 8 + j] = data[j * 8 + i];
}

int main ( )
{
	float data[SIZE * SIZE * N];
	int it = 0;
	for (int i = 0; i < N; i++) {
		for (int x = 0; x < SIZE; x++) {
			for (int y = 0; y < SIZE; y++) {
				data[it++] = rand() / 10000000.0;
			}
		}
	}

	float res[SIZE * SIZE * N];
	it = 0;
	for (int i = 0; i < N; i++) {
		for (int x = 0; x < SIZE; x++) {
			for (int y = 0; y < SIZE; y++) {
				res[it++] = 0.0;
			}
		}
	}

	//FDCT(data, res, N);
	clock_t t1, t2;

 	t1 = clock();  
	for (int it = 0; it < 10000000; it++) {
		copy(data, res);
	}
	t2 = clock();
	float diff = (((float)t2 - (float)t1) / 1000000.0F ) * 1000;   
 	printf("%f ms\n",diff);  

	it = 0;
	for (int i = 0; i < N; i++) {
		for (int x = 0; x < SIZE; x++) {
			for (int y = 0; y < SIZE; y++) {
				printf("%.3f ", res[it]);
				it++;
			}
			printf("\n");
		}
		printf("\n");
	}
	
}
