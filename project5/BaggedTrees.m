function [ oobErr ] = BaggedTrees( X, Y, numBags )
%BAGGEDTREES Returns out-of-bag classification error of an ensemble of
%numBags CART decision trees on the input dataset, and also plots the error
%as a function of the number of bags from 1 to numBags
%   Inputs:
%       X : Matrix of training data
%       Y : Vector of classes of the training examples
%       numBags : Number of trees to learn in the ensemble
%
%   You may use "fitctree" but do not use "TreeBagger" or any other inbuilt
%   bagging function

DT = cell(numBags,1);
for k=1:numBags
     k
    index{k} = floor(size(X,1)*rand(size(X,1),1))+1;
    in = index{k};
   
    yn = 0;
    for i=1:size(X,1)
        if any(in(:) == i) == 0
            yn = yn+1;
            testx(yn,:)=X(i,:);
            testy(yn,1)=Y(i,1);
            idx(yn,1) = i;
        else
            trainx(i,:) = X(in(i),:);
            trainy(i,1) = Y(in(i),1);
        end
    end
    
    % make decision tree
    d = fitctree(trainx,trainy);
    DT{k} = struct('dt', d);
      
%     select test decisition trees, different data test with different set
%     of trees.
%     get predict result for each test data.
    for j=1:size(testy,1)
        index_test = idx(j,1); % index_test is index in X
        %select decision trees which did not used index_test
        pc = 1;
        if k == 1
            p = predict(DT{1}.dt,testx);
        else
        for c = 1:k
            if any(index{c} == index_test) == 0 % index_test is not used to construct this tree
                p(pc,1)=predict(DT{c}.dt,testx(j,:));
                pc = pc+1;
            end
        end
        end
        
        %get majority
        h1 = size(find(p==1),1);
        h5 = size(find(p==5),1);
        if h1 > h5
            predicty(j,1) = 1;
        elseif h1 < h5
            predicty(j,1) = 5;
        else
            predicty(j,1) = randsrc(1,1,[1 5]);
        end
    end

Err = testy == predicty;
error(k,1)=1-sum(Err)/size(testy,1);
clear in;
clear trainx;
clear trainy;
clear testx;
clear testy;
clear idx;
clear p;
clear predicty;

end
e=1:numBags;
plot(e,error(e,1));
ylabel('out of bag error');
xlabel('number of bags');
oobErr=error(numBags,1);
error;

% test for test data
% load zip.test;
% testsample = zip(find(zip(:,1)==1 | zip(:,1) == 5),:);
% 
% testX = testsample(:,2:257);
% testY = testsample(:,1);
% 
% for j=1:size(testY,1)
%     for t = 1:numBags
%         ct = DT{t}.dt;
%         vote(t,1) = predict(ct,testX(j,:));
%     end
% 
%     size3 = size(find(vote == 1),1);
%     size5 = size(find(vote == 5),1);
%     if size3 >= size5
%         predictY(j,1) = 1 ;
%     else
%         predictY(j,1) = 5 ;
%     end
% end

% Err = testy == predicty;
% oobErr=1-sum(Err)/size(testy,1);
end

