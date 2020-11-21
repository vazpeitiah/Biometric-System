%
%  Resolver polynomio de Lagrange
%

function Ext_S=Lagrange_Poly(F,X,k,q)
%
%   X: entrada de Polinomio de Lagrange
%   F: resultado de Lagrange 
%   k: El orden de Polinomio de Lagrange
%   q: modulo (tiene que ser primo)

X=double(X);
  S=0;
for i=1:k
     M1=1;
     M2=1;
    for j=1:k
        if j~=i
          M1=mod(M1*X(j),q);
          M2=mod(M2*(X(i)-X(j)),q);
        end
    end
    
    S=S+F(i)*Div_mod(q,M1,abs(M2))*sign(M2);
end
Ext_S=mod(((-1)^(k-1))*S,q);


    

        
        

