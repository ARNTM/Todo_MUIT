function ecm = errorc(A, B)
    if size(A) == size(B)
        dif = (double(A)-double(B)).^2;
        ecm = sqrt(mean(dif(:)));
    else
        disp('Las matrices son de distinto tamaño');
    end
end