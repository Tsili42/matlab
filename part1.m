clear all;
%1.4, ès = 90, f = 2kHz
arg = 0:1/4:180;

%1, d = 4cm, N = 4, 8, 16
figure(1)
d = 0.04;
args = 90;
semilogy(arg, abs(Bpattern(d, 4, arg, args)), 'color', 'r'); hold on;
semilogy(arg, abs(Bpattern(d, 8, arg, args)), 'color', 'g'); hold on;
semilogy(arg, abs(Bpattern(d, 16, arg, args)), 'color', 'b'); 

%2, d = 4cm, 8cm, 16cm, N = 8
figure(2)
N = 8;
semilogy(arg, abs(Bpattern(0.04, N, arg, args)), 'color', 'r'); hold on;
semilogy(arg, abs(Bpattern(0.08, N, arg, args)), 'color', 'g'); hold on;
semilogy(arg, abs(Bpattern(0.16, N, arg, args)), 'color', 'b');

%3, N = 8, d = 4cm
arg = -180:1:180;
figure(3)
%subplot(3, 1, 1)
semilogr_polar(degtorad(arg), abs(Bpattern(d, N, arg, 0)), 'r')
title('0 degrees')

figure(4)
%subplot(3, 2, 1)
semilogr_polar(degtorad(arg), abs(Bpattern(d, N, arg, 45)), 'r')
title('45 degrees')

figure(5)
%subplot(3, 3, 1)
semilogr_polar(degtorad(arg), abs(Bpattern(d, N, arg, 90)), 'r')
title('90 degrees')
