clear all
%Script that runs the set of necessary experiments. This is an example that
%you can use; you should change it as appropriate to answer the question to
%your satisfaction.

Q_f = 20:5:20; % Degree of true function
N = 80:40:120; % Number of training examples
var = 0:0.5:2; % Variance of stochastic noise
% 
% expt_data_mat = zeros(length(Q_f), length(N), length(var));
% 
for ii = 1:length(Q_f)
    for jj = 1:length(N)
        for kk = 1:length(var)
              overfit = computeOverfitMeasure(Q_f(ii),N(jj),1000,var(kk),500);
              ave = mean(overfit);
              middle = median(overfit);
              expt_data_mat(ii,jj,kk,1) = median(overfit);
              expt_data_mat(ii,jj,kk,2) = mean(overfit);
              disp(['Q_f = ', num2str(Q_f(ii)), ' , train_set = ', num2str(N(jj)), ' , var = ', num2str(var(kk)), ', median = ', num2str(middle), ', ave = ',num2str(ave)])
        end
    end
end

