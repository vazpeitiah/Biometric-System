%
%    N: Número de elementos total
%    M: Número de elementos de sub-conjuntos
function S=Generar_Comb(N,M)
%
L=factorial(N)/(factorial(M)*factorial(N-M)); % numero total de combinación

V=1:N;

S=nchoosek(V,M);

end

 
