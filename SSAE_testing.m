num1 = [0 0 1];
den1 = [1 0.5 1];

num2 = [0 0 1];
den2 = [1 0.5 4];

t = 0:0.1:20;
[y1,x1,t] = step(num1,den1,t);
[y2,x2,t] = step(num2,den2,t);
plot(t,y1,t,y2)
grid
text(11,0.75,'System1'),text(11.2,0.16,'System2')
