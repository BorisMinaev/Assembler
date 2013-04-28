#include <iostream>
#include <cmath>

extern "C"
{

	void FDCT(float* x, float* res, int n);

}

const int N = 1;
const int SIZE = 8;

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

	FDCT(data, res, N);

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
