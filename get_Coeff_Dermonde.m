%
%   B = A *C
%   C= inv(A)*B

function C=get_Coeff_Dermonde(Data)

X=Data(:,1);
B=Data(:,2);

A=vander_mod(X);
Ainv=MatModInv(A,2^16);
C=mod(Ainv*B,2^16);

end




