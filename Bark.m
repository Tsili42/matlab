function b = Bark(f)
%Hz to Bark
  
b = 13*atan(0.00076*f)+3.5*atan((f/7500).^2);

end

