function [w1,w2,bias1,bias2] = svc(c,d,v)
%c��һ�����ݣ�d����һ�����ݣ�v�����ڲ���





[m,n]=size(c);e=ones(m,1);
[m2,n2]=size(d);e2=ones(m2,1);




H=[d -e2]'*[d -e2];
M=[c -e]'*[c -e];

G=M+v*speye(n+1);
L=H+v*speye(n2+1);


[A,B]=eig(G,H);%A��������B������ֵ,��һ��������Ӧ����С����ֵ
B=diag(B);

[B,index1]=min(B);

[A2,B2]=eig(L,M);

B2=diag(B2);
[B2,index2]=min(B2);

vector=A(:,index1(1,1));%�õ���һ��������Ӧ����С����ֵ
vector2=A2(:,index2(1,1));

w1=vector(1:end-1,1);
w2=vector2(1:end-1,1);

bias1=vector(end,1);
bias2=vector2(end,1);

    