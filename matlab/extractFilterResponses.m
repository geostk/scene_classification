function [filterResponses] = extractFilterResponses(img, filterBank)
% Extract filter responses for the given image.
% Inputs: 
%   img:                a 3-channel RGB image with width W and height H
%   filterBank:         a cell array of N filters
% Outputs:
%   filterResponses:    a W*H x N*3 matrix of filter responses

    % Handle grayscale images
    if ndims(img) == 2
       img = repmat(img, 1, 1, 3); 
    end
    
    % check if floating point, convert if needed
    if ~isfloat(img)
        img = double(img);
    end
    
    % convert to labspace
    labImage = RGB2Lab(img);
    
    nRows = length(labImage(:,1,1));
    nCols = length(labImage(1,:,1));
    nPixels = nRows*nCols;
    nFilters = length(filterBank);
    filterResponses = zeros(nPixels, 3*nFilters);
    
    collage = zeros(nRows, nCols, 3, 1);

    % apply filter
    for i = 1:nFilters
        L = imfilter(labImage(:,:,1), filterBank{i}, 'replicate', 'conv');
        filterResponses(:,(3*i) - 2) = reshape(L, [nPixels,1]);
        A = imfilter(labImage(:,:,2), filterBank{i}, 'replicate', 'conv');
        filterResponses(:,(3*i) - 1) = reshape(A, [nPixels,1]);
        B = imfilter(labImage(:,:,3), filterBank{i}, 'replicate', 'conv');
        filterResponses(:,3*i) = reshape(B, [nPixels,1]);
    
        collage(:,:,1,i) = L;
        collage(:,:,2,i) = A;
        collage(:,:,3,i) = B;
    end
    
    %h = montage(collage, 'Size', [4 5]);
end
