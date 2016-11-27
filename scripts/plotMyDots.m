function plotMyDots( data, means, labels)
%PLOTMYDOTS Plots kmeans clustered data.
%   Plots kmeans clustered data. Give it the data in a N x P format, N is
%   datapoints and P is dimensions/attributes. Means should be K x P where
%   K is the number of means.
% 
%   Plots first two dimensions (columns) of data labeled into clusters by
%   the vector labels. Plots means on second graph.
%
%   Sample usage: plotMyDots(clusterData, meanLocs, labels)
%
%   Written by Jake Olson
%   Last modified August 11 2015

% figure;
% gplotmatrix(data(:,1),data(:,2),labels);
% figure;
% plot(means(:,1),means(:,2),'xk','Markersize',20,'Linewidth',5);
% axis([min(data(:,1))-1, max(data(:,1))+1, min(data(:,2))-1, max(data(:,2))+1]);

figure;
scatter(data(:,1),data(:,2),16,labels,'filled');
hold on;
plot(means(:,1),means(:,2),'xk','Markersize',20,'Linewidth',5);
axis([min(data(:,1))-1, max(data(:,1))+1, min(data(:,2))-1, max(data(:,2))+1]);
hold off;
end

