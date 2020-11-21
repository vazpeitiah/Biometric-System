%
%
function A=vander_mod(X)

L=length(X);
A=zeros(L,L);

for i=1:L
    A(i,1)=1;
    V=X(i);
    for j=2:L
        A(i,j)=mod(A(i,j-1)*V,2^16);
    end
end

end

    
    