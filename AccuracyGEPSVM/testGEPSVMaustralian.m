%�԰����

addpath('../data');
clear;clc;
load('australian.mat');

Label = A(:,1);
Data = A(:,2:end);
Label(Label~=1)=-1; %������ŷ�Ϊ1�ͣ�1

trainData = Data(1:345,:);
trainLabel= Label(1:345,:);

testData = Data(346:end,:);
testLabel = Label(346:end,:);
v =90;

[accuracy ] = gepsvm(trainData,trainLabel,testData,testLabel,v)