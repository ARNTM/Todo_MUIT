a = 0:0.0001:1000;
b = a/20.16;
for i = 1:length(b)
    if(isa(b(i), 'integer')) 
        disp(b(i))
    end
end