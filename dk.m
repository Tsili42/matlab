function d = dk(k)
%Calculation of proper interval for each k
if (2 < k && k < 63)
    d = 2;
elseif(63 <= k && k < 127)
    d = [2,3];
else
    d = [2,3,4,5,6];
    
end

