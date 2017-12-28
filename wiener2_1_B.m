clear all;
%2.1 B
fs = 48000;
samples = fs * 0.03;
voice = audioread('source.wav');
midMic = audioread('sensor_3.wav');

midMic = midMic';

[pxx, w] = pwelch(midMic(0.75*fs+1:0.75*fs+samples),10,5,2*25*0.001*fs-1,'twosided');
[pv, ~] = pwelch(voice(0.75*fs+1:0.75*fs+samples),20,10,2*25*0.001*fs-1,'twosided');


H_w = pv ./ pxx;
normW = 2500 * w;
figure(1)
plot(normW, 10*log10(H_w))
title('Wiener response');
xlabel('Hz');
ylabel('dB');
axis([0 8000 -18 0])


figure(2)
plot(normW, 10*log10(abs(1-H_w).^2))
title('Speech disortion index');
xlabel('Hz');
ylabel('dB');
axis([0 8000 -9 0])


%Apply wiener filter
H_w(1201:1440) = mean(H_w);
outW = ifft(H_w' .* fft(midMic(0.75*fs+1:0.75*fs+samples),2399));
[optimal, wW] = pwelch(outW);


figure(3)
plot(normW, 10*log10(pv), 'b'); hold on;
plot(normW, 10*log10(pxx), 'r'); hold on;
plot(normW, 10*log10(pxx-pv), 'y'); hold on;
plot(wW*1150, 10*log10(optimal), 'g');
title('Power spectrum of signals');
xlabel('Hz');
ylabel('dB');
axis([0 8000 -90 -20])

%SNR calculations
noise = midMic(0.75*fs+1:0.75*fs+samples)-voice(0.75*fs+1:0.75*fs+samples)';
inputSNR = snr(midMic(0.75*fs+1:0.75*fs+samples),noise)
outSNR = snr(real(outW(1:1440)),noise)



