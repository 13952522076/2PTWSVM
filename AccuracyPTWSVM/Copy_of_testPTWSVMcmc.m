addpath('../data');
clear;
clc;
load('cmc.mat');

A = cmc(1:642,:);


avg = repmat(mean(A,1), size(A,1), 1);
avg(:,1) = 0;
A = A-avg;


trainX = A(1:2:end,:);
testX = A(2:2:end,:);

AA = trainX(find(trainX(:,1)==1),:);
AA = AA(:,2:end);
BB = trainX(find(trainX(:,1)~=1),:);
BB = BB(:,2:end);
 
X = testX(:,2:end);
label = testX(:,1);
label(label~=1) = 0;
result=[];
% 0.7259    1.6000    0.3000    0.9000
for p = 0.1:0.1:2
    p
    for c1=0.1:0.1:2
        for c2=0.1:0.1:2
            [ w1] = svc( AA,BB,p,c1);
            [ w2 ] = svc( BB,AA,p,c2);
            [ accuracyValue ] = accuracy( w1,w2,X ,label);
            result=[result;accuracyValue p c1 c2];
        end
    end
end


