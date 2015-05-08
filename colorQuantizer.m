function [newImg] = colorQuantizer(img,k,scale)

%convert to double
ab = double(img);
newImg = ab;

if scale == 1
   %Multiplying red values by 100
   ab(:,:,1) = ab(:,:,1).*100;
end

%reshape into a vector
nrows = size(ab,1);
ncols = size(ab,2);
ab = reshape(ab,nrows*ncols,3);

%Start clustering
[cluster_idx,cluster_center] = kmeans(ab,k,'distance','sqEuclidean');
pixel_labels = reshape(cluster_idx,nrows,ncols);

%Test clustering result, only for debugging
%imshow(pixel_labels,[]);

%Store the RGB componenets of the original image
newR = newImg(:,:,1);
newG = newImg(:,:,2);
newB = newImg(:,:,3);

%For each cluster, find the pixels that belong to it and give them their
%corresponding R,G & B values
    for i = 1:k
        %For R
        newR(pixel_labels==i)=cluster_center(i,1);
        % For G
        newG(pixel_labels==i)=cluster_center(i,2);
        % For B
        newB(pixel_labels==i)=cluster_center(i,3);
    end

%Set everything up in the newImg
newImg(:,:,1) = newR;
newImg(:,:,2) = newG;
newImg(:,:,3) = newB;

%if the image was scaled, normalize it again
if scale ==1 
    newImg(:,:,1) = newImg(:,:,1)./100;
end

newImg = uint8(newImg);
end
