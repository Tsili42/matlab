function Tglobal = GlobalThreshold(T_q, T_tm, T_nm)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

Arr = 1:1:256;
Tglobal = zeros(1,256);
for i = Arr
    L = 0;
    M = 0;
    for j = Arr
        temp = 10^(0.1*T_tm(i,j));
        L = L + temp;
        
        temp = 10^(0.1*T_nm(i,j));
        M = M + temp;
    end
    Tglobal(i) = 0.5*mag2db(10^(0.1*T_q(i)) + L + M);
end

