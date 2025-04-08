function w_out = Wiener(H, y, nsr)
if nargin==2
    nsr = eps;
end
Hconj = conj(H);
w_out = real(ifft2((Hconj./(Hconj.*H + nsr)).*fft2(y)));
end
