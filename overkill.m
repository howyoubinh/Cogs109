%Karthik Komatineni A10891737
load xy; %loads file from folder

figure;
plot(x,y,'*','Markersize',20); % Plot the original data from file
xlim([-.5 6.5]); %limit data to a certain range
ylim([-10 40]);
x_test = -.5:.1:6.5; %set a test data that is seperate from the whole data
x_test = x_test'; %make it a column vector

%% 1st order
A1=[x ones(length(x),1)]; % Set a variable to the new matrix containing my ones and the leanth of x
w1=A1\y; % Set my weights to each of the variable divided by my y data
A1_test = [x_test ones(length(x_test),1)]; %test data
y1_test = A1_test*w1;
hold on %holds all previous points when plotting the next point
plot(x_test,y1_test,'k--','linewidth',3); %plots data
y = w1*length(x); %This is the final Y equals equation once the weight has been calculated
%Calculates sum squared error and prints it to command window
perf = sse(net, x_test ones, A1_tests, ew); 
printf perf;

%% 2nd order
A2=[x.^2 x ones(length(x),1)]; % Set a variable to the new matrix containing my ones and the leanth of x
w2=A2\y; % Set my weights to each of the variable divided by my y data
A2_test = [x_test.^2 x_test ones(length(x_test),1)]; %test data
y2_test = A2_test*w2;
hold on %holds all previous points when plotting the next point
plot(x_test,y2_test,'r--','linewidth',3);%plots data
y= w1*leanth(x)+w2*leanth(x^.2);%This is the final Y equals equation once the weight has been calculated

%Calculates sum squared error and prints it to command window
perf = sse(net, x_test ones, A2_tests, ew);
printf perf;

%% 3rd order
A3=[x.^3 x.^2 x ones(length(x),1)]; % Set a variable to the new matrix containing my ones and the leanth of x
w3=A3\y; % Set my weights to each of the variable divided by my y data
A3_test = [x_test.^3 x_test.^2 x_test ones(length(x_test),1)]; %test data
y3_test = A3_test*w3;
hold on %holds all previous points when plotting the next point
plot(x_test,y3_test,'r--','linewidth',3); %plots data
y= w1*leanth(x)+w2*leanth(x^.2)+w3*leanth(x^.3); %This is the final Y equals equation once the weight has been calculated

%Calculates sum squared error and prints it to command window
perf = sse(net, x_test ones, A2_tests, ew);
printf perf;
