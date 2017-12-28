syms K k1 k2 k3 s t
E = (s+400.26)*(s+3008)/((s^4)+(400.26+3008)*(s^3)+(400.26*3008+K*k2)*(s^2)+(K*k1)*s+K*k3);
e = ilaplace(E,s,t)
% h = matlabFunction(e);
% time = linspace(1,1000,1000);
% 
% plot(time, h(1,1,1,time))
