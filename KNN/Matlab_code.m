clear
close all
clc

X_test = load('X_test.csv');	% Loading Stock data
n = length(X_test);
X_train = load('X_train.csv');	% Loading Stock data
n1 = length(X_train);
y_train = load('y_train.csv');	% Loading Stock data
n2 = length(y_train);
Dist = 0 ;
tic
for ii = 1:n 

% Euclidean Distance
    for kk = 1:n 
          Dist(kk) = abs(X_test(ii) - X_train(kk));
          index(kk) =kk;
    end

    % Index Sorting 
    for kk = 1:n
          for jj = 1:n-1
              if Dist(index(jj))> Dist(index(jj+1))
                  temp = index(jj);
                  index(jj) = index(jj+1);
                  index(jj+1) = temp;
              end
          end
    end
    % K Nearest Neigbours
    Buy = 0;
    Sell = 0;
    for k = 1:7
        if y_train(index(k)) ==1
            Buy  = Buy+1;
        else
            Sell = Sell+1;
        end
    end
    % decision
        if Buy> Sell
            Decision(ii) = 1;
        else 
            Decision(ii) = 0;
        end
end

elapsed_time = toc;