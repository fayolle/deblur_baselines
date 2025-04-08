function rlk = RL(H, y, max_iter)
rlk = y;
Hconj = conj(H);
for i=1:max_iter
    RLK = fft2(rlk);
    rlk = real(ifft2(Hconj.*fft2(y./(ifft2(H.*RLK)+eps)))).*rlk;
end
end
