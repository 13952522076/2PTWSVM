addpath('../data');
clear;
clc;
load('australian.mat');
Data = A(:,2:end);
Label  = A(:,1);
Label(Label==0)=-1; %��2�ĳɣ�1
[w,gamma, trainCorr, testCorr, cpu_time, nu]=psvm(Data,Label,10);