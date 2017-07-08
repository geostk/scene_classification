function buildRecognitionSystem()
% Creates vision.mat. Generates training features for all of the training images.

	load('dictionary.mat');
	load('../dat/traintest.mat');
    train_features = [];
    layerNum = 3;
    
    dictionarySize = length(dictionary(1, :))
    nTraining = length(train_imagenames(:,1))
    train_labels = train_labels';

    for i = 1:nTraining
        imgName = strcat('../dat/', train_imagenames{i});
        img = imread(imgName);
        
        matFile = strrep(imgName, '.jpg', '.mat');
        
        wM = load(matFile, 'wordMap'); 
        wordMap = wM.wordMap;
        
        h = getImageFeaturesSPM(layerNum, wordMap, dictionarySize);
        train_features = [train_features, h];        
        train_categories(i) = mapping(train_labels(i));
    end
    
    size(train_features)
	save('vision.mat', 'filterBank', 'dictionary', 'train_features', 'train_labels');
end