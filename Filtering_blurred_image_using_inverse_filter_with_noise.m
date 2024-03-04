clc,clear;

I=rgb2gray((imread('img1.png')));
subplot(3,3,1),imshow(I);
title('Original Gray Image');
% subplot(2,3,1), imhist(I);
% title('Original Gray Image')
shake = 24;
angle = 13;
PSF = fspecial('motion',shake,angle);

I1double = im2double(I);
blurred1 = imfilter(I1double,PSF,'conv','circular');
subplot(3,3,2),imshow(blurred1);
title('Blurred Image with no noise')
% subplot(2,3,2), imhist(blurred);
% title('Blurred Image with no noise')

wnr1 = deconvwnr(blurred1,PSF);
subplot(3,3,3),imshow(wnr1);
title('Restored Blurred Image with no noise')
% subplot(2,3,3), imhist(wnr1);
% title('Restored Blurred Image with no noise')

I2double = im2double(I);
blurred2 = imfilter(I2double,PSF,'conv','circular');
subplot(3,3,4),imshow(blurred2);
title('Blurred Image with no noise')
% subplot(2,3,2), imhist(blurred2);
% title('Blurred Image with no noise')

%speckle noise filter
I_sp=imnoise(blurred2,'speckle', 0.05);
subplot(3,3,5),imshow(I_sp);
title('image with speckle noise')
% subplot(2,3,4), imhist(I_sp);
% title('Blurred image with Speckle noise')

Y=medfilt2(I_sp,[3 3]);
subplot(3,3,6),imshow(Y);
title('MedFilt')

wnr2 = deconvwnr(Y,PSF);
subplot(3,3,7),imshow(wnr2);
title('Restored Blurred image with speckle noise removed')
% subplot(2,3,5), imhist(wnr2);
% title('Restored Blurred image with speckle noise removed')

figure,imshow(I_sp);
title('image with speckle noise')

figure,imshow(Y);
title('MedFilt 3x3')

figure,imshow(wnr2);
title('Restored Blurred image with speckle noise removed')

% subplot(3,3,1), imhist(I);
% title('Original Gray Image')
% subplot(3,3,2), imhist(blurred1);
% title('Blurred Image with no noise')
% subplot(3,3,3), imhist(wnr1);
% title('Restored Blurred Image with no noise')
% subplot(3,3,4), imhist(blurred2);
% title('Blurred Image with no noise')
% subplot(3,3,5), imhist(I_sp);
% title('Blurred image with Speckle noise')
% subplot(3,3,6), imhist(Y);
% title('Cleaned image with MedFilt')
% subplot(3,3,7), imhist(wnr2);
% title('Restored Blurred image with speckle noise removed')