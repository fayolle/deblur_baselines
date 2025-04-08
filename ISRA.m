function israk = ISRA(F, y, max_iter)
israk = y;
Y = fft2(y);
for i=1:max_iter
    fisrak = F(israk);
    ISRAK = fft2(israk);
    H = fft2(fisrak)./(ISRAK+1e-7);
    Hconj = conj(H);
    israk = israk .* real(ifft2(Y.*Hconj)) ./ real(ifft2(fft2(fisrak).*Hconj));
end
end
