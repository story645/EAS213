function [null] = make_colormap(datarray)
% performs selection on datarray
% fills in colors based on that selection

mapcolors = 0*datarray(:,:,1:3);

% let's first pick out vegetation using something called NDVI
% NDVI = (NIR - RED)/(NIR + RED)

NDVI = (datarray(:,:,4) - datarray(:,:,1))./(datarray(:,:,4) + datarray(:,:,1));
size(NDVI)
[Xvegpts,Yvegpts] = find(NDVI > 0.3);

greenvec = [0 1 0];
ptcount = squeeze(size(Xvegpts))

for i=1:ptcount
   mapcolors(Xvegpts(i),Yvegpts(i),:) = greenvec;
end

figure(5)
image(mapcolors);
trueimage()

return;