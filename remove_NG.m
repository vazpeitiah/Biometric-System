%
%
function RES=remove_NG(Chaff_Data,pos)
%

Ind=setdiff([1:length(Chaff_Data)],pos);

RES=Chaff_Data(Ind,:);

end
