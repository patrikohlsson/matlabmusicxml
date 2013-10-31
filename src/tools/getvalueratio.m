function [denom, divis] = getvalueratio( val )
% Return the denominator and divisor of value

s = strsplit(rats(val,10),'/');
if(length(s)>1)
    denom = str2double(s{1});
    divis = str2double(s{2});
else
    denom = str2double(s{1});
    divis = 1;
end