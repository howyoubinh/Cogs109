% First we need to load each column of the data

%% Grab file, open it and read it line by line.
filename = 'total_and_per_capita_wealth_of_nations.csv'; % change for different files. Could build another loop to loop through files.
fileID = fopen(filename, 'r');

% get to the beginning of actual data in data file
for i=1:3
    line = fgetl(fileID);
end

dataPoint = 0;
% for now, just grabbing year, month, day, and rain values for each line of
% the file.
economy = {};
total_wealth = {};
net_foreign_assets = {};
protected_areas = {};
subsoil_assets = {};

while line ~= -1
    
    split_lines = strsplit(line,',');
    
    % this check make sure we are still iterating through the dataset
    % we are focusing on, even though we havent reached the end of file
    if(length(split_lines) < 21)
        break;
    end
    
    % next we get all the features we need from the data
    % and store in variable
    dataPoint = dataPoint+1;
    economy{dataPoint} = split_lines{1};
    total_wealth{dataPoint} = split_lines{6};
    net_foreign_assets{dataPoint} = split_lines{8};
    protected_areas{dataPoint} = split_lines{15};
    subsoil_assets{dataPoint} = split_lines{21};
    % we might want to use str2num or str2double to convert
    % some of these features to numbers

    line = fgetl(fileID);
end

% we want to also get the status to make sure
% we know the data Rows that have data
% in the features we are ooking for
total_wealth = str2double(total_wealth);
net_foreign_assets = str2double(net_foreign_assets);
protected_areas = str2double(protected_areas);
subsoil_assets = str2double(subsoil_assets);

% we can not plot 'economy' as string so
% we use a vector to represent each country
economies = [1:1:209];


% plot graphs to bette runderstand data
%figure;

%plot(economies, total_wealth, '*');
%hold on
%plot(economies, net_foreign_assets, '.');

% we may need to divide by the land size to get rationalized results

%plot(economies, protected_areas, '+');
plot(total_wealth, subsoil_assets, '*');
%hold off

% Once we have the general plots from wealth of nations data
% we can ask more specifiic details about subsoil assets using
% wealth accounting data, which is more detailed



% close all file
fclose('all');


%economy = diag(ones(1, length(Economy)-1 ));
% then we want to store some data as variables for ease of reference
% [total, b] = size(Economy);
% economy_population = [Economy; Population];

% we want to make a simple visualization
% plot(economy_population(:,1) , econoomy_population(:,2));
%for n = 1:size(Economy) 
% for n = 1:10 
%     disp('hi');
% end
