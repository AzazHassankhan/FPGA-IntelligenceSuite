clear
close all
clc


% Loading and Plotting Accelerometer Data

Data = load('data.csv');	% Loading Stock data

High    = Data(:,1);        % Close Prices
Low     = Data(:,2);        % High Prices
Close   = Data(:,3);        % Low Prices
n       = length(Data);

for kk = 1:n       
    Feature_1(kk) = High(kk) - Close(kk);
    Feature_2(kk) = Close(kk) - Low(kk);
if Feature_1(kk) <= 282.5                        % ROOT NODE
        if Feature_2(kk) <= 323.5                % NODE 1
             if Feature_2(kk) <= 100.5           % NODE 2
                decision(kk)=0;
             else 
                decision(kk)=1;
             end
        else
             if Feature_1(kk) <= 221.0           % NODE 2
                 decision(kk)=1;
             else 
                 decision(kk)=1;
             end
        end
else
        if Feature_2(kk) <= 459.5               % NODE 1
             if Feature_1(kk) <= 421.0          % NODE 2
                decision(kk)=0;
             else 
                 decision(kk)=0;
             end
        else
             if Feature_1(kk) <= 1023.5         % NODE 2
                 decision(kk)=1;
             else 
                 decision(kk)=0;
             end
        end       
    end
end