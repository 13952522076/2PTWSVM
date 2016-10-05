addpath('../data');

clear;
clc;
load('ionodata.mat');

%% 是否需要中心化



AA = A(find(d(:,1)==1),:);
%AA = AA(:,2:end);
BB = A(find(d(:,1)==-1),:);
%BB = BB(:,2:end);
 


p=3;  
c1 =0.5;
c2 =1;
[ w1 ] = svc( AA,BB,p,c1);
[ w2 ] = svc( BB,AA,p,c2);




X = A;
label = d;
label(label~=1) = 0;
[ accuracy ] = accuracy( w1,w2,X ,label);