%�ֺ�

addpath('../data');
clear;clc;
load('monk1.mat');

trainData = train(:,2:end);
trainLabel= train(:,1);
trainLabel(trainLabel~=1)=-1; %������ŷ�Ϊ1�ͣ�1

testData = test(:,2:end);
testLabel = test(:,1);
testLabel(testLabel~=1)=-1; %������ŷ�Ϊ1�ͣ�1

v =100;

[accuracy ] = gepsvm(trainData,trainLabel,testData,testLabel,v)