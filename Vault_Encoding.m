%
%   Vault Encoding 
%
%     Corresponde Fig. 4 del artículo
%       "Fingerprint-based Fuzzy Vault: Implementation and Performance
%
clear;
close all;
clc;

%%%%%
ruta_completo=pwd;
%%drive=ruta_completo(1:3);
%%%%%%%% Parametros %%%%%

delta1=25;  %distancia mínima que pueden tener dos minucias
beta=0.2*pi/180;  % ec. (1) radian 0.2 grado --> 0.2*pi/180 radian
FTC=20; % número mínimo de minucias requerido después de filtros
NChaff=50; %%%%%% Número de puntos falsos
%%%%%%%%% Número de bits de cuantificación 
NB_UVT=[6,6,4];   %%% Alto  0 -- 63
semilla = 1; %% semilla parta generar llave%%%%%%
semilla_perm=2; %% semilla para permutación de de datos de Vault -- mezclar datos real y chaffpoints
n_degree = 8; % El orden de polynomio P(x) %%%%%% Polinomio %%%%%%
pol=[1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 1]; %% Polinomio que usa CRC
display = 1;

im = imread(strcat(ruta_completo,'\platillas_huellas\101_7.tif'));

[S1,S2]=size(im); %%%% El tamaño de la imagen

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%% Generación de template %%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% 1. Extracción de minucias
% 2. Eliminar minucias de mala calidad 
% 3. Eliminar minucias muy cercanas a otras minucias

[template, ridgeEnd, ridgeBif, normim] = generar_template(im, delta1, beta, display);

NT_final=size(template,1);

fprintf(' El número de minucias válido es %d \n',NT_final);

if NT_final>FTC  
    
Chaff_points=generate_chaff_points(im, template, delta1, NChaff, beta);
show_minutia_all(normim, ridgeEnd, ridgeBif, Chaff_points, 'Minutiae and Chaff');      

else
    disp(' %%%% hay que repetir la captura de huella'); 
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%% Cuantificación  de template y Chaff point %%%%%%%%%%%%%%%%%%
 
     Q_template=Quant(template,NB_UVT,[S1,S2,pi]);
     Q_Chaff=Quant(Chaff_points,NB_UVT,[S1,S2,pi]);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% Concatenación de tres valores posición (x,y) de minucia y angulo %%%%%%
     Temp=concatenate(Q_template,NB_UVT);
     Chaf=concatenate(Q_Chaff,NB_UVT);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%        CRC coding       %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%   Generar lleve nueva con capacidad de detección de error 

L=n_degree*16;
rng(semilla);  %%%%%%% seed =llave --- llave de la persona 
A=rand(1,L);
Key=A>0.5;  %%%% llave de usuariio original 

[New_Key,~] = CRC_res(Key,pol); 

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%      Generar polinomio %%%%%%%%%%%
V=zeros(n_degree+1,16);
Coef=zeros(1,n_degree+1);
q=15:-1:0;
for k=1:n_degree+1
    V(k,:)=New_Key((k-1)*16+1:k*16);
    Coef(k)=sum(V(k,:).*(2.^q));
end

save('coef_pol.txt','Coef', '-ascii');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%% %%%%%%%%%%%%% Evaluar polinomio  en GF(2^16)%%%%%%%%%%%%%%%%%%%%%%
   
 Real_XY=Eval_poly(Coef,Temp);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
%%%%%%%%%%%%%%%%%%%%% Generar Chaff pointos aleatoriamente         %%%%%%%%
%%%%%%%  Pero cuidando que no se coincide con la proyección de polinomio %%  
    
 Z=randi(2^16,NChaff, 1); 
 Chaff_Data =[Chaf',Z];
 
 NG=Check_Chaff_Data(Chaff_Data, Coef);
 if sum(NG)~=0
     pos=find(NG~=0);
     Chaff_Data=remove_NG(Chaff_Data,pos);
 end
 
figure;
plot(Real_XY(:,1), Real_XY(:,2),'r*');
hold on
plot(Chaff_Data(:,1),Chaff_Data(:,2),'co');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%      Construcción de Vault                %%%%%%%%%%%%

All_Data=[Real_XY;Chaff_Data];   %%%% Real data + Chaff data
rng(semilla_perm);
Pind=randperm(size(All_Data,1)); %%%% mezcular todos los datos
Vault = All_Data(Pind,:);                %%% Aplicar permutación
figure;
plot(Vault(:,1),Vault(:,2),'v');

save('resultados/Vault.txt','Vault', '-ascii'); %%%% Fuzzy Vault V=(A,B), A: valores de X de polynomio
                                %%%%                      B: resultado de
                                %%%%                      polinomio B=f(A)
                                %%%%   
save('resultados/KeyUsuario.txt','Key', '-ascii');

    


