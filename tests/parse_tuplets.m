x = [3/7 1/7 1/7 1/7 1/7 1/4 6/16 1/16 3/8 1/3 1/3 1/6 1/4+1/8+1/16+1/32+1/64];

for j=1:length(x)
s = strsplit(rats(x(j)),'/');
if(length(s)>1)
denom = str2double(s{1});
divis = str2double(s{2});
else
denom = str2double(s{1});
divis=1;
end
dots = '';

for k=1:numdotsonnote(x(j))
    dots = [dots 'dot'];
end

if(mod(x(j),(1/4)/(2^7))==0)
disp('not tuplet');
fprintf('val: %d/%d %s\n\n',denom,divis,dots);
elseif(mod(x(j),(1/3)/(2^7))==0)
disp('triplet');
fprintf('rat: %d %d %s\n\n',divis,2*divis/3,dots);
elseif(mod(x(j),(1/5)/(2^7))==0)
disp('quintuplet');
fprintf('rat: %d %d %s\n\n',divis,4*divis/5,dots);
elseif(mod(x(j),(1/7)/(2^7))==0)
disp('septuplet');
fprintf('rat: %d %d %s\n\n',divis,4*divis/7,dots);
else
disp('something else');
fprintf('\n');
end
end