function [closestMean, meanLocs, nIters ] = clusterKMeans( data, k, maxIters )
%CLUSTERKMEANS Runs kmeans algorithm.
%   [CLOSESTMEAN, MEANLOCS, NITERS ] = CLUSTERKMEANS( DATA, K, MAXITERS )
%   runs the k-means algorithm with K centers on DATA. DATA is an N by P
%   matrix where N rows are the number of datapoints and P columns is the
%   number of attributes. The algorithm runs until convergence or the max
%   number of iterations. CLOSESTMEAN is a vector of length N with labels
%   for each datapoint. MEANLOCS is a K by P matrix with the locations of
%   mean K in row K as labeled in the CLOSESTMEAN vector. NITERS is the
%   number of iterations the algorithm ran.
%
%   Shell and Comments Written by Jake Olson
%   Program written by: Jake Olson
%   Last modified August 12 2016

%% Important! Do NOT seed the random number generator. If you do not know 
% what this means, that is okay.

%% Variable Initialization
[n p] = size(data);

%% Initialize means randomly among points
initialMeanPoints = datasample(data,k,'Replace',false);

% Alternative ways to initialize - same effect, grabbing random points.
% randi samples w replacement. Randperm samples w/out replacement. 
% We don't want the same number twice, so we want w/out replacement. So we
% can use randperm: or we can use randi and then use the following 
% whileloop: (commented out)
% meanInitIndices = randi(n,[k,1]); 
% % To fix in case we initialize two means to the same point:
% while length(unique(meanInitIndices)) < length(meanInitIndices)
%     meanInitIndices = randi(n,[k,1]);
% end
% Grabs the rows at the indices we grabbed from randperm and puts them in
% meanLocs - now we have our kMeans!
% meanLocs = data(initialMeanPoints,:);
meanLocs = initialMeanPoints;

% Iterate through a max number of times
for iIters = 1:maxIters
    % Find the distance to each mean
    distanceToMeans = pdist2(data, meanLocs);
    
    % Label it to be with the closest mean
    [minDist,closestMean] = min(distanceToMeans,[],2);
    
    % Create new means - find mean of all the points in each cluster.
    newMeans = zeros(size(meanLocs));
    for iMean = 1:k
        newMeans(iMean,:) = mean(data(closestMean==iMean,:),1);
    end
    
    % Check if means do not move!
    if newMeans == meanLocs
        % Quit if means do not move! Woooohoooo!
        break
    end
    
    % If they do move, do it all again!
    meanLocs = newMeans; % Update locations of means to new locations.
end

% Plot output as a bunch of points with different colors for each cluster.
plotMyDots(data,meanLocs,closestMean);

% Prepare output.
nIters = iIters;
end

