function  y=Div_mod(q,a,b)
% (a/b) mod q
%
for i=1:b
y=(q*i+a)/b;
  if y==round(y)
    return
   end
end

