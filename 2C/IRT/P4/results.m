k = 0;
for i=1:N,
    for j=1:N,
        if i==j,
        else
            k = k+1;
            bij(k) = i*10+j;                    
        end
    end
end

lightpaths = [1:N*(N-1); bij; x(1:N*(N-1))']
% Matrix with three rows and N*(N-1) columns
% First row, index in the variable vector x
% Second row, ij subindex
% Third row, bij value

for ij = 1:N*(N-1),
    l_ij(ij)=sum(x(size_b+ij:size_b:size_l+ij));
end
traffic = [bij; l_ij]
% Matrix with two rows and N*(N-1) columns
% First row, ij subindex
% Third row, total traffic through ij lightpath, lambda_ij value
 
l_max = x(size_x)
% Congestion in the network