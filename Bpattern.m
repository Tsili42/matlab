function y = Bpattern(d, N, arg, args)
%Bpattern: calculate the beam pattern
arg = degtorad(arg);
args = degtorad(args);
y = (1/N)*(sin((N/2)*(2*pi*2*1000/340)*d*(cos(arg)- cos(args))))./(sin((1/2)*(2*pi*2*1000/340)*d*(cos(arg)- cos(args))));

end

