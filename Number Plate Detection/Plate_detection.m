close all;
clear all;

im = imread('Number Plate Images/2.jpg');
org = im;
imgray = rgb2gray(im);
imbin = imbinarize(imgray);
im = edge(imgray, 'prewitt');

%Below steps are to find location of number plate
Iprops=regionprops(im,'BoundingBox','Area', 'Image');
area = Iprops.Area;
count = numel(Iprops);
maxa= area;
boundingBox = Iprops.BoundingBox;
for i=1:count
   if maxa<Iprops(i).Area
       maxa=Iprops(i).Area;
       boundingBox=Iprops(i).BoundingBox;
   end
end
%figure
subplot(2,2,2)
title('Edged, Props');
imshow(im)
%figure
im = imcrop(imbin, boundingBox);%crop the number plate area
subplot(2,2,3)
title('cropped');
imshow(imbin);
im = bwareaopen(~im, 100); %remove some object if it width is too long or too small than 100

 [h, w] = size(im);%get width
subplot(2,2,4)
title('Plate Detected');
imshow(im);


Iprops=regionprops(im,'BoundingBox','Area', 'Image'); %read letter
%Iprops
count = numel(Iprops);
%count
noPlate=[]; % Initializing the variable of number plate string.

for i=1:count
   ow = length(Iprops(i).Image(1,:));
   %ow
   oh = length(Iprops(i).Image(:,1));
   %oh
   %h
   if ow<(w/2) & oh>(h/4)
       letter=Letter_detection(Iprops(i).Image); % Reading the letter corresponding the binary image 'N'.
       letter
       noPlate=[noPlate letter] % Appending every subsequent character in noPlate variable.
   end
end
%figure
subplot(2,2,1)
title('Original image');
imshow(org);