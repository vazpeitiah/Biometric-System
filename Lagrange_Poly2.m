%%%%
%
%    Lagrange Iterativo %%%%%%
%
function S=Langange_Poly2(Y,X,gf,N)

k=N-1;
Signo =(-1)^(k);

%%%%%%% Obtener numerador %%%%%%
Numerador=ones(1,N);

for i=1:N
    for j=1:N
        if i~=j
            Numerador(i)=mod(Numerador(i)*X(j),gf);
        end
    end
    Numerador(i)=mod(Numerador(i)*Y(i),gf);
end

%%%%%%% Obtener denominador %%%%%%
Denominador=ones(1,N);
for i=1:N
    for j=1:N
        if i~=j
            sub=mod(X(i)-X(j),gf);
            Denominador(i)=mod(Denominador(i)*sub,gf);
        end
    end
end

S=0;
Parte=zeros(1,N);
for i=1:N
    
    Parte(i)=Div_mod(gf,Numerador(i), Denominador(i));
    S=mod(S+Parte(i),gf);
end
S=mod(Signo*S,gf);



