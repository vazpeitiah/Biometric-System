function Q=Quant(X, QB, MaxV)
%
%   Q: datos cuantificado
%   X: datos de entrada  NT x 3
%  QB: numero de bits

[NT,L]=size(X);

IV=zeros(1,L);
Q=zeros(size(X));

for k=1:L
    IV(k)=(MaxV(k)-eps)/(2^QB(k));
end

for i=1:NT
    for k=1:L
       Q(i,k)=min(round(X(i,k)/IV(k)),2^QB(k)-1);
    end
end


