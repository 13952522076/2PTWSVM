function [w1,w2,bias1,bias2]=ksvc(c,d,C,Y); 




v=C;


[m,n]=size(c);e=ones(m,1);
[m2,n2]=size(d);e2=ones(m2,1);

G=[c -e]'*[c -e]+v*speye(n+1);
H=[d -e2]'*[d -e2];

L=[d -e2]'*[d -e2]+v*speye(n2+1);
M=[c -e]'*[c -e];

[A,B]=eig(G,H);%A��������B������ֵ,��һ��������Ӧ����С����ֵ
[A2,B2]=eig(L,M);
vector=A(:,1);%�õ���һ��������Ӧ����С����ֵ
vector2=A2(:,1);

w1=vector(1:end-1,1);
w2=vector2(1:end-1,1);

bias1=vector(end,1);
bias2=vector2(end,1);
    
  end
    
