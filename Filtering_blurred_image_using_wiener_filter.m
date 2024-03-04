clc,clear all;

img=rgb2gray((imread('car.jpg')));
subplot(1,3,1),imshow(img);
title('Original Gray Image');
PSF = fspecial('motion',50,75); %Simulate a blurred image that might result from camera motion. 
% First, create a point-spread function, PSF, by using the fspecial function and specifying linear motion across 'M' pixels 
% at an angle of 'N' degrees. Then, convolve the point-spread function with the image by using imfilter.

% The original image has data type uint8. If you pass a uint8 image to imfilter, 
% then the function will quantize the output in order to return another uint8 image. 
% To reduce quantization errors, convert the image to double before calling imfilter.
Idouble = im2double(img);
blurred = imfilter(Idouble,PSF,'conv','circular');
subplot(1,3,2),imshow(blurred);
title('Blurred Image with no noise')
wnr1 = deconvwnr(blurred,PSF);
subplot(1,3,3),imshow(wnr1);
title('Restored Blurred Image with no noise')

%--------------------giving salt and pepper noise-------

% blurred_noisy=imnoise(blurred,'salt & pepper', 0.05);
% subplot(1,3,2),imshow(blurred_noisy);
% title('Blurred Image with salt&pepper noise')

%---------------giving gaussian noise--------

% noise_mean = 0;
% % noise_var = 0.0001;
% blurred_noisy = imnoise(blurred,'gaussian',noise_mean,0.0001);
% subplot(1,3,2),imshow(blurred_noisy);
% title('Blurred Image with gaussian noise')

%---------------giving speckle noise-----
% blurred_noisy=imnoise(blurred,'speckle', 0.05);
% subplot(1,3,2),imshow(blurred_noisy);
% title('Blurred Image with speckle noise')

%-------------------With noise to signal ratio = 0-----
% wnr1 = deconvwnr(blurred_noisy,PSF);
% subplot(1,3,3),imshow(wnr1);
% title('Restored Blurred Image with NSR = 0') %NSR = noise to signal ratio

%-------------------With estimated noise to signal ratio-----

noise_var = 0.01 %if the picture has tons of noise, by increasing the value of noise_var increases, 

% the picture becomes clearer but we lose some information and picture
% becomes a bit muddy. Also seeing the final histogram, we see contrast
% stretching of the noisy image to give the final filtered image (This
% happens for salt and pepper noise).
%WITH GAUSSIAN NOISE, increasing the noise_var filters the image a bit, but
%also darkens the image. It is visible in the histogram.

% estimated_nsr = noise_var / var(blurred_noisy(:));
% wnr1 = deconvwnr(blurred_noisy,PSF, estimated_nsr);
% subplot(1,3,3),imshow(wnr1);
% title('Restored Blurred Image with estimated NSR') %NSR = noise to signal ratio

% Y=medfilt2(wnr1,[3 3]);
% figure,imshow(Y);
% title('MedFilt')


figure
subplot(1,3,1),imhist(img);
subplot(1,3,2),imhist(blurred);
subplot(1,3,3),imhist(wnr1);
% J = histeq(wnr1); Tried histogram equalization
% figure,imhist(J);
% figure,imshow(J);

