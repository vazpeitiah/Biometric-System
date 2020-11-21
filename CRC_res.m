function  [New_Key,RD]=CRC_res(Key,pol)

NP=length(pol);

New_Key=[Key,zeros(1,NP-1)];
Ind=find(New_Key==1,1);
R=New_Key(Ind:end);
NK=length(R);

while NK>=NP
 D=NK-NP;
 z=zeros(1,D);
 
 pol_f=cat(2,pol,z);
 
 Q=xor(R,pol_f);
 ind=find(Q==1,1);
 R=Q(ind:end);
 NK=length(R);
end

RD=zeros(1,NP-1);
L=length(R);
RD(end-L+1:end)=R;

New_Key(end-NP+2:end)=RD;

