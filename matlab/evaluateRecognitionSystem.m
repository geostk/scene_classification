function [conf] = evaluateRecognitionSystem()
% Evaluates the recognition system for all test-images and returns the confusion matrix

	load('vision.mat');
	load('../dat/traintest.mat');
    nTest = length(test_imagenames(:,1));
    predicted = []
    actual = []
    
    for i = 1:nTest
        img = strcat('../dat/', test_imagenames{i});
        image = imread(img);
        size(image);
        wordMap = getVisualWords(image, filterBank, dictionary);
        h = getImageFeaturesSPM(3, wordMap, size(dictionary,2));
        distances = distanceToSet(h, train_features);
        [~,nnI] = max(distances);
        
        pred = train_labels(nnI);
        predicted = [predicted pred];
    end
    
    actual = test_labels(1:nTest);

    % create a confusion matrix
    conf = confusionmat(actual, predicted)
    display(['size of confusion matrix is ', num2str(size(conf))])
    
    accuracy = trace(conf)/sum(conf(:))
end