%% Import data from spreadsheet
% Script for importing data from the following spreadsheet:
%
%    Workbook: /home/atomic/git/COGS109_Final/scripts/Wealth_Accounting.xlsx
%    Worksheet: Data
%
% To extend the code for use with different selected data or a different
% spreadsheet, generate a function instead of a script.

% Auto-generated by MATLAB on 2016/11/25 18:42:40

clear;
%% Import the data
[~, ~, WealthAccounting] = xlsread('Wealth_Accounting.xlsx','Data');
WealthAccounting = WealthAccounting(2:end,1:4);
WealthAccounting(cellfun(@(x) ~isempty(x) && isnumeric(x) && isnan(x),WealthAccounting)) = {''};


% Auto-generated by MATLAB on 2016/11/25 18:43:34

%% Import the data
[~, ~, raw] = xlsread('Wealth_Accounting.xlsx','Data');
raw = raw(2:end,5:end);
raw(cellfun(@(x) ~isempty(x) && isnumeric(x) && isnan(x),raw)) = {''};

%% Replace non-numeric cells with NaN
R = cellfun(@(x) ~isnumeric(x) && ~islogical(x),raw); % Find non-numeric cells
raw(R) = {NaN}; % Replace non-numeric cells

%% Create output variable
data = reshape([raw{:}],size(raw));


%% Clear temporary variables
% clearvars data raw R;

% Using 5 different regions for Energy depletion (% of GNI)
% Note: Data taken from Wealth_Accounting
% 1. East Asia & Pacific (row 107 in data, row 108 in Wealth_Accounting)
% 2. Europe & Central Asia (200)
% 3. Latin America & Caribbean (448)
% 4. Middle East & North Africa (634)
% 5. Sub-Saharan Africa (913)
% World (

year = [1970:2014];
figure(1);
subplot(2,1,1)
plot(year, data(1006,:));
legend('World');
xlabel('Year');
ylabel('Energy depletion (% of GNI)');
ylim([0 30]);

subplot(2,1,2)
hold;
plot(year, data(107,:)); % 1.
plot(year, data(200,:)); % 2.
plot(year, data(448,:)); % 3.
plot(year, data(634,:)); % 4.
plot(year, data(913,:)); % 5.
legend('East Asia & Pacific', 'Europe & Central Asia', ...
    'Latin America & Caribbean', 'Middle East & North Africa', ...
    'Sub-Saharan Africa');
xlabel('Year');
ylabel('Energy depletion (% of GNI)');
ylim([0 30]);
hold off;
%% 
%hold;
%figure(2);
%plot(year, data(1006-31,:) - data(1006,:));

%%
%figure(3);
%hold;
%plot(year, data(1006,:));
%plot(year, data(1006+31,:));