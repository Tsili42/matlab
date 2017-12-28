function SF = SF(P, b)
%Calculation of the extent of masking expressed in bark units

SF = zeros(256);
Arr = 1:1:256;
for j = Arr
    for i = Arr
        if (P(j) == 0) 
            continue;
        end
        deltaB = b(i) - b(j);
        if (-3 <= deltaB && deltaB < -1)
            SF(i,j) = 17*deltaB - 0.4*P(j) + 11;
        elseif (-1 <= deltaB && deltaB < 0)
            SF(i,j) = (0.4*P(j)+6)*deltaB;
        elseif (0 <= deltaB && deltaB < 1)
            SF(i,j) = -17*deltaB;
        elseif (-1 <= deltaB && deltaB < 8)
            SF(i,j) = (0.15*P(j) - 17)*deltaB - 0.15*P(j);
        end
    end
end

end

