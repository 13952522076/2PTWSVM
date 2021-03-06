addpath('../../data');

clear;
clc;
load('monk1.mat');
load('../NoiseData/NoiseMonk1Train.mat');
load('../NoiseData/NoiseMonk1Test.mat');


train  = train+5*NoiseMonk1Train;
test  = test+5*NoiseMonk1Test;




AA = train(find(train(:,1)==1),:);
AA = AA(:,2:end);
BB = train(find(train(:,1)==0),:);
BB = BB(:,2:end);
 
[w1,w2,b1,b2] = svc(AA,BB,1,1);
w1 = [w1;b1;];
w2 = [w2;b2];


X = test(:,2:end);
label = test(:,1);
label(label~=1) = 0;
[ accuracy ] = accuracy( w1,w2,X ,label);