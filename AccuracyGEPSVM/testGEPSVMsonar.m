%�԰����

addpath('../data');
clear;clc;
load('sonar.mat');

%����������������
%B(1:size(A,1),:)=A(randperm(size(A,1))',:);
%A=B;

Label = A(:,1);
Data = A(:,2:end);
Label(Label~=1)=-1; %������ŷ�Ϊ1�ͣ�1

trainData = Data(1:2:end,:);
trainLabel= Label(1:2:end,:);

testData = Data(2:2:end,:);
testLabel = Label(2:2:end,:);
v =4;

[accuracy ] = gepsvm(trainData,trainLabel,testData,testLabel,v)