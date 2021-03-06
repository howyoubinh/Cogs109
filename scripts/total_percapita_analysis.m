%% Import data from spreadsheet


%% Import the data
clear;
[~, ~, raw] = xlsread('total_and_per_capita_wealth_of_nations.xlsx','total wealth, 1995');
raw = raw(7:215,2:21);
raw(cellfun(@(x) ~isempty(x) && isnumeric(x) && isnan(x),raw)) = {''};
cellVectors = raw(:,[1,2,3]);
raw = raw(:,[4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20]);

% Replace non-numeric cells with NaN
R = cellfun(@(x) ~isnumeric(x) && ~islogical(x),raw); % Find non-numeric cells
raw(R) = {NaN}; % Replace non-numeric cells

% Create output variable
data = reshape([raw{:}],size(raw));


% Allocate imported array to column variable names
Code = cellVectors(:,1);
Region = cellVectors(:,2);
IncomeGr = cellVectors(:,3);
Population = data(:,1);
TotalWealth = data(:,2);
IntangibleCapital = data(:,3);
NetForeignAssets = data(:,4);
ProducedCapital = data(:,5);
NaturalCapital = data(:,6);
Crop = data(:,7);
PastureLand = data(:,8);
ForestTimber = data(:,9);
ForestNTF = data(:,10);
ProtectedAreas = data(:,11);
Oil = data(:,12);
NaturalGas = data(:,13);
Hardcoal = data(:,14);
Softcoal = data(:,15);
Minerals = data(:,16);
SubsoilAssets = data(:,17);


%% IMPORTANT, this is used to filter out NaN by x and y
x     = ProtectedAreas;             % change the input here x,y,group
y     = TotalWealth;          % group can be either Code,Region,IncomeGr

filter = (~isnan(y) + ~isnan(x) - 1 == 1);
data  = data(filter,:);
cellVectors = cellVectors(filter,:);
Code = cellVectors(:,1);
Region = cellVectors(:,2);
IncomeGr = cellVectors(:,3);
x = x(filter,:);
y = y(filter,:);


%% test plot
groups = [Region' ; IncomeGr'];
% group  = Region';
% [C,ia,ic] = unique(group,'stable'); % C is the label
% gscatter(x, y, ic);
% legend(C);
    
figure(1);


    [C,ia,ic] = unique(groups(1,:),'stable'); % C is the label
    subplot(2,1,1);
    gscatter(x, y, ic);
    k1 = length(ia);
    xlabel('Protected Areas');
    ylabel('Total Wealth');
    hold on;
    legend(C);


    [C,ia,ic] = unique(groups(2,:),'stable'); % C is the label
    k2 = length(ia);
    subplot(2,1,2);
    gscatter(x, y, ic);
    xlabel('Protected Areas');
    ylabel('Total Wealth');
    legend(C);

hold off;

%% Running K-means
i = 50;                     % change the iteration here
data = [x y];

[means, meanlocs, iter] = clusterKMeansSolution(data,k1, i);
[means, meanlocs, iter] = clusterKMeansSolution(data,k2, i);


%% Gaussian Clustering
X = data;
[n,p] = size(X);
k = 6;
Sigma = {'diagonal','full'};
nSigma = numel(Sigma);
SharedCovariance = {true,false};
SCtext = {'true','false'};
nSC = numel(SharedCovariance);
d = 500;
x1 = linspace(min(X(:,1)) - 2,max(X(:,1)) + 2,d);
x2 = linspace(min(X(:,2)) - 2,max(X(:,2)) + 2,d);
[x1grid,x2grid] = meshgrid(x1,x2);
X0 = [x1grid(:) x2grid(:)];
threshold = sqrt(chi2inv(0.99,2));
options = statset('MaxIter',50); % Increase number of EM iterations

figure;
c = 1;
for i = 1:nSigma;
    for j = 1:nSC;
        gmfit = fitgmdist(X,k,'CovarianceType',Sigma{i},...
            'SharedCovariance',SharedCovariance{j},'Options',options);
        clusterX = cluster(gmfit,X);
        mahalDist = mahal(gmfit,X0);
%         subplot(2,2,c);
        h1 = gscatter(X(:,1),X(:,2),clusterX);
        hold on;
            for m = 1:k;
                idx = mahalDist(:,m)<=threshold;
                Color = h1(m).Color*0.75 + -0.5*(h1(m).Color - 1);
                h2 = plot(X0(idx,1),X0(idx,2),'.','Color',Color,'MarkerSize',1);
                uistack(h2,'bottom');
            end
        plot(gmfit.mu(:,1),gmfit.mu(:,2),'kx','LineWidth',2,'MarkerSize',10)
        title(sprintf('Sigma is %s, SharedCovariance = %s',...
            Sigma{i},SCtext{j}),'FontSize',8)
        legend(h1,{'1','2','3','4','5','6'});
        hold off
        c = c + 1;
    end
end

%% Clear temporary variables
% clearvars data raw cellVectors R;