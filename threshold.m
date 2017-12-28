
function Tg = threshold (Ptmr_window, Pnmr_window, N,b,Tq )

Ptmr=Ptmr_window;
Pnmr=Pnmr_window;

    
for j=1:N/2
  if (Ptmr(j)>0)
    for i=1:N/2
       Db=b(i)-b(j);
            if ( Db>=-3 && ( Db<=8))
                SF_tm=SF_func(i,j, Ptmr, b);
                Ttm(i,j)=Ptmr(j) -0.275*b(j) + SF_tm -6.025;
            else Ttm(i,j)=0;
            end
    end
  end
end

for j=1:N/2
  if (Pnmr(j)>0)
    for i=1:(N/2)
        Db=b(i)-b(j);
            if ( Db>=-3 && ( Db<=8))
                SF_tm=SF_func( i,j, Pnmr, b);
                Tnm(i,j)=Pnmr(j) -0.175*b(j) + SF_tm -2.025;
            else Tnm(i,j)=0;
            end
    end
  end
end



for i=1:N/2
   s1=sum(10.^(0.1*(Tnm)),2);
   s2=sum(10.^(0.1*(Tnm)),2);
   Tg(i)=10*log10(10.^(0.1*Tq(i))+s1(i)+s2(i));
end


end