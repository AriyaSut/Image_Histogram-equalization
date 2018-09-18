clear;
clc; 

%up load picture
tiffColor = imread('pic.tiff');
pngColor = imread('pic.png');
jpgColor = imread('pic.jpg');
gifColor = imread('pic.gif');
bmpColor = imread('pic.bmp');

tiff = rgb2gray(tiffColor);
png = rgb2gray(pngColor);
jpg = rgb2gray(jpgColor);
%gif = rgb2gray(gifColor);
bmp = rgb2gray(bmpColor);

pix1 = size(jpgColor,1);
pix2 = size(jpgColor,2);

 %Histrogram
 tiffHis = zeros(1,256);
 for u=1:pix1
     for v=1:pix2
         count = tiff(u,v);
         if count==255
             tiffHis(256)=tiffHis(256)+1;             
         else
             tiffHis(count+1)=tiffHis(count+1)+1;
         end
     end
 end
 
 pngHis = zeros(1,256);
 for u=1:pix1
     for v=1:pix2
         count = png(u,v);
         if count==255
             pngHis(256)=pngHis(256)+1;             
         else
             pngHis(count+1)=pngHis(count+1)+1;
         end
     end
 end
 
 jpgHis = zeros(1,256);
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
 
 gifHis = zeros(1,256);
 for u=1:pix1
     for v=1:pix2
         count = gifColor(u,v);
         if count==255
             gifHis(256)=gifHis(256)+1;             
         else
             gifHis(count+1)=gifHis(count+1)+1;
         end
     end
 end
 
 bmpHis = zeros(1,256);
 for u=1:pix1
     for v=1:pix2
         count = bmp(u,v);
         if count==255
             bmpHis(256)=bmpHis(256)+1;             
         else
             bmpHis(count+1)=bmpHis(count+1)+1;
         end
     end
 end

subplot(3,2,1); plot(tiffHis); title('.tiff Histogram')
subplot(3,2,2); plot(pngHis); title('.png Histogram')
subplot(3,2,3); plot(jpgHis); title('.jpg Histogram')
subplot(3,2,4); plot(gifHis); title('.gif Histogram')
subplot(3,2,5); plot(bmpHis); title('.bmp Histogram')
figure;
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
  
 subplot(2,3,1); imshow(jpg); title('Picture')
 subplot(2,3,2); plot(jpgHis); title('Histogram')
 subplot(2,3,3); plot(com); title('Cumulative Histogram')
 subplot(2,3,4); imshow(newim);
 subplot(2,3,5); plot(newimHis);
 subplot(2,3,6); plot(newimcom);