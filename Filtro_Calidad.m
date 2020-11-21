%
%
function [template_ok,N_end_ok]=Filtro_Calidad(im, template,N_end)

Q=local_quality_index(im, template);

ridgeEnd=template(1:N_end,:);
ridgeBifurcation=template(N_end+1:end,:);

%%%% Eliminar minutias con la calidad baja %%%%
Mal_Calidad=Q<0.8;
ridgeEnd_ok=ridgeEnd(~Mal_Calidad(1:N_end),:);
ridgeBif_ok=ridgeBifurcation(~Mal_Calidad(N_end+1:end),:);

N_end_ok=size(ridgeEnd_ok,1);
template_ok=[ridgeEnd_ok;ridgeBif_ok];

end