%% part a
%Plant is G = 4500*K/s(s+361.2)

clear all;
syms s;

K = 0.00001;
num = {[4500*K]};
den = {[1 361.2 0]};

G_p = tf(num,den); %plant function

Kp = 182/K;
Kd = 100000;
G_c = pid(Kp,0,Kd); %PD Controller
H = 1;
T = feedback(G_c*G_p, H);

figure(1)
step(T)

t = 0:0.1:70;
ramp = t;

[y,t] = lsim(T,ramp,t);
figure(2)
plot(t,y)
title('Ramp response')

%% part b
%G_p is the same
K = 14000;
G_p_2 = tf(num,den); %plant function
Kp = 1500000;
Ki = 0.8/K;
G_c_2 = pid(Kp,Ki,0); %PI controller

T = feedback(G_c_2*G_p_2, H);

figure(3)
step(T)

t = 0:0.1:150;
parabolic = (t.^2)/2;
[y_2,t_2] = lsim(T,parabolic,t);
figure(4)
plot(t_2,y_2)
title('Parabolic response')

%% part c 
%Plant is G =  2.718e09
%           ---------------
%       s^3 + 3408 s^2 + 1.204e06 s

num1 = {[2.718*1000000000]};
den1 = {[1 (400.26+3008) (400.26*3008) 0]};
G_p_3 = tf(num1,den1); %Plant function

Kp = 0.25692;
Ki = 4.4722;
Kd = 0.0013764;
G_c_3 = pid(Kp,Ki,Kd); %PID controller

T = feedback(G_c_3*G_p_3, H);

figure(5)
step(T)

t = 0:0.1:70;
ramp = t;
[y,t] = lsim(T,ramp,t);
figure(6)
plot(t,y)
title('Ramp response')

