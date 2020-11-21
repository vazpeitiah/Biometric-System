%
%
function D=dist_minu_data(V,Q)
%
%  D: distancia entre V y Q
% V: Un vector de Vault, puede ser de una minucia real o Chaff Point. 3
% elementos
% Q: Un vector de consulta presentado un dedo. 3 elementos
%

     D=sqrt((V(1)-Q(1))^2+(V(2)-Q(2))^2+(V(3)-Q(3))^2);

end
