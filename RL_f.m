function rlk = RL_f(F, y, max_iter)
% Semi-blind version of RL iterations 
% 
rlk = y;
for i=1:max_iter
    frlk = F(rlk);
    RLK = fft2(rlk);
    H = fft2(frlk)./(RLK+1e-7);
    Hconj = conj(H);
    rlk = real(ifft2(Hconj.*fft2(y./(ifft2(H.*RLK)+eps)))).*rlk;
end
end
