function [null] = classhists(RGBN,fignum);
% rectangles selected by mouse
% expanded view shown
% data in all channels plotted by histogram

zoom =  3  % small rectangle expanded
dims = size(RGBN);

% keep selecting rectangular area until happy
select = 1
while (select == 1)
    
    % select two points to pull out rectangular sub area 
    % defined by corner pts
    figure(fignum)
    [x,y] = ginput(2);
    colvec = round(x);
    rowvec = round(y);
    
    % Pull out the smaller rectangle and make image
    subRGBN = RGBN(rowvec(1):rowvec(2),colvec(1):colvec(2),:);
    subdims = size(subRGBN);
    subRGBNimg = subRGBN(:,:,1:3);
    subRGBNimg = imresize(subRGBNimg,[zoom*subdims(1),zoom*subdims(2)]);
    % note that imresize only does rows and columns, not the 3rd dim
    figure(3);
    rgb_display(subRGBNimg);
    
    select = input('want to continue? (1/0)');
    
end

% make histograms of all
% have to create columns for each channel in sub area
subchannels = zeros(subdims(1)*subdims(2),3);
for c=1:4
    subchannels(:,c) = reshape(subRGBN(:,:,c),subdims(1)*subdims(2),1);
end

[N,X] = hist(subchannels);
ndims = size(N)
Xdims = size(X)
figure(4)
plot(X,N(:,1),'r',X,N(:,2),'g',X,N(:,3),'b',X,N(:,4),'m');
xlabel('reflectance','fontsize',15)
ylabel('counts','fontsize',15)
title('reflectance distributions','fontsize',20);

return