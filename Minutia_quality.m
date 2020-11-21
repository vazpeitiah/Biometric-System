clear;
close all;
clc;

template = [];

%get the images for matching
% im1 = getimage('Select 1st Fingerprint image');
% im2 = getimage();
im = imread('H:\Biometricas_Watermarking\DB1_B\105_1.tif');
%im = imread('H:\Biometricas_Watermarking\DB1_B\106_7.tif');

%extract the template for the image
display = 1;
%template1 = extractminutae(im1,display)

[ridgeEnd,ridgeBifurcation] = extractminutae2(im,display);
template = [ridgeEnd;ridgeBifurcation];

NT=size(template,1);

Q=local_quality_index(im, template);

%%%% Eliminar minutias con la calidad baja %%%%
Mal_Calidad=Q<0.8;
N_end=size(ridgeEnd,1);
N_bif=size(ridgeBifurcation,1);
ridgeEnd_ok=ridgeEnd(~Mal_Calidad(1:N_end),:);
ridgeBif_ok=ridgeBifurcation(~Mal_Calidad(N_end+1:end),:);

N_end_ok=size(ridgeEnd_ok,1);
N_Bif_ok=size(ridgeBif_ok,1);

template_ok=[ridgeEnd_ok;ridgeBif_ok];
NT_ok=size(template_ok,1);
% Identify ridge-like regions and normalise image
blksze = 16; thresh = 0.1; margin=20;
[normim, mask] = ridgesegment(im, blksze, thresh, margin);

show_minutia(normim, ridgeEnd_ok, ridgeBif_ok, 'Minutiae Good Quality');

%%%%%%%% Obtener distancia %%%%%%%
DMat=ones(NT_ok,NT_ok)*inf;
beta=0.2*180/pi;
for i=1:NT_ok
    for j=i+1:NT_ok
        D1=dist_ec(template_ok(i,1:2),template_ok(j,1:2));
        D2=abs(template_ok(i,3)-template_ok(j,3))*beta;
        DMat(i,j)=D1+D2;
    end  
end

%%%%%%% Seleccionar distancia es menor que 25  delta1 = 25 %%%%%
delta1=25;
[Pos1,Pos2]=find(DMat<delta1);

%%%%%%% Eliminar Pos2 %%%%%%%%
Ind_end_ok=ones(1,N_end_ok);
Ind_Bif_ok=ones(1,N_Bif_ok);
for k=1:length(Pos2)
 if Pos2(k)<=N_end_ok
     Ind_end_ok(Pos2(k))=0;
 else
    Pos2_bf=Pos2(k)-N_end_ok;
     Ind_Bif_ok(Pos2_bf)=0;
 end
end

ridgeEnd_final=ridgeEnd_ok(logical(Ind_end_ok),:);
ridgeBif_final=ridgeBif_ok(logical(Ind_Bif_ok),:);

show_minutia(normim, ridgeEnd_final, ridgeBif_final, 'Minutiae Final');  

template_final=[ridgeEnd_final;ridgeBif_final];

NTF=size(template_final,1);


