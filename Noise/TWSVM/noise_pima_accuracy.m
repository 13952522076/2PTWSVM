addpath('../../data');

clear;
clc;
load('pimadata.mat');
load('../NoiseData/NoisePima.mat');
A = A + 5*NoisePima;

Train = A(1:300,:);
Test = A(301:end,:);
TrainLabel = d(1:300,:);
TestLabel = d(301:end,:);

AA = Train(find(TrainLabel(:,1)==1),:);
BB = Train(find(TrainLabel(:,1)==-1),:);
 
[w1,w2,b1,b2] = svc(AA,BB,1,1);
w1 = [w1;b1;];
w2 = [w2;b2];


X = Test;
label = TestLabel(:,1);
label(label~=1) = 0;
[ accuracy ] = accuracy( w1,w2,X ,label);