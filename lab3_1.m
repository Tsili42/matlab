clear all;

%step 0
Fs = 44100;
music = audioread('music.wav');
music = sum(music, 2) ./ 2;
figure(1)
plot(music)
title('Sound signal')

frame = buffer(music,512);
N = 512;
%% Data for part 1
f = [1:512/2]*(Fs/512);
b = Bark(f);
T_q = Ath(f);
Arr = 1:1:256;
fArr = 1:1:1179;
P = zeros(256,1179);
P_tm = zeros(1179,256);
P_nm = zeros(1179,256);

%% Data for part 2
M = 32;
L = 2*M;
%bits = 8;
R = 2^16;
s = zeros(1179,639);

%% Main Loop
for frame_no = fArr
    
    %step 1
    
    P(:,frame_no) = SPLSpectrum(frame(:,frame_no));
    figure(2)
    plot(P)
    title('SPL Spectrum')
    %step 2
    
    for k = Arr
        if (TonalSet(P(:,frame_no), k) == 1)
            P_tm(frame_no,k) = 0.5*mag2db(10^(0.1*P(k-1,frame_no))) + 10^(0.1*P(k,frame_no)) + 10^(0.1*P(k+1,frame_no));
        else
            P_tm(frame_no,k) = 0;
        end
    end
    
    figure(3)
    plot(P_tm(frame_no,:))
    title('Tone maskers')
    
    P_nm = findNoiseMaskers(P(:,frame_no), P_tm(frame_no,:), b);
    
    figure(4)
    plot(P_nm)
    title('Noise maskers')
    
     %step 3
    
    [P_Tm, P_Nm] = checkMaskers(P_tm(frame_no,:), P_nm, T_q, b);
    P_Tm = P_Tm';
    P_Nm = P_Nm';
    
    %step 5 (Global Masking Threshold)
    
    Tglobal = threshold(P_Tm,P_Nm,N,b,T_q);
    figure(5)
    plot(Tglobal)
    title('Global Masking Threshold')
    
   %part2 
    for fltr = 1:M
        for n = 0:(2*M-1) 
            h(n+1) = sqrt(2/M)*sin((n+1/2)*pi/(2*M))*cos((2*n+M+1)*(2*fltr+1)*pi/(4*M));
        end
        for n = 0:(2*M-1)
             g(n+1) = h(64-n);
        end
         
        v = conv(h,frame(:,frame_no));
        y = downsample(v,M);
        %Quantization starts here
        lowf = 8*(fltr-1)+1;
        highf = 8*fltr;
        T_min = min(Tglobal(lowf:highf));
        bits = ceil(log2(R/T_min)-1);
        minm = min(y);
        maxm = max(y);
        range = maxm - minm;
        delta = range/(2^bits);
        levels = zeros(1,2^bits);
        aco = 2;
        levels(1) = minm + delta/2;
        while (levels(aco-1) < maxm)
            levels(aco) = levels(aco-1) + delta;
            aco = aco+1;
        end
        levels = levels(1:2^bits);
        codeb = zeros(1,2^bits+1);
        codeb(1:2^bits) = levels(1:2^bits);
        codeb(2^bits+1) = maxm+delta;
        [~,y_new] = quantiz(y,levels,codeb);
        %Quantization ends here
        w_M = upsample(y_new,M);
        x_est = conv(g,w_M);
        s(frame_no,:) = s(frame_no,:) + x_est(:)';
                
    end
    
    music_est = zeros(603285,1);
    for counter = 1:1179
        music_est((counter-1)*512+1:(counter-1)*512+639) = s(counter,:);
    end
    
    error = immse(music,music_est(64:603285+63));
    
   
    
end


        

