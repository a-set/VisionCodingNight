%This file tests colorQuantizer
img = imread('Problem1.jpg');
%set the value of K
K = 10;
%set the scale indicator,if you want to scale
scale = 1;
%call colorQuantizer function
img = colorQuantizer(img,K,scale);
%display the returned image
figure;
imshow(img);
