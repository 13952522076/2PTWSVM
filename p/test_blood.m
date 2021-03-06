addpath('../data');

clear;
clc;
load('blood.mat');

train = blood(1:374,:);
test = blood(375:end,:);

AA = train(find(train(:,1)==1),:);
AA = AA(:,2:end);
BB = train(find(train(:,1)~=1),:);
BB = BB(:,2:end);
 



c1 =0.05;
c2 =0.05;
X = test(:,2:end);
label = test(:,1);
label(label~=1) = 0;


accuracyList=[];
for p=0.1:0.1:2
    [ w1] = svc( AA,BB,p,c1);
    [ w2 ] = svc( BB,AA,p,c2);
    [ accuracyValue ] = accuracy( w1,w2,X ,label);
    accuracyList=[accuracyList;accuracyValue];
end