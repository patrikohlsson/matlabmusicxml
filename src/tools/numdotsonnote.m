function dots = numdotsonnote( dur )
% Calculates the number of dots on the note given a duration
%
% 4*2^(numberofdots)-1 = denom    # 3, 7, 15, 31, 63 ...
% numberofdots = log2( (denom + 1) / 4 )

denom = getvalueratio(dur);
ndots = log2((denom+1)/4);

dots = 0;

if(ndots == fix(ndots))
    dots = ndots+1;
end