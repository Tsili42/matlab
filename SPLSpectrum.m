function P = SPLSpectrum(x)
%High quality spectrum estimate expressed in SPL

windowed = x .* hanning(512);
y = fft(windowed, 512);
P = 90.302 + mag2db(abs(y(1:256)));

end

