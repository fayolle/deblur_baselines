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

% Apply noise to the blurry image
noise_mean = 0.0;
noise_var = 0.00001;
F = @(x) imnoise(f(x), 'gaussian', noise_mean, noise_var);

% Observed blurred image
yout = F(xin);
figure, imshow([xin yout]), title('Input/Blurred and noisy');

max_iter = 500; 

% Wiener 
w_out = Wiener(K, yout);

% ISRA 
isra_out = ISRA(K, yout, max_iter);

% RL 
rl_out = RL(K, yout, max_iter);

% Display the results 
figure, imshow([w_out isra_out rl_out]), title('Wiener/ISRA/RL');
