%%%%
%
%    Lagrange Iterativo %%%%%%
%
clear;

load('Vault105-1.mat');
N=9;
q=2^16+1;
%%%%%% Obtener primer N pares de datos %%%%
X=Vault(1:N,1);
Y=Vault(1:N,2);

S=Lagrange_Poly_iter(Y,X,N,q,N);

