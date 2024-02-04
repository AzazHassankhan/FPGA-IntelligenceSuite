clear
close all
clc

% Loading and Plotting Accelerometer Data

Data = load('TSLA_STOCKS.csv');	% Loading Stock data

Close = Data(:,1); % Close Prices
High  = Data(:,2); % High Prices
Low   = Data(:,3); % Low Prices
n = length(Data);

% Logistic Regression
for kk = 1:n       
        Feature_1(kk) = High(kk) - Close(kk);
        Feature_2(kk) = Close(kk) - Low(kk);
        Exp(kk) = exp((9.48745412*10^(-7))+ (Feature_1(kk)*(0.00173748)) - (Feature_2(kk)*(0.0018421)));
        LR(kk) = 1/(1 + Exp(kk));
        if LR(kk) > 0.5
            Decision(kk) = 1;
        else
            Decision(kk) = 0;
        end
end

% Logistic Regression using talyor series FOR FPGA

kk = length(Data);		

for n = 1:kk
    Feature_1(n) = fix(High(n) - Close(n));
    Feature_2(n) = fix(Close(n) - Low(n));
    inercept = fix((2^24)*9.48745412*10^(-7));
    Coeff_1(n) = fix(fix((2^24)*(0.00173748))*fix(Feature_1(n)));
    Coeff_2(n) = fix(fix((2^24)*(0.0018421))*fix(Feature_2(n)));
    x(n) = inercept + Coeff_1(n) - Coeff_2(n);
    x(n)= fix(x(n)/2^22);
    r = 0;
    p = 1;
    f = 1;
for i = 1:28
    r1 = fix((r*f + p));
    c(i,n) = r1;
    r = fix((r1)/(f));
    % Update the power of x
    p =  fix(p * x(n));
    a(i,n) = p;
    % Factorial
    f = fix(f * i *2^2);
    b(i,n) = f;
    d(i,n) = r;
end 
    exp(kk) = 1+x(n) - fix((x(n)^2)/2) + fix((x(n)^3)/6);  % Piplined Exp
    
    k(n) = exp(kk);
        if k(n) < 1
            Decision1(n) = 1;
        else
            Decision1(n) = 0;
        end
end
