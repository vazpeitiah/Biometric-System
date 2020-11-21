%
%
function Q=local_quality_index(im, template)

NT=size(template,1);
im=double(im);
Q=zeros(1,NT);
for i=1:NT
    x=template(i,1);
    y=template(i,2);
    
   % fprintf('x=%d  y=%d \n', x,y);
%     im2=im;
%     im2(x-1:x+1,y-1:y+1)=zeros(3,3);
%     figure(2);
%     imshow(im2);
  gx1=im(x-1,y)-im(x,y);
  gx2=im(x,y)-im(x+1,y);
  gy1=im(x,y-1)-im(x,y);
  gy2=im(x,y)-im(x,y+1);
  J1=[gx1*gx1,gx1*gy1;gy1*gx1,gy1*gy1];
  J2=[gx2*gx2,gx2*gy2;gy2*gx2,gy2*gy2];
  lamda1 = (trace(J1)+ sqrt(trace(J1)^2-4*det(J1)))/2;
  lamda2 = (trace(J1)- sqrt(trace(J1)^2-4*det(J1)))/2;
%   i
%   lamda1
%   lamda2
  %J1
  %J2
  if(J1(1,1)+J1(2,2))==0 
      k1=0;
  else
  k1=((J1(1,1)-J1(2,2))^2+4*J1(1,2)*J1(1,2))/((J1(1,1)+J1(2,2))^2);
  end
  
  if(J2(1,1)+J2(2,2))==0 
      k2=0;
  else
  k2=((J2(1,1)-J2(2,2))^2+4*J2(1,2)*J2(1,2))/((J2(1,1)+J2(2,2))^2);
  end
  
  Q(i)=(k1+k2)/2;
  %fprintf('quality %f \n', Q(i));
  
end
