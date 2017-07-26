function rgb_display(rgbarray)
% displays rgb image x contrast, railed off if too high or low

contrast = 1

while (contrast ~= 0)
    
    rgbcarray = contrast*rgbarray;
    maximg = max(max(max(rgbcarray)))
  
    low = find(rgbcarray < 0);
    rgbcarray(low) = 0;
    high = find(rgbcarray > 1);
    rgbcarray(high) = 1;
    
    dims = size(rgbcarray);
    ndims = size(dims);
    % if only one dimension, put same in r,g,b for grayscale
    if ndims < 3  
        temp = rgbcarray;
        rgbcarray = zeros(dims(1),dims(2),3);
        for i=1:3
            rgbcarray(:,:,i) = temp;
        end
    end
    image(rgbcarray);
    truesize();
    
    contrast = input('enter contrast, 0 to exit');

end % while loop

return;