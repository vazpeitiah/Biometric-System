%%%%
%
%    Lagrange Iterativo %%%%%%
%
clear;

load('Vault105-1.mat');
N=9;
%%%%%% Obtener primer N pares de datos %%%%
X=Vault(1:N,1);  % 9 Valores de X
Y=Vault(1:N,2);  % P(X) 

gf=2^16+1;  % Primo 

Coeff=Lagrange_Poly_iter(Y,X,N,gf,N)
