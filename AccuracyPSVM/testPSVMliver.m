addpath('../data');
clear;
clc;
load('liver.mat');
Data = liver(:,2:end);
Label  = liver(:,1);
Label(Label~=1)=-1; %��2�ĳɣ�1
[w,gamma, trainCorr, testCorr, cpu_time, nu]=psvm(Data,Label,10);