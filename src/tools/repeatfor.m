function y=repeatfor(x,n)
y=[];
if(~isempty(x))
    while length(y)<n,
        y=[y x];
    end
y=y(1:n);
end