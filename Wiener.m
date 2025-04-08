function w_out = Wiener(H, y)
signal_var = var(y(:));
NSR = estimate_noise(y)^2/signal_var;
Hconj = conj(H);
w_out = real(ifft2((Hconj./(Hconj.*H + NSR)).*fft2(y)));
end
