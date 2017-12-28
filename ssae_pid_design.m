%part a
K = 0.00001;
num = {[4500*K]};
den = {[1 361.2 0]};

G = tf(num,den);

%G_c = pid(_,0,_);
T = feedback(G_c*G, 1);

figure(1)
step(T)

t = 0:0.1:60;
ramp = t;

[y,t] = lsim(T,ramp,t);
figure(2)
plot(t,y)
title('Ramp response')

%part b
K = 10000;
G_p_2 = tf(num,den);
%G_c_2 = pid(_,_,0)
T = feedback(G_c_2*G_p_2,1);

figure(3)
step(T)

t = 0:0.1:120;
parabolic = (t.^2)/2;
[y_2,t_2] = lsim(T,parabolic,t);
figure(4)
plot(t_2,y_2)
title('Parabola response')

%part c
num1 = {[2.718*1000000000]};
den1 = {[1 (400.26+3008) (400.26*3008) 0]};
G_p_3 = tf(num1,den1); 
%G_c_3 = pid(Kp,Ki,Kd);

T = feedback(G_c_3*G_p_3, H);

figure(5)
step(T)

t = 0:0.1:60;
ramp = t;
[y,t] = lsim(T,ramp,t);
figure(6)
plot(t,y)
title('Ramp response')
