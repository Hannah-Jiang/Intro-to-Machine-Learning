function [ w e_in ] = logistic_reg( X, Y, max_its, ita )
%LOGISTIC_REG Learn logistic regression model using gradient descent
%   Inputs:
%       X : data matrix
%       Y : data labels (plus or minus 1)
%   Outputs:
%       w : weight vector
%       e_in : in-sample error (as defined in LFD)
    
%X = importdata('cleveland-train.csv');
%N = size(X.data,1);
N = size(X,1);

% for n=1:N;
%     if X.data(n,14) == 0
%         X.data(n,14) = -1
%     end
% end

% Y = X.data(:,14);
% X.data(:,14) = [];
 [m,n]=size(X);
 X=[ones(m,1),X];
 X = zscore(X);
% X.data(1,:)
% for n=1:size(Y)
%     if Y(n,1) == 0
%         Y(n,1) = -1
%     end
% end
w=[0 0 0 0 0 0 0 0 0 0 0 0 0 0];
% max_its = 10^4
% ita = 10^(-5)
for i=0:max_its;
    Ein = 0.0;
    gin = 0.0;
       for n=1:N  
            gin =  gin + Y(n,1)*X(n,:)/(1+exp(Y(n,1)*X(n,:)*w'));
            Ein = Ein + log(1+exp(-Y(n,1)*X(n,:)*w'));
        end
      g = -1/N*gin;
      v = -g;
      gt = abs(g);
      if max(gt) < 10^(-6)
          break;
      end
      w=w+ita*v;
end
i
w;
e_in = Ein/N;

end
