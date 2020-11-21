%
%
function  NG=Check_Chaff_Data(Chaff_Data, Coef)

X=Chaff_Data(:,1);
Y_real=Chaff_Data(:,2);

XY=Eval_poly(Coef,X);

Y_poly=XY(:,2);

L=length(Y_real);
D=abs(Y_real-Y_poly);

NG=D<20;

end

 
