function y_new = myquantize(y, bits)
%Quantize the signal

for i = 1:length(y)
%     if (sign(y(i))>0)
%         y_new(i) = 1;
%     else
%         y_new(i) = -1;
%     end
    y_new(i) = max(min(round(y(i)*(2^(bits-1))/(2^(bits-1)))-sign(y(i))/(2^bits),1),-1);
end
end

