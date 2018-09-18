clear;
clc; 

%up load picture
tiffColor = imread('pic.tiff');
pngColor = imread('pic.png');
jpgColor = imread('pic.jpg');
gifColor = imread('pic.gif');
bmpColor = imread('pic.bmp');

jpg = rgb2gray(jpgColor);

pix1 = size(jpgColor,1);
pix2 = size(jpgColor,2);

 %Histrogram
 for a=1:256
     jpgHis(a) = 0;
 end
 for u=1:pix1
     for v=1:pix2
         count = jpg(u,v);
         if count==255
             jpgHis(256)=jpgHis(256)+1;             
         else
             jpgHis(count+1)=jpgHis(count+1)+1;
         end
     end
 end

%subplot(3,2,1); plot(tiffHis);
%subplot(3,2,2); plot(pngHis);
%subplot(3,2,3); plot(jpgHis);
%subplot(3,2,4); plot(gifHis);
%subplot(3,2,5); plot(bmpHis);

 %Comulative
 com(1) = jpgHis(1);
 for i = 2:256
     com(i) = com(i-1)+jpgHis(i);
 end
 
 %Equalization
 cdfmin = min(com);
 MxN = pix1*pix2;
 for j = 1:256;
     eq(j) = round(((com(j)-cdfmin)/(MxN-cdfmin))*255);
 end
 
 %convert to image
 newim = uint8(zeros(1568,1044));
 for row=1:pix1
     for c=1:pix2
         value = jpg(row,c);
         if value==255
             newim(row,c)=eq(256); 
         else
             newim(row,c)=eq(value+1);
         end
     end
 end
 
 %new Image Histrogram
newimHis = zeros(1,256);
 for u=1:pix1
     for v=1:pix2
         count = newim(u,v);
         if count==255
             newimHis(256)=newimHis(256)+1;             
         else
             newimHis(count+1)=newimHis(count+1)+1;
         end
     end
 end
 
 %Comulative new Image
 newimcom(1) = newimHis(1);
 for i = 2:256
     newimcom(i) = newimcom(i-1)+newimHis(i);
 end
  
 subplot(2,3,1); imshow(jpg);
 subplot(2,3,2); plot(jpgHis);
 subplot(2,3,3); plot(com);
 subplot(2,3,4); imshow(newim);
 subplot(2,3,5); plot(newimHis);
 subplot(2,3,6); plot(newimcom);