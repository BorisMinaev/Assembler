#include <iostream>
#include <cmath>

extern "C"
{

	void FDCT(int x, int * res);

}

int main ( )
{

	int x = 123;
	int res = 0;
	FDCT(x, &res);
	std::cout << res << std::endl;
	
}
