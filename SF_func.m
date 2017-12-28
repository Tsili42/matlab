
function output = SF_func(i, j, Pmask, bark)
    Db = bark(i) - bark(j);
    
    if (Db >= -3 && Db < -1)
        output = 17*Db - 0.4*Pmask(j) + 11;
    elseif (Db >= -1 && Db < 0)
        output = (0.4*Pmask(j) + 6)*Db;
    elseif (Db >= 0 && Db < 1)
        output = -17*Db;
    elseif (Db >= 1 && Db <8)
        output = (0.15*Pmask(j) - 17)*Db - 0.15*Pmask(j);
    else
        output = 0;
    end
end