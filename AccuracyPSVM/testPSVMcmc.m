addpath('../data');
clear;
clc;
load('cmc.mat');
Data = cmc(1:642,2:end);
Label  = cmc(1:642,1);
Label(Label~=1)=-1; %��2�ĳɣ�1
[w,gamma, trainCorr, testCorr, cpu_time, nu]=psvm(Data,Label,10);