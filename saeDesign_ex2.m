%part a
A = [0 1 0 0; 20.6 0 0 0; 0 0 0 1; -0.5 0 0 0];
b = [0; -1; 0; 0.5];
C = [1 0 0 0; 0 0 1 0];

p = [-20 -30 -0.25+0.5*sqrt(3)*1i -0.25-0.5*sqrt(3)*1i];
[K,prec,msg] = place(A,b,p);

init = [-0.2; -0.06; 0.01; 0.3];
sys = ss(A-b*K,b,C,[]);
[y,t,x] = initial(sys,init);
figure(1)
lsim(sys, zeros(size(t)), t, init);

%part b

[K1,s,e] = lqr(sys, eye(4), [1], 0);

sys = ss(A-b*K1,b,C,[]);
[y,t,x] = initial(sys,init);
figure(2)
lsim(sys, zeros(size(t)), t, init);
% part c
t = 0:0.01:9;

N_bar = [-49.7448979591838]; 
u = ones(size(t));
sys_cl = ss(A-b*K,b*N_bar,C,0);
figure(3)
lsim(sys_cl,u,t);

% part d

L = place(A',C',[-80 -105 -110 -120])'; 

At = [ A-b*K             b*K
       zeros(size(A))    A-L*C ];

Bt = [    b*N_bar
       zeros(size(b)) ];

Ct = [ C    zeros(size(C)) ];

sys_obs = ss(At,Bt,Ct,0);
figure(4)
lsim(sys_obs,zeros(size(t)),t,[init; init]);

At1 = [ A-b*K1             b*K1
       zeros(size(A))    A-L*C ];

Bt1 = [    b
       zeros(size(b)) ];
   
sys_LqrPlusObs = ss(At1, Bt1, Ct,0);
figure(5)
lsim(sys_LqrPlusObs, zeros(size(t)), t, [init;init]);
title('Lqr with observer')
xlabel('Time (sec)')

%part e
 
DA = [0 1 0 0; 20.9 0 0 0; 0 0 0 1; -0.8 0 0 0];
Db = [0; -1; 0; 0.5];
DC = [1 0 0 0; 0 0 1 0];

D_sys = ss(DA-b*K,b,C,[]);
figure(6)
lsim(D_sys, zeros(size(t)), t, init);
title('Regulation of slightly changed system')
