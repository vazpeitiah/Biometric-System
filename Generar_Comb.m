%
%    N: N�mero de elementos total
%    M: N�mero de elementos de sub-conjuntos
function S=Generar_Comb(N,M)
%
L=factorial(N)/(factorial(M)*factorial(N-M)); % numero total de combinaci�n

V=1:N;

S=nchoosek(V,M);

end

 
