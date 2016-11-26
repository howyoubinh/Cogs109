%% Test plot with size
run( 'total_percapita_1995.m' );


% NOTE: run 'total_percapita_1995.m' first before running the codes here
%% Trying to scatter plot and group

wealth = data(:,2);
asset = data(:,17);
% sz = data(:,2);
income_level = {cellVectors{:,3}}';
[C,ia,ic] = unique(income_level,'stable'); % C is the label
figure
xlabel('Asset');
ylabel('Asset');
title('Comparison of Wealth vs Subsoil Asset Grouped to Different Income Level');
gscatter(asset,wealth,ic);

%%
% legend('points','1st order', '2nd order', '3rd order', 'Location','NorthWest');


%% figure plot
figure;
group = [ repmat([1],1,100) repmat([2],1,50) repmat([3], 1,59)]';
gscatter(y,x,group,'br','xo','xo')
xlabel('Wealth');
ylabel('Sub Asset');

%% asdasda

x = data_filtered(:,17);
y = data_filtered(:,2);
% sz = data(:,2);
sz  = linspace(1,300,125);
test_label = [ repmat([1],1,60) repmat([2],1,65)]';

scatter(x,y,sz, sz);

%% Using dictionary to map region to labels
keySet = {'Sub-Saharan Africa', 'South Asia', 'Middle East & North Africa', 'Latin America & Caribbean', 'Europe & Central Asia','East Asia & Pacific', '..'}
[~,~,label_num ] = unique(keySet,'stable')
mapObj = containers.Map(keySet, label_num)

% cellfun(@transpose,A,'UniformOutput',false)