function israk = ISRA(H, y, max_iter)
israk = y;
Y = fft2(y);
Hconj = conj(H);
for i=1:max_iter
    ISRAK = fft2(israk);
    israk = israk .* real(ifft2(Y.*Hconj)) ./ real(ifft2((H.*ISRAK).*Hconj));
end
end
