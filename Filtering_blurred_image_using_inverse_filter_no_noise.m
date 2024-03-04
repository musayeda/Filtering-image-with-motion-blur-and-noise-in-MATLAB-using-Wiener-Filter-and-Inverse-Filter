clc,clear all;

I=rgb2gray((imread('img1.png')));
subplot(1,3,1),imshow(I);
title('Original Gray Image');
subplot(1,3,1), imhist(I);
title('Original Gray Image')
shake = 50;
angle = 50;
PSF = fspecial('motion',shake,angle);

Idouble = im2double(I);
blurred = imfilter(Idouble,PSF,'conv','circular');
subplot(1,3,2),imshow(blurred);
title('Blurred Image with no noise')
subplot(1,3,2), imhist(blurred);
title('Blurred Image with no noise')

wnr1 = deconvwnr(blurred,PSF);
subplot(1,3,3),imshow(wnr1);
title('Restored Blurred Image with no noise')
subplot(1,3,3), imhist(wnr1);
title('Restored Blurred Image with no noise')


