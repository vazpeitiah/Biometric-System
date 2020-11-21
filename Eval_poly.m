%
%
%
function  XY=Eval_poly(Coef,Data)

N=length(Coef);

XY=zeros(length(Data),2);
gf=2^16+1;
for k=1:length(Data)
    Y=0;
    X=Data(k);
   
  %%%%%% Calcular potencial de X %%%%%
  PW=ones(1,N);
  for i=2:N
      PW(i)= mod(PW(i-1)*X,gf);
  end
  
  for j=1:N
      Y=Y+mod(Coef(N-j+1)*PW(j),gf);
  end
  
  XY(k,:)=[X,mod(Y,gf)];
end

end