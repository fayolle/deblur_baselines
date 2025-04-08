function rlk = RL_BA(H, y, max_iter)
% Biggs-Andrews acceleration of Richardson-Lucy iterations
% 
% The documentation of deconvlucy is mentioning it in 
% https://www.mathworks.com/help/images/ref/deconvlucy.html 
% so I assume that this is how they implement RL
% 

Hconj = conj(H);

% Initialization for Biggs-Andrews acceleration 
xk = y;
xkm1 = zeros(size(y));
ykm1 = y;
ykm2 = zeros(size(y));
gkm1 = xk;
gkm2 = xk;
ak = 0.5;

for i=1:max_iter
    yk = xk + ak*(xk-xkm1);
    ak = (gkm1(:)'*gkm2(:))/(gkm2(:)'*gkm2(:)+eps);
    gkm1 = xk - ykm1;
    gkm2 = xkm1 - ykm2;
    ykm2 = ykm1;
    ykm1 = yk;
    xkm1 = xk;
    YK = fft2(yk);
    xk = yk.*abs(ifft2(fft2(y./ifft2(H.*YK)).*Hconj));
    RLba = xk; 
end

rlk = RLba; 

end
