addpath('../data');

clear;
clc;
load('germ.mat');
Data = A(:,2:end);




Label  = A(:,1);
Label(Label==2)=-1; %��2�ĳɣ�1

[w,gamma, trainCorr, testCorr, cpu_time, nu,std]=psvm2(Data,Label,10);
testCorr
cpu_time
std
