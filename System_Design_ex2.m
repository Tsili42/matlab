clear all;

%% part a
%State is measurable & we design a regulator
A = [0 1 0 0; 20.6 0 0 0; 0 0 0 1; -0.5 0 0 0];
b = [0; -1; 0; 0.5];
C = [1 0 0 0; 0 0 1 0];

p = [-20 -30 -1+sqrt(3)*1i -1-sqrt(3)*1i];
[K,prec,msg] = place(A,b,p);

init = [-0.2; -0.06; 0.01; 0.3];
sys = ss(A-b*K,b,C,[]);
[y,t,x] = initial(sys,init);

% figure(42)
% lsim(sys, zeros(size(t)), t, init);

figure(1)

subplot(5,1,1)
plot(t,x(:,1))
title('Angular position')
subplot(5,1,2)
plot(t,x(:,2))
title('Angular velocity')
subplot(5,1,3)
plot(t,x(:,3))
title('Horizontal position')
subplot(5,1,4)
plot(t,x(:,4))
title('Horizontal velocity')
subplot(5,1,5)
plot(t,-K*x')
title('Input')

xlabel('Time(sec)')

%% part b
%Lqr design

[K1,s,e] = lqr(sys, eye(4), [1], 0);

N_lqr = [-0.002041658156251];
sys = ss(A-b*K1,b*N_lqr,C,[]);
[y,t,x] = initial(sys,init);

figure(2)

subplot(5,1,1)
plot(t,x(:,1))
title('Angular position')

subplot(5,1,2)
plot(t,x(:,2))
title('Angular velocity')

subplot(5,1,3)
plot(t,x(:,3))
title('Horizontal position')

subplot(5,1,4)
plot(t,x(:,4))
title('Horizontal velocity')

subplot(5,1,5)
plot(t,-K1*x')
title('Input')

xlabel('Time(sec)')

%% part c
%Reference input
t = 0:0.01:10;

N_bar = [-244.897959183673]; %3rd element of gain K
u = 5*ones(size(t));
sys_cl = ss(A-b*K,b*N_bar,C,0);
figure(3)
lsim(sys_cl,u,t);
title('Position goes to 5')
xlabel('Time (sec)')

%% part d
%We build an observer to estimate the non-measurable state

L = place(A',C',[-100 -101 -102 -103])'; %Gain of the observer

At = [ A-b*K             b*K
       zeros(size(A))    A-L*C ];

Bt = [    b*N_bar
       zeros(size(b)) ];

Ct = [ C    zeros(size(C)) ];

sys_obs = ss(At,Bt,Ct,0);
figure(4)
lsim(sys_obs,zeros(size(t)),t,[init; init]);
title('Regulation (with observer)')
xlabel('Time (sec)')

At1 = [ A-b*K1             b*K1
       zeros(size(A))    A-L*C ];

Bt1 = [    b*N_lqr
       zeros(size(b)) ];
   
sys_LqrPlusObs = ss(At1, Bt1, Ct,0);
figure(5)
lsim(sys_LqrPlusObs, zeros(size(t)), t, [init;init]);
title('Lqr with observer')
xlabel('Time (sec)')

%% part e
%Is our design robust?
 
DA = [0 1 0 0; 20.9 0 0 0; 0 0 0 1; -0.8 0 0 0];
Db = [0; -1; 0; 0.5];
DC = [1 0 0 0; 0 0 1 0];

D_sys = ss(DA-b*K,b,C,[]);
figure(6)
lsim(D_sys, zeros(size(t)), t, init);
title('Regulation of slightly changed system')
