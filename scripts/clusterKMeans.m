function [closestMean, meanLocs, nIters ] = clusterKMeans( data, k, maxIters )
%CLUSTERKMEANS Runs kmeans algorithm.
%   [CLOSESTMEAN, MEANLOCS, NITERS ] = CLUSTERKMEANS( DATA, K, MAXITERS )
%   runs the k-means algorithm with K centers on DATA. 
%   DATA       :  an N by P matrix where N rows are the number of 
%                 datapoints and P columns is the number of attributes. 
%                 The algorithm runs until convergence or the max 
%                 number of iterations. 
%   CLOSESTMEAN: is a vector of length N with labels for each datapoint. 
%   MEANLOCS   : is a K by P matrix with the locations of mean K in row K 
%                as labeled in the CLOSESTMEAN vector. 
%   NITERS     : is the number of iterations the algorithm ran.
% 
%   Shell and Comments Written by Jake Olson
%
%   Program written by: Tony Wijaya Salim
%   Last modified: October 9 2016

%% Important! Do NOT seed the random number generator. If you do not know 
% what this means, that is okay.

%% Variable Initialization
nIters = 0;
dim = size(data);
num_data = dim(1);

labels = zeros(1,num_data); % initial label, this will be assigned to closestMean later on, label is easier to read

%% Initialize means randomly among points
% Grab k datapoints and store in matrix of initial means. We gave the
% input parameters to make the function sample our data without
% replacement. This means a point cannot be chosen more than once, which is
% what we want for selecting means.
initialMeanPoints = datasample(data,k,'Replace',false); 

means = initialMeanPoints; % use means to store the changing means throughout the program

%% Iterate through a max number of times
while nIters < maxIters
    
    prev_label = labels;    % store the label to be compared with new label later
    
    %% Label it to be with the closest mean
    for i = 1:num_data
      %% Find the label of the mean where distance is shortest to (using function created from other file)
      %% and assign label to it
       my_dist = zeros(1,size(means,1));
       
       % for distance to every means
       for j = 1:size(means,1)
            my_dist(j) = pdist([ data(i,:); means(j,:)]); % calculate the distance
       end
       labels(i) = find( my_dist == min(my_dist), 1); % choose first one of the shortest distance found
     
    end
    
    %% Check if the label or means changed at all
    if (isequal(prev_label, labels))
        break; % no change in labels mean algorithm is done clustering
    end
    
    %% Create new means, sice some label is different
    for i = 1:k
        means(i) = mean( data(labels == i)); % magic of logical operator filtering
    end
   
    nIters = nIters + 1;
end
%% Plot output as a bunch of points with different colors for each cluster.
% This is a function I have written that plots the first two dimensions of
% the data. You must download it and place it on the path or in the same
% folder as this function to use it.
plotMyDots(data,means,labels);

%% Prepare output.
closestMean = labels; % prepare label for output
meanLocs = means;     % means to be output


end

