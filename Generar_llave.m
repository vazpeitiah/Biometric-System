%
%
function llave=Generar_llave(S)

L=length(S);
llave=zeros(1,16*L);
ini=1;
for i=L:-1:1
    llave(ini:ini+15)=double(dec2bin(S(i),16))-48;
    ini=ini+16;
end

end

    