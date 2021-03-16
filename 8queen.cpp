//8 queen
#include <iostream>
#include <cmath>
using namespace std;

int board[8][8]={0};
bool check(int row,int col)
{
	for(int i=0;i<row;i++)
	{
		for(int j=0;j<8;j++)
		{
			if((board[i][col]==1)||(abs(row-i)==abs(col-j)&&(board[i][j]==1)))
			{
				return false;
			}
		}
	}
	return true;
}
void printboard()
{
	cout<<"###############"<<endl;
	for(int i=0;i<8;i++)
	{
		for(int j=0;j<8;j++)
		{
			cout<<board[i][j]<<" ";
		}
		cout<<endl;
	}
	cout<<"###############"<<endl;
}
int time=1;
void putqueen(int row)
{
	
	if(row>=8)
	{
		cout<<time++<<endl;
		printboard();	
		return;
	}
	else{
		for(int i=0;i<8;i++)
		{			
			if(check(row,i))
			{								
				board[row][i]=1;
				putqueen(row+1);			
			}
			board[row][i]=0;	
		}		
	}
}
int main()
{
	/*
	board[0][0]=1;
	board[1][2]=1;
	printboard();
	bool a=check(2,1);
	cout<<endl;
	cout<<"a="<<a;	
	*/
	putqueen(0);
	return 0;
}
