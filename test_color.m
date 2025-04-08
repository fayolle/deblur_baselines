close all;
clear;
clc;

addpath('./images/');
addpath('./kernels/');

xin = im2double(imread('parrots.png'));

k = im2double(imread('eccv3_blur_kernel.png'));
k = k./sum(k(:));
K = psf2otf(k,size(xin));
f = @(x) real(ifft2(fft2(x).*K));
        
% Observed noisy and blurred image
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
