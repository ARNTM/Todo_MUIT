function [vx,vy,errMin] = exhaustiva(Mblock, ref, iH, iV, dM)
    [filas, columnas, colores] = size(ref);
    vx = 0;
    vy = 0;
    errMin = 1000;
    for i = iH-dM : iH+dM
        for j = iV-dM : iV+dM
            if (i>0 && i<columnas-15) && (j>0 && j<filas-15) 
                MblockRef = ref(j:j+15, i:i+15, :);
                error = errorc(Mblock, MblockRef);
                if error < errMin
                    vx = i - iH;
                    vy = j - iV;
                    errMin = error;
                end
            end
        end
    end
end