%% Combined Scripts to load all wealth per capita following the scripts generator

clear all;



%% Import the data 1995
[~, ~, raw] = xlsread('/home/atomic/git/COGS109_Final/scripts/total_and_per_capita_wealth_of_nations.xlsx','total wealth, 1995');
raw = raw(7:215,2:21);
raw(cellfun(@(x) ~isempty(x) && isnumeric(x) && isnan(x),raw)) = {''};
cellVectors = raw(:,[1,2,3]);
raw = raw(:,[4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20]);

%% Replace non-numeric cells with NaN
R = cellfun(@(x) ~isnumeric(x) && ~islogical(x),raw); % Find non-numeric cells
raw(R) = {NaN}; % Replace non-numeric cells

%% Create output variable
data_1995 = reshape([raw{:}],size(raw));



%% Import the data 2000
[~, ~, raw] = xlsread('/home/atomic/git/COGS109_Final/scripts/total_and_per_capita_wealth_of_nations.xlsx','total wealth, 2000');
raw = raw(7:215,2:21);
raw(cellfun(@(x) ~isempty(x) && isnumeric(x) && isnan(x),raw)) = {''};
cellVectors = raw(:,[1,2,3]);
raw = raw(:,[4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20]);

%% Replace non-numeric cells with NaN
R = cellfun(@(x) ~isnumeric(x) && ~islogical(x),raw); % Find non-numeric cells
raw(R) = {NaN}; % Replace non-numeric cells

%% Create output variable
data_2000 = reshape([raw{:}],size(raw));

%% Import the data 2005
[~, ~, raw] = xlsread('/home/atomic/git/COGS109_Final/scripts/total_and_per_capita_wealth_of_nations.xlsx','total wealth, 2005');
raw = raw(7:215,2:21);
raw(cellfun(@(x) ~isempty(x) && isnumeric(x) && isnan(x),raw)) = {''};
cellVectors = raw(:,[1,2,3]);
raw = raw(:,[4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20]);

%% Replace non-numeric cells with NaN
R = cellfun(@(x) ~isnumeric(x) && ~islogical(x),raw); % Find non-numeric cells
raw(R) = {NaN}; % Replace non-numeric cells

%% Create output variable
data_2005 = reshape([raw{:}],size(raw));


%% See the separate files on for index slices