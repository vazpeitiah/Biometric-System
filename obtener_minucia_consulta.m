%
%   template = generar_template(im, delta1, beta, display)
%
%   Dado una imagen de de huella, extrae tenplate
%
function [minucia_consulta, ridgeEnd_final, ridgeBif_final, normim] = obtener_minucia_consulta(im,delta1,beta,display)

%template1 = extractminutae(im1,display)

[ridgeEnd,ridgeBifurcation] = extractminutae2(im,display);
N_end=size(ridgeEnd,1);
N_bif=size(ridgeBifurcation,1);
template = [ridgeEnd;ridgeBifurcation];
NT=size(template,1);

%%%%%% Evaluación de la calidad de minucias y eliminar minucias con mala
%%%%%% calidad %%%

[template_ok,N_end_ok]=Filtro_Calidad(im, template, N_end);

NT_ok=size(template_ok,1);
% Identify ridge-like regions and normalise image
blksze = 16; thresh = 0.1; margin=20;
[normim, mask] = ridgesegment(im, blksze, thresh, margin);

ridgeEnd_ok=template_ok(1:N_end_ok,:);
ridgeBif_ok=template_ok(N_end_ok+1:end,:);
show_minutia(normim, ridgeEnd_ok, ridgeBif_ok, 'Minutiae Good Quality');

%%%%%%%% Obtener distancia %%%%%%%
%%%%%% Filtrar huellas por distancias %%%%%

[minucia_consulta,N_end_final]=Filtro_distancia(template_ok, delta1, beta, N_end_ok);


ridgeEnd_final=minucia_consulta(1:N_end_final,:);
ridgeBif_final=minucia_consulta(N_end_final+1:end,:);

show_minutia(normim, ridgeEnd_final, ridgeBif_final, 'Minutiae Final');  

end
