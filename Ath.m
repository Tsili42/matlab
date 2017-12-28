function T_q = Ath(f)
%Calculate the Absolute Threshold of Hearing
f_ = f/1000;
T_q = 3.64*(f_).^(-0.8) - 6.5*exp((-0.6)*((f_-3.3).^2)) + 0.001 * ((f_).^4) ;

end

