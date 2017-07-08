function [filterBank, dictionary] = getFilterBankAndDictionary(imPaths)
% Creates the filterBank and dictionary of visual words by clustering using kmeans.

% Inputs:
%   imPaths: Cell array of strings containing the full path to an image (or relative path wrt the working directory.
% Outputs:
%   filterBank: N filters created using createFilterBank()
%   dictionary: a dictionary of visual words from the filter responses using k-means.

    filterBank  = createFilterBank();
    alpha = 175;
    K = 200;
    filterTraining = [];
    
    for i=1:length(imPaths)
        % read in the images
        img = imread(imPaths{i});
        
        % create their filterResponse
        filterResponse = extractFilterResponses(img, filterBank);
        
        % Sample alpha random pixels
        n = length(filterResponse(:,1));
        r = randperm(n, alpha);
        filterResponse = filterResponse(r, :);
        
        % concat to filterTraining
        filterTraining = [filterTraining; filterResponse];
    end
    
    
    % Run K-means with filter_responses
    [~, dictionary] = kmeans(filterTraining, K, 'EmptyAction','drop');
    % take transpose of dictionary
    dictionary = dictionary';
end
