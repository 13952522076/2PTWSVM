addpath('../data');
clear;
clc;


load('cancer.mat');
Data = A(:,2:end);
Label  = A(:,1);
Label(Label~=1)=-1; %��2�ĳɣ�1


[w,gamma, trainCorr, testCorr, cpu_time, nu]=psvm(Data,Label,10);