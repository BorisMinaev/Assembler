#include <iostream>
#include <cmath>
#include <time.h>  

extern "C"
{

	void _fdct(float* data, float* res, int n);
	void _idct(float* data, float* res, int n);

}

const int N = 100000;
const int SIZE = 8;

float cur[] = {-16342,   2084, -10049,  10117,   2786,   -659,  -4905,  12975,
	10579,   8081, -10678,  11762,   6898,    444,  -6422, -15892,
	-13388,  -4441, -11556, -10947,  16008,  -1779, -12481, -16230,
	-16091,  -4001,   1038,   2333,   3335,   3512, -10936,   5343,
	-1612,  -4845, -14514,   3529,   9284,   9916,    652,  -6489,
	12320,   7428,  14939,  13950,   1290, -11719,  -1242,  -8672,
	11870,  -9515,   9164,  11261,  16279,  16374,   3654,  -3524,
	-7660,  -6642,  11146, -15605,  -4067, -13348,   5807, -14541};

float res1[SIZE * SIZE * N];
float res2[SIZE * SIZE * N];
float data[SIZE * SIZE * N];

int main () {
	for (int i = 0; i < SIZE * SIZE * N; i++)
		data[i] = cur[i % (SIZE * SIZE)];

	_fdct(data, res1, N);
	_idct(res1, res2, N);
	bool fail = false;
	for (int i = 0; i < SIZE * SIZE * N; i++) {
		float diff = res2[i] - data[i];
		if (diff < 0)
			diff = -diff;
		if (diff > 0.1)
			fail = true;
	}

	if (fail)
		std::cout << "fail" << std::endl;
	}

	for (int ii = 0; ii < 1; ii++) {
		for (int i = 0; i < SIZE; i++) {
			for (int j =0; j < SIZE; j++) {
				printf("%.2f ", res1[ii * SIZE * SIZE + i * SIZE + j]);
			}
			std::cout << std::endl;
		}
	}

}
