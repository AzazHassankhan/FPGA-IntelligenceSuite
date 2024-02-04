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
    a = 2^16;
    % Coeffiecients
    x1 = fix((-0.076)*a);
    x2 = fix((0.762)*a);
    x3 = fix((-0.118)*a);
    x4 = fix((0.600)*a);
    x5 = fix((-0.641)*a);
    x6 = fix((0.167)*a);
    x7 = fix(0.667 * a);
    x8 = fix((-0.187)*a);
    x9 = fix((-0.180)*a);
    m1 = fix(1.034*a);
    m2 = fix(-0.010*a);
    m3 = fix(-0.601*a);
    m4 = fix(0.194*a);
    % Input Layer
    Node_1_1(kk)  = fix(Feature_1(kk)*x1);
    Node_2_1(kk)  = fix(Feature_1(kk)*x2);
    Node_3_1(kk)  = fix((Feature_1(kk)*x3))  ;
    Node_1_2(kk)  = fix((Feature_2(kk)*x4))  ; 
    Node_2_2(kk)  = fix((Feature_2(kk)*x5)) ;
    Node_3_2(kk)  = fix((Feature_2(kk)*x6)) ;
    Node_1(kk)    =  Node_1_1(kk) + Node_1_2(kk) + m1;
    Node_2(kk)    =  Node_2_1(kk) + Node_2_2(kk) + m2;
    Node_3(kk)    =  Node_3_1(kk) + Node_3_2(kk) + m3;
    % Hidden Layer
   
    % Relu 1
    if Node_1(kk) > 0
            Relu_1(kk)  = Node_1(kk);
    else
            Relu_1(kk)  = 0;
    end
    
    % Relu 2
    if Node_2(kk) > 0
            Relu_2(kk)  = Node_2(kk);
    else
            Relu_2(kk)  = 0;
    end
    
    % Relu 3
    if Node_3(kk) > 0
            Relu_3(kk)  = Node_3(kk);
    else
            Relu_3(kk)  = 0;
    end
    
    % Sigmoid_1
    Sigmoid_1(kk) = fix(Relu_1(kk)/2^16)* x7;
    % Sigmoid_2
    Sigmoid_2(kk) = fix(Relu_2(kk)/2^16)* x8;
    % Sigmoid_3
    Sigmoid_3(kk) = fix(Relu_3(kk)/2^16)* x9;
    
    x(kk)         = fix(((Sigmoid_1(kk) + Sigmoid_2(kk) + Sigmoid_3(kk) + m4))/2^14);
    x(kk) =  x(kk) * (-1);
    % Output Layer
    r = 0;
    p = 1;
    f = 1;
for i = 1:5
    r1 = fix((r*f + p));
    r = fix((r1)/(f));
    % Update the power of x
    p =  fix(p * x(kk));
    % Factorial
    f = fix(f * i *2^2);
end 

    exp(kk) = 1+x(kk) - fix((x(kk)^2)/2) + fix((x(kk)^3)/6);  % Piplined Exp
    
    Sigmoid(kk)   = exp(kk);
    
    if Sigmoid(kk) < 1
            Decision(kk) = 1;
    else
            Decision(kk) = 0;
    end       
end

