function [final]=fftenhance(image,f)

I = 255-double(image);

[w,h] = size(I);
%out = I;

w1=floor(w/32)*32;
h1=floor(h/32)*32;

inner = zeros(w1,h1);

for i=1:32:w1
   for j=1:32:h1
      a=i+31;
      b=j+31;
      F=fft2( I(i:a,j:b) );
      factor=abs(F).^f;
      block = abs(ifft2(F.*factor));
      
      larv = max(block(:));
      %avoid divide by zero
      if larv==0
         larv=1;
      end;
      
      block= block./larv;
      inner(i:a,j:b) = block;
   end;
end;

maxi = max(inner(:));
mini = min(inner(:));

%normalize
inner = inner - mini;
inner=(inner/(maxi-mini))*255;

%make image of the same size as input 
% clipping of at the boundary.
image(1:w1, 1:h1) = inner;
iamge(w1:w, h1:h) = 0;

final = image;
final=histeq(uint8(final));

