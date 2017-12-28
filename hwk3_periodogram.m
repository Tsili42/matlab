%Compare 2 different ways of periodogram calculation

n = 1:1:1024; %length of signal is 1024
omega1 = 0.6 * pi;
omega2 = 0.75 * pi;

phi1 = unifrnd(0,2*pi,1,1024);
phi2 = unifrnd(0,2*pi,1,1024);
u = randn(1,1024);

%Construct the signal
x = zeros(1,1024);
for i = n
    x(i) = 4*cos(omega1*(i-1)+phi1(i))+sin(omega2*(i-1)+phi2(i))+u(i);
end

P = periodogram(x);
figure(1)
plot(P)
title('Periodogram')

Pw = pwelch(x,hamming(256),128);%length of window = 256, ovelap = 128
figure(2)
plot(Pw)
title('Welch Periodogram')



    

