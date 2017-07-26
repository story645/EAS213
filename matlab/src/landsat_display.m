% landsat display: a script for reading then displaying landsat data

filename = 'landsat_RGBN.txt';

% read the landsat data
datarray = landsat_read(filename);

% display as  RGB, railing off anything too bright or dark
rgb_display(datarray(:,:,1:3));
fignum = gcf % gets current figure number

% pick points and calculate histograms of all values
% classhists(datarray,fignum);

% make color map of different properties
make_colormap(datarray);
