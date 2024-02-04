clear
close all
clc

% Loading and Plotting Accelerometer Data

Data = load('TSLA_STOCKS.csv');	% Loading Stock data

Close = Data(:,1); % Close Prices
High  = Data(:,2); % High Prices
Low   = Data(:,3); % Low Prices
n = length(Data);

for kk = 1:n       
    Feature_1(kk) = High(kk) - Close(kk);
    Feature_2(kk) = Close(kk) - Low(kk);
    prediction(kk)= - (Feature_1(kk)*0.00296271) +  (Feature_2(kk)*0.00236666)  + (0.1719951);
    if  prediction(kk) > 0
            Decision(kk) = 1;
    else
            Decision(kk) = 0;
    end
end