function [S, warn] = TonalSet(P, k)
%Boolean function which indicates whether or not there exists a tone mask
%in k position
flag = 1;
S = 0;
if (k < 3 || k > 250)
    S = 0;
elseif ((P(k) > P(k+1)) && (P(k) > P(k-1)))
    for j = dk(k)
        if ((P(k) <= P(k+j) + 7) || (P(k) <= P(k-j) + 7))
            flag = 0;
        end
    end
    if (flag == 1)
        S = 1;
    end
end
                                
end

