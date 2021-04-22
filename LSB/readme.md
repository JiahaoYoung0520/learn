# 代码介绍

## 1.文件介绍

共有6个文件

1.bmp 是我们的原图，信息将隐藏在其中

LSB1.m是我们运行的matlab文件，主要用于隐藏信息和获取信息

message.txt是我们的信息存储文件，我们需要隐藏的信息就在其中

messageget.txt是我们从加密图像获取的信息，换言之就是我们提取的结果

createmessage.cpp是用于生成随机01字符串的c++文件

createmessage.exe是生成的文件，每次运行会修改message.txt，生成随机的01串



## 2.代码介绍

### 1)LSB.m

work()
%加密
function[C]=hide(message)
    input=imread('1.bmp');  %读取图像
    grayInput=rgb2gray(input);%转化为灰度图像
    row=size(grayInput,1);     %获取行数
    column=size(grayInput,2);   %获取列数
    %赋值
    for i =1:row
        for j=1:column 
            if ((i-1)*column+j)<=size(message,2) %给和隐藏信息长度相同的像素赋值
            dec2=dec2bin(grayInput(i,j));          %将灰度值转为二进制
            dec2(size(dec2,2))=message((i-1)*column+j);%将灰度值二进制的最后一位变成隐藏信息的值
            grayInput(i,j)=bin2dec(dec2);               %将灰度的值变为我们修改后的数值
            end
        end
    end
C=imshow(grayInput);
imwrite(grayInput,'hidegraph.bmp');         
end

%解密
function[message]=get(input,length)                    
    graph=imread(input);                        %读取隐藏信息后的图片
    row=size(graph,1);                          %获取行数
    column=size(graph,2);                       %获取列数
    %取值
    for i =1:row
        for j=1:column 
            if ((i-1)*column+j)<=length
            dec2=dec2bin(graph(i,j));           %将二进制值取到
            message((i-1)*column+j)= dec2(size(dec2,2));   %将最后一位赋值给message
            end
        end
    end
end

function[]=work()
    a=textread('message.txt','%s');     %读取需隐藏信息
    information=a{1};                   
    length=size(information,2);         %读取需隐藏信息长度
    hidegraph=hide(information);        %隐藏信息 
    password=get('hidegraph.bmp',length);   %获取信息
    fid=fopen('messageget.txt','wt');
    fprintf(fid,'%s',password);         %写入信息
    fprintf(fid,'\n');
end

### 2)creatmessage.cpp

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

