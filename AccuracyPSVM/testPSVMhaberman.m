addpath('../data');

clear;
clc;
load('haberman.mat');
Data = haberman(:,2:end);
Label  = haberman(:,1);
Label(Label==2)=-1; %��2�ĳɣ�1

[w,gamma, trainCorr, testCorr, cpu_time, nu]=psvm(Data,Label,10);