clear;clc;
X = [0.1:0.1:2]';
Y=[
0.8409
0.8409
0.8409
0.8409
0.8409
0.8409
0.8409
0.8409
0.8409
0.8409
0.875
0.875
0.875
0.875
0.875
0.875
0.875
0.875
0.875
0.875    
];


c = polyfit(X, Y,5);  %������ϣ�cΪ2����Ϻ��ϵ��
d = polyval(c, X, 1); 
plot(X, d, 'r'); 
hold on ;
%plot(X, Y,'*'); 

xlabel('p value');
ylabel('accuracy');
title('iono');

