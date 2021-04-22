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

