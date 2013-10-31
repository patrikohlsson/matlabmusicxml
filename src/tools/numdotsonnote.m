function dots = numdotsonnote( dur )
% Calculates the number of dots on the note given a duration
% 4*2^(numberofdots)-1 = denom    # 3, 7, 15, 31, 63 ...
% numberofdots = log2( (denom + 1) / 4 )

dots = 0;
s = strsplit(rats(dur),'/');
if(length(s)==1)
    return;
end

denom = str2double(s{1});
ndots = log2((denom+1)/4);

if(ndots == fix(ndots))
    dots = ndots+1;
end