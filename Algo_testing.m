n = 1:10:1000;
y1 = 2.^((log2(n)).^3);
y2 = sqrt(factorial(n));

figure(1)
plot(n, y1)

figure(2)
plot(n, y2)