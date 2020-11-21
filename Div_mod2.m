function  y=Div_mod2(q,a,b)
% (a/b) mod q
%
for i=1:q-1
 if mod(b*i,q)==a
     y=i;
     return;
 end
end

