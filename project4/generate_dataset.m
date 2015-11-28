function [ train_set test_set ] = generate_dataset( Q_f, N_train, N_test, sigma )
%GENERATE_DATASET Generate training and test sets for the Legendre
%polynomials example
%   Inputs:
%       Q_f: order of the hypothesis
%       N_train: number of training examples
%       N_test: number of test examples
%       sigma: standard deviation of the stochastic noise
%   Outputs:
%       train_set and test_set are both 2-column matrices in which each row
%       represents an (x,y) pair
train =  -1 + (1+1)*rand(N_train,1);
test = -1 + (1+1)*rand(N_test,1);
traineta = normrnd(0,1,N_train,1);
testeta = normrnd(0,1,N_test,1);
aq = normrnd(0,1,Q_f+1,1);

c = 0;
for d = 1:Q_f+1
c = c + 1/(2*(d-1)+1);
end
c = c^0.5;

train_set(:,1) = train(:,1);
ztrain = computeLegPoly( train(:,1), Q_f);
train_set(:,2) = c*ztrain*aq + traineta(:,1)*sigma;

test_set(:,1)=test(:,1);
ztest = computeLegPoly( test(:,1), Q_f);
test_set(:,2) = c*ztest*aq + testeta(:,1)*sigma;
end

