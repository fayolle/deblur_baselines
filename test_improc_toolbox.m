% Script to compare the implementation of Wiener and RL to the
% implementations in MATLAB image processing toolbox. 
% This requires the image processing toolbox to be installed. 
%

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

max_iter = 100; 

% Wiener 
w_out = Wiener(K, yout);
w_out_t = deconvwnr(yout, k);

% RL 
rl_out = RL(K, yout, max_iter);
rl_ba_out = RL_BA(K, yout, max_iter);
rl_out_t = deconvlucy(yout, k, max_iter);

% Display the results 
figure, imshow([w_out w_out_t]), title('Wiener/Toolbox');
figure, imshow([rl_out rl_ba_out rl_out_t]), title('RL/Toolbox');


% With noise 
noise_mean = 0.0;
noise_var = 0.00001;
F = @(x) imnoise(f(x), 'gaussian', noise_mean, noise_var);

% Observed blurred image
yout = F(xin);
figure, imshow([xin yout]), title('Input/Blurred and noisy');

max_iter = 100; 

% Wiener 
w_out = Wiener(K, yout);
w_out_t = deconvwnr(yout, k);

% Estimate noise 
signal_var = var(yout(:));
nsr = estimate_noise(yout)^2/signal_var;
w_out_nsr = Wiener(K, yout, nsr);
w_out_nsr_t = deconvwnr(yout, k, nsr);

% RL 
rl_out = RL(K, yout, max_iter);
rl_ba_out = RL_BA(K, yout, max_iter);
rl_out_t = deconvlucy(yout, k, max_iter);

% Display the results 
figure, imshow([w_out w_out_t]), title('Wiener/Toolbox');
figure, imshow([w_out_nsr w_out_nsr_t]), title('Wiener/Toolbox (nsr)');
figure, imshow([rl_out rl_ba_out rl_out_t]), title('RL/Toolbox');
