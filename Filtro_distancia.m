%
%   Eliminar uno de dos minucias con menor distancia
%
function [Template_final,N_end_final]=Filtro_distancia(Template, delta1, beta,N_end_ok)

NT=size(Template,1);
N_Bif_ok=NT-N_end_ok;
DMat=ones(NT,NT)*inf;
for i=1:NT
    for j=i+1:NT
        D1=dist_ec(Template(i,1:2),Template(j,1:2));
        D2=abs(Template(i,3)-Template(j,3))*beta;
        DMat(i,j)=D1+D2;
    end  
end

%%%%%%% Seleccionar distancia es menor que 25  delta1 = 25 %%%%%

[Pos1,Pos2]=find(DMat<delta1);

%%%%%%% Eliminar Pos2 %%%%%%%%
Ind_end_ok=ones(1,N_end_ok);
Ind_Bif_ok=ones(1,N_Bif_ok);
for k=1:length(Pos1)
 if Pos2(k)<=N_end_ok
     Ind_end_ok(Pos2(k))=0;
 else
    Pos2_bf=Pos2(k)-N_end_ok;
     Ind_Bif_ok(Pos2_bf)=0;
 end
 
end

ridgeEnd=Template(1:N_end_ok,:);
ridgeBif=Template(N_end_ok+1:end,:);

ridgeEnd_final=ridgeEnd(logical(Ind_end_ok),:);
ridgeBif_final=ridgeBif(logical(Ind_Bif_ok),:);
N_end_final = size(ridgeEnd_final, 1);
Template_final=[ridgeEnd_final;ridgeBif_final];