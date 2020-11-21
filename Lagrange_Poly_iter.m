%
%  Resolver polynomio de Lagrange iterativamente
%  para obtener todos los coeficientes
%
function S=Lagrange_Poly_iter(F,X,k,q,c)
%
%   X: entrada de Polinomio de Lagrange
%   F: resultado de PolinomioLagrange 
%   k: Orden de plinomio +1 
%   q: modulo
%   c: numero de coeficiemntes que desea recuperar

S=zeros(1,k);
S(1)=Lagrange_Poly2(F,X,q,k);

G=F;
for t=2:c
  for i=1:k
    G(i)=Div_mod(q,mod(G(i)-S(t-1),q),X(i));
  end

  S(t)=Lagrange_Poly2(G,X,q,k-t+1);
end


