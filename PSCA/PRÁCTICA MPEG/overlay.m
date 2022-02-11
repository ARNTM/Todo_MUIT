function imDisplay = overlay(img, out)
    imDisplay = img;
    for i = 1:length(out)
        imDisplay = insertShape(imDisplay, 'Circle', [out(i,:) 10]);
    end
end