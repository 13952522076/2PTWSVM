addpath('../data');
clear;
clc;
load('sonar.mat');

Data = A(:,2:end);




Label  = A(:,1);
Label(Label==0)=-1; %��0�ĳɣ�1
[w,gamma, trainCorr, testCorr, cpu_time, nu,testcorrstd]=psvm2(Data,Label,10);
testCorr
cpu_time
testcorrstd