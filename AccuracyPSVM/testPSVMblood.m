addpath('../data');
clear;
clc;
load('blood.mat');

Data = blood(:,2:end);
Max=max(max(Data));
Min=min(min(Data));
Data=2*(Data-Min)./(Max-Min)-1;


label = blood(:,1);
label(label~=1)=-1; %�ĳɣ�1

[w,gamma, trainCorr, testCorr, cpu_time, nu,std]=psvm2(Data,label,10);
testCorr
cpu_time
std