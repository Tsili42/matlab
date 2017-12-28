clear all;
%Real Beamforming
N = 7;
d = 0.08;
c = 340;
n = 0:1:6;
theta = degtorad(90);
fs = 48000;

%Same procedure as 2.1A
voice = audioread('source.wav');
sens(1,:) = audioread('sensor_0.wav');
sens(2,:) = audioread('sensor_1.wav');
sens(3,:) = audioread('sensor_2.wav');
sens(4,:) = audioread('sensor_3.wav');
sens(5,:) = audioread('sensor_4.wav');
sens(6,:) = audioread('sensor_5.wav');
sens(7,:) = audioread('sensor_6.wav');
NFFT = 171272;

taf = -((n - (N - 1)/2) * d * cos(theta)) / c;
taf = taf * fs;

w = [-NFFT/2 : (NFFT - 1)/2];
normW = w * 2 * pi / NFFT;
Real_signal(1:NFFT) = 0;
for i = 1:7
    M_vector(i,:) = exp(1i * taf(i) * normW); %Manifold vector
    Sens_dft(i,:) = fft(sens(i,:)); %Dft of sensors' signal
    out(i,:) = M_vector(i,:) .* Sens_dft(i,:); %Apply the filter
    real_out(i,:) = real(ifft(out(i,:),NFFT)); %Keep the real part of the signal
    Real_signal = Real_signal + real_out(i,:); %Take the sum of the aligned signals
end

Real_signal = Real_signal / N;
Real_signal = Real_signal';
%test --> sound(voice - Real_signal, fs)
audiowrite('real_ds.wav', Real_signal, fs);

%Plots shall follow
t = 0:1/fs:NFFT/fs - 1/fs;

%Plot the clear voice signal
figure(1)
plot(t, voice);
title('Clear signal');

%Plot the noisy signal captured from the middle microphone
figure(2)
plot(t, sens(4,:));
title('Noisy signal from mid microphone');

%Plot the output of the beamformer
figure(3)
plot(t, Real_signal);
title('Output of conventional beamformer');

%Spectrograms incoming
lenW = 0.004 * fs; %length of window chosen to be 40msec
overlap = 0.002 * fs; %and the overlap is the half of it
NFFT = nextpow2(NFFT);

%Clear voice signal
[stft, f, t] = spectrogram(voice, lenW, overlap, NFFT, fs);
%spectrogram(voice)
figure(4)
surf(t, f, abs(stft))
xlabel('Time (sec)')
ylabel('Frequency (Hz)')
zlabel('|STFT|')
title('Surface of STFT of Clear signal')

%Noisy middle signal
[stft, f, t] = spectrogram(sens(4,:), lenW, overlap, NFFT, fs);
%spectrogram(sens(4,:))
figure(5)
surf(t, f, abs(stft))
xlabel('Time (sec)')
ylabel('Frequency (Hz)')
zlabel('|STFT|')
title('Surface of STFT of Noisy Middle signal')

%Output of conventional beamformer
[stft, f, t] = spectrogram(Real_signal, lenW, overlap, NFFT, fs);
figure(6)
surf(t, f, abs(stft))
xlabel('Time (sec)')
ylabel('Frequency (Hz)')
zlabel('|STFT|')
title('Surface of STFT of the output of conventional beamforming')

InSNR = segsnr(voice, sens(4,:), fs)
OutSNR = segsnr(voice, Real_signal, fs)