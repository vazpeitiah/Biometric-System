%
%   Prueba de generación de Chaff Points
%
%   Recibir Template final y agregar chaff point con las siguientes
%   condiciones:
%
%   1. Chaff point  0<u<U , 0<v<V, 0<Theta<pi
%        U: alto de la imagen
%        V: ancho de la imagen
%       
%   2. Todos los Chaff point tiene distancia mayor que minucias existentes
%   y otros chaff points generados previamente

function Z=generate_chaff_points(I,Template, delta, NChaff, beta)
%
%  Templete:  Template final después de evaluación de calidad
%  delta: un valor umbral
%  

[U,V]=size(I);  % tamaño de la imagen
rng('shuffle')
T_size=size(Template,1);
All_TP=zeros(T_size+NChaff,3);
All_TP(1:T_size,:)= Template;
%%%%% Generar NChaff puntos falsas %%%%%

N=0;
Z=zeros(NChaff,3);
while N < NChaff
   
    u_r=randi(U);
    v_r=randi(V);
    theta=rand(1)*pi;
    Candidato=[u_r,v_r,theta];
    
    if check_dist(Candidato,All_TP, N+T_size, beta, delta)  
     N=N+1;
     Z(N,:)=Candidato;
     All_TP(T_size+N,:)=Candidato;
    end
   
end

end


function Flag=check_dist(C,TP,Npuntos, beta,delta)
   
   Flag=1;
   
   for k=1:Npuntos
    D1=dist_ec(C(1:2),TP(k,1:2));
    D2=abs(C(3)-TP(k,3))*beta;
    if (D1+D2)< delta
        Flag=0;
        break;
    end
   end
end


