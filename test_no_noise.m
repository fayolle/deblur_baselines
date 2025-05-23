close all;
clear;
clc;

addpath('./images/');
addpath('./kernels/');


% Barbara 
xin = im2double(imread('barbara_face.png'));

% eccv3 kernel
k = im2double(imread('eccv3_blur_kernel.png'));
k = k./sum(k(:));
K = psf2otf(k,size(xin));
f = @(x) real(ifft2(fft2(x).*K));

% Observed blurred image
yout = f(xin);
figure, imshow([xin yout]), title('Input/Blurred');

max_iter = 500; 

% Wiener 
w_out = Wiener(K, yout);

% ISRA 
isra_out = ISRA(K, yout, max_iter);

% RL 
rl_out = RL(K, yout, max_iter);

% Display the results 
figure, imshow([w_out isra_out rl_out]), title('Wiener/ISRA/RL');
