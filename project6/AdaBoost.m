function [ train_err, test_err ] = AdaBoost( X_tr, y_tr, X_te, y_te, n_trees )
%AdaBoost: Implement AdaBoost using decision stumps learned
%   using information gain as the weak learners.
%   X_tr: Training set
%   y_tr: Training set labels
%   X_te: Testing set
%   y_te: Testing set labels
%   n_trees: The number of trees to use

%initialize D
W = ones(size(X_tr,1),1); 
W = W./sum(W);
trees = cell(n_trees,1);
for i=1:n_trees
    i
    trees{i} = decisionStumps(X_tr, y_tr, W);
    trees{i}.alpha = log((1-trees{i}.err)/trees{i}.err)/2; % tree error
    feature = trees{i}.id
    sp = trees{i}.split_value
    % update W
    for k = 1:size(y_tr,1)
        if  X_tr(k,trees{i}.id) < trees{i}.split_value && trees{i}.leftside  == y_tr(k,1) || X_tr(k,trees{i}.id) > trees{i}.split_value && trees{i}.rightside == y_tr(k,1)
            W(k,1) = W(k,1)/exp(trees{i}.alpha);
        else
            W(k,1) = W(k,1)*exp(trees{i}.alpha);
        end
    end % end of update W
    W = W./sum(W);
    
    %train err
    for e = 1:size(y_tr,1) % loop for train data
        pre1 = 0;
        pre3 = 0;
        for u = 1:i % loop for trees so far
            if X_tr(e,trees{u}.id ) < trees{u}.split_value && trees{u}.leftside == 3 || X_tr(e,trees{u}.id ) > trees{u}.split_value && trees{u}.rightside == 3
                pre3 = pre3 + trees{u}.alpha;
            else
                pre1 = pre1 + trees{u}.alpha;
            end
        end % end of loop tree
        
        if pre1 < pre3
            trainY(e,1) = 3;
        else
            trainY(e,1) = 1;
        end
    end % end of loop train data
    correct = trainY ~= y_tr;
    train_err(i,1) = sum(correct)/size(correct,1);
    train_err(i,1)
    % test error
    for o = 1:size(y_te,1) %loop with all ys at test data
        pre1 = 0;
        pre3 = 0;
        for t = 1:i % loop with all trees so far
            if X_te(o,trees{t}.id ) <= trees{t}.split_value && trees{t}.leftside == 3 || X_te(o,trees{t}.id ) > trees{t}.split_value && trees{t}.rightside == 3
                pre3 = pre3 + trees{t}.alpha;
            else
                pre1 = pre1 + trees{t}.alpha;
            end
        end
        
        if pre1 < pre3
            testY(o,1) = 3;
        else
            testY(o,1) = 1;
        end
    end % end of test err
    predict = testY ~= y_te;
    test_err(i,1) = sum(predict)/size(predict,1);
    test_err(i,1)
end % end of iteration
end % end of function


