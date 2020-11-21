%
%    Fuzzy Vault Decoding
%
%     Corresponde Fig. 5 del artículo
%       "Fingerprint-based Fuzzy Vault: Implementation and Performance
%
clear;
close all;
clc;

%%%%%
ruta_completo=pwd;
%%%%%%%% Parametros %%%%%

delta1=25;  %distancia mínima que pueden tener dos minucias
delta2 =3;
beta=0.2*pi/180;  % ec. (1) radian 0.2 grado --> 0.2*pi/180 radian
FTC=20; % número mínimo de minucias requerido después de filtros
NChaff=50; %%%%%% Número de puntos falsos
%%%%%%%%% Número de bits de cuantificación 
NB_UVT=[6,6,4];   %%% Alto  0 -- 63
N_Digree = 8;
q=2^16+1;    %%% 
pol=[1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 1]; % Polinomio que usa CRC
display=1;

%%%%%%%%%%%%%%%%%%%%%%%%%   Obtener Vault        %%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
load('Vault105-1.mat');  %%%% Vault
L_Vault=size(Vault,1); % numero de minucias en template
%
%  Normalmente, la imagen de huella que genero Template y la imagen de
%  huella de consulta (query) es diferente, aunque sea misma persona.
%  Aquí para simplificar está usando la misma imagen
%
im = imread(strcat(ruta_completo,'\DB1_B\105_1.tif'));

[S1,S2]=size(im); 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%% Obtener Minucia de imagen de huella de conculta  %%%%%%%%%%%%%%

[minucia,ridgeEnd,ridgeBif ~]=obtener_minucia_consulta(im,delta1,beta,display);

N_minucia=size(minucia,1);

if N_minucia>FTC      
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%% Filtrar Chaff point usando datos de minucia de consulta %%%%%%
%%%%%%%%%%%%% Minucia Decoding & Coarse Filter %%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%% Cuantificación  de template y Chaff point %%%%%%%%%%%%%%%%%%
    Q_minucia=Quant(minucia,NB_UVT,[S1,S2,pi]);
 
%%%%%%% El valor de X de Vault, obtener datos de minucia (u,v,theta) %%%%
    [Indice_Vault,Real_minucie]=Chaff_filter(Vault,Q_minucia,NB_UVT, delta2, beta);
 
%%%%%%% Usando minucias reales, obtener llave %%%%%%%%
    L_Real=size(Indice_Vault,1);
    
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
%%%%%%%%%%%%%%%%%%%%%%  Lagrange Interpolation %%%%%%%%%%%%%%%%%%%%%%%%%%%%

    if L_Real < N_Digree+1  %%% Numero de datos reales de minucia no alcanzo para resolver Lagrange
        disp ('########  Falla de Autenticación ########');
    else
        
        Real_Data=Vault(Indice_Vault,:);
    
    %%% Generar posible combinación de N_Digree+1 datos de Real_Data %%%%%%
    
        Comb=Generar_Comb(L_Real,N_Digree+1);
        flag_key=0; % flag_key=0: no se pudo recuparar llave
                    % flag_key=1: Se recurero correctamente la llave
    
        for i=1:size(Comb,1)
            Ind=Comb(i,:);
            Seleccionados=Real_Data(Ind,:);
            X_select=Seleccionados(:,1);
            Y_select=Seleccionados(:,2);
            %%%% Obtener coeficientes de polinomio usando X_select y
            %%%% Y_select
            S=Lagrange_Poly_iter(Y_select,X_select,N_Digree+1,q,N_Digree+1);
            %%%% Aplicar CRC para revisar si hay errores o no %%%%%%%
            Posible_llave=Generar_llave(S);
        
            %% Si encuentra error, la seleccion de X y Y son erroneo
             [~,error]=CRC_res(Posible_llave,pol);
            
            if sum(error) == 0
                Key_con_redundancia = Posible_llave;  %%% Llave recuparada %%%
                Key_recuperada=Key_con_redundancia(1:end-16);
                flag_key=1;
                break;
            end
            
        end
        
        if flag_key==0
            disp('%%% hay que repetir la captura de huella %%%');
        else
            figure;
            plot(X_select, Y_select,'r*');
            title('  9 minucias coincididos entre template y consulta');
            fprintf('Llave recuperada es: \n');
            fprintf('%3d',Key_recuperada);
            fprintf('\n');
            %%%%% Averiguar si la llave recuparada es la llave de usuario
            %%%%% que uso en codificación (Vault_Encoding)
            load('Key_Usuario.mat');
            error_de_llave=sum(xor(Key,Key_recuperada));
            if error_de_llave==0
                fprintf('----- La llave recupero correctamente ---\n');
            end
            
        end
    end
    
else    
    disp(' %%%% hay que repetir la captura de huella');     
end
