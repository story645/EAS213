function datarray = landsat_read(filename)
% reads the landsat text files provided

% open the file
fileID = fopen(filename,'r');

% read descriptive lines and throw away
description = fgets(fileID);
description = fgets(fileID);

% read the dimensions of the file
[dims,count] = fscanf(fileID,'%4i',3)
rows = dims(1)
cols = dims(2)
nvars = dims(3)

% make array out of dimensions
datarray = zeros(transpose(dims));

% read each layer of data
for L = 1:nvars
    layervec = fscanf(fileID,'%f',rows*cols);
    datarray(:,:,L) = reshape(layervec,[rows,cols]);
end

return;
