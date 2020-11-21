function X=concatenate(Q,NB)
%
%  Concatenar
%
%   Q:tabla cuantificada
%   NB: el número de bits
%
[S,~]=size(Q);
X=zeros(1,S);
for i=1:S
    X(i)=Q(i,1)*2^(NB(2)+NB(3))+Q(i,2)*2^NB(3)+Q(i,3);
end

end