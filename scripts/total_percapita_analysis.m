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
x     = TotalWealth;             % change the input here x,y,group
y     = NaturalCapital;          % group can be either Code,Region,IncomeGr

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
    hold on;
    legend(C);


    [C,ia,ic] = unique(groups(2,:),'stable'); % C is the label
    k2 = length(ia);
    subplot(2,1,2);
    gscatter(x, y, ic);
    legend(C);

hold off;

%% Running K-means
i = 50;                     % change the iteration here
data = [x y];

[means, meanlocs, iter] = clusterKMeansSolution(data,k1, i);
[means, meanlocs, iter] = clusterKMeansSolution(data,k2, i);


%%

%% Clear temporary variables
% clearvars data raw cellVectors R;