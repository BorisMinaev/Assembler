#include <iostream>
#include <cmath>
#include <time.h>  

extern "C"
{

	void _fdct(float* data, float* res, int n);
	void _idct(float* data, float* res, int n);
	void transpose(float* data, float* res);
	void time_test(float* data, float* res);
	void copy(float* data, float* res);
	void copy2(float* data, float* res);
	void matrix_mul(float* data1, float * data2, float* res);
	void matrix_mul3(float* data1, float * data2, float* res);
	void matrix_mul4(float* data1, float * data2, float* res);

}

const int N = 2;
const int SIZE = 8;

void transpose2(float * data, float * res) {
	for (int i = 0; i < 8; i++)
		for (int j = 0; j < 8; j++)
			res[i * 8 + j] = data[j * 8 + i];
}

void matrix_mul2(float * m1, float * m2, float * res) {
	for (int i = 0; i < 64; i++)
		res[i] = 0;
	for (int i =  0; i < 8; i++) 
		for (int j = 0; j < 8; j++) {
			for (int k = 0; k < 8; k++) {
				res[i*8+k] += m1[i * 8 +j]  * m2[j * 8 + k];
			}
		}
}

int main ( )
{
	/*
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
		matrix_mul4(data1, data2, res);
		//copy2(data1, res);
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
	
	float matr1[64];
	float matr2[64];
	int N = 8;
	float pi = atan(1) * 4;
	for (int j = 0; j < 8; j++) {
		for (int i = 0; i < 8; i++) {
			float val;
			if (i == 0) {
				val = 1 / sqrt(N + 0.);
			} else {
				val = sqrt(2. / (N + 0.)) * cos((2 * j + 1) * i * pi/2./(N + 0.));
			}
			val /= sqrt(8);
			matr1[i * 8 + j] = matr2[j * 8 + i] = val;
			printf("%.1f, ", 0.0);
		}
		//std::cout << std::endl;
	}
	
*/

	float cur[] = {-16342,   2084, -10049,  10117,   2786,   -659,  -4905,  12975,
 10579,   8081, -10678,  11762,   6898,    444,  -6422, -15892,
-13388,  -4441, -11556, -10947,  16008,  -1779, -12481, -16230,
-16091,  -4001,   1038,   2333,   3335,   3512, -10936,   5343,
 -1612,  -4845, -14514,   3529,   9284,   9916,    652,  -6489,
 12320,   7428,  14939,  13950,   1290, -11719,  -1242,  -8672,
 11870,  -9515,   9164,  11261,  16279,  16374,   3654,  -3524,
 -7660,  -6642,  11146, -15605,  -4067, -13348,   5807, -14541};
 	float res2[64 * N];
 	float arr1[64 * N];
 	for (int i = 0; i < 64 * N ;i++)
 		arr1[i] = cur[i % 64];

 	_fdct(arr1, res2, N);
 	//matrix_mul2(cur, cur, res2);

 	int n = 8;
 	for (int ii = 0; ii < N; ii++) {
 	for (int i = 0; i < n; i++) {
 		for (int j =0; j < n; j++) {
 			printf("%.2f ", res2[ii * 64 + i * 8 + j]);
 		}
 		std::cout << std::endl;
 	}
 	std::cout << std::endl;
 }

 	
}
