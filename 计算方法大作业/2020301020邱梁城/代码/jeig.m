function [X,D]=jeig(A,B);
L=chol(B,'lower');
G=inv(L);
C=G*A*G';
[Q,D]=schur(C);  %Q��һ����������  D��һ�������Ǿ���
X=G'*Q; 