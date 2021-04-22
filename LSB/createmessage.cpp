#include <iostream>
#include <stdlib.h>
#include <fstream>
#include <ctime>
#include <cstdlib>
using namespace std;
int main()
{
	ofstream file("message.txt");
	srand((int) time(0));		//利用时间种子生成随机数 
	int length;
	length=rand()%50+1;
	//file<<"length="<<length<<endl;
	for(int i=0;i<length;i++)
	{
		int number=rand()%2;
		file<<number;
	}
    file.close();
	return 0;
}
