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
    if Feature_2(kk) <= 370.5                    % ROOT NODE
        if Feature_1(kk) <= -24475.175                % NODE 1
             if Feature_2(kk) <= 166.5           % NODE 2
                decision(kk)=0
             else 
                 decision(kk)=1
             end
        else
             if Feature_2(kk) <= 87.0          % NODE 2
                 decision(kk)=0
             else 
                 decision(kk)=0
             end
         
        end
            
    
    else
        
        if Feature_2(kk) <= 648               % NODE 1
             if Feature_1(kk) <= -23255.521         % NODE 2
                decision(kk)=0
             else 
                 decision(kk)=1
             end
        else
             if Feature_1(kk) <= -47560.3        % NODE 2
                 decision(kk)=0
             else 
                 decision(kk)=1
             end
         
        end       
        
    end
end