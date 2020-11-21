clear;
close all;

template1 = [];
template2 = [];

%get the images for matching
% im1 = getimage('Select 1st Fingerprint image');
% im2 = getimage();
im1 = imread('H:\Biometricas_Watermarking\DB1_B\101_3.tif');
im2 = imread('H:\Biometricas_Watermarking\DB1_B\102_4.tif');

%extract the template for the image
display = 1;
%template1 = extractminutae(im1,display)

template1 = extractminutae(im1,display);

%save database template1 -compress

template2 = extractminutae(im2,display);


%do the verfication and return the percentage match