#include <iostream>
#include <cmath>
#include <time.h>  

extern "C"
{

	void FDCT(float* data, float* res, int n);
	void transpose(float* data, float* res);
	void copy(float* data, float* res);
	void copy2(float* data, float* res);
	void matrix_mul(float* data1, float * data2, float* res);
	void matrix_mul3(float* data1, float * data2, float* res);

}

const int N = 1;
const int SIZE = 8;

void transpose2(float * data, float * res) {
	for (int i = 0; i < 8; i++)
		for (int j = 0; j < 8; j++)
			res[i * 8 + j] = data[j * 8 + i];
}

void matrix_mul2(float * m1, float * m2, float * res) {
	float zz;
	for (int i =  0; i < 8; i++) 
		for (int j = 0; j < 8; j++) {
			zz =0;
			for (int  k = 0; k < 8; k++)
				zz += m1[i * 8 + k] * m2[j * 8 + k];
			res[i * 8 + j] = zz;
		}
}

int main ( )
{
	float data1[SIZE * SIZE * N];
	int it = 0;
	for (int i = 0; i < N; i++) {
		for (int x = 0; x < SIZE; x++) {
			for (int y = 0; y < SIZE; y++) {
				data1[it++] = rand() / 1000000000.0;
			}
		}
	}

	float data2[SIZE * SIZE * N];
	it = 0;
	for (int i = 0; i < N; i++) {
		for (int x = 0; x < SIZE; x++) {
			for (int y = 0; y < SIZE; y++) {
				data2[it++] = rand() / 1000000000.0;
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
	for (int it = 0; it < 1; it++) {
		//matrix_mul(data1, data2, res);
		copy2(data1, res);
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
