load zip.train;
fprintf('\nNow working on the three-vs-five problem...\n\n');
subsample = zip(find(zip(:,1)==3 | zip(:,1) == 5),:);
load zip.test;
subtestsample = zip(find(zip(:,1)==3 | zip(:,1) == 5),:);

Y = subsample(:,1);
X = subsample(:,2:257);
% error = BaggedTrees( X, Y, 200 )

testY = subtestsample(:,1);
testX = subtestsample(:,2:257);

index = floor(size(X,1)*rand(size(X,1),1))+1;
for i=1:size(X,1)
        trainx(i,:) = X(index(i),:);
        trainy(i,1) = Y(index(i),1);
end

ct = fitctree(trainx,trainy);
predicty = predict(ct,testX);

Err = testY == predicty;
error=1-sum(Err)/size(Err,1);
fprintf('The test error of 1 bagged decision trees is %.4f\n', error);

% load zip.train;
% fprintf('\nNow working on the one-vs-five problem...\n\n');
% subsample = zip(find(zip(:,1)==1 | zip(:,1) == 5),:);
% load zip.test;
% subtestsample = zip(find(zip(:,1)==1 | zip(:,1) == 5),:);
% 
% Y = subsample(:,1);
% X = subsample(:,2:257);
% 
% testY = subtestsample(:,1);
% testX = subtestsample(:,2:257);
% 
% index = floor(size(X,1)*rand(size(X,1),1))+1;
% for i=1:size(X,1)
%         trainx(i,:) = X(index(i),:);
%         trainy(i,1) = Y(index(i),1);
% end
% 
% ct = fitctree(trainx,trainy);
% 
% for j=1:size(testY)
%    predicty(j,1) = predict(ct,testX(j,:));
% end
% 
% Err = 0;
% for m=1:size(testY)
%    if testY(m,1) ~=  predicty(m,1)
%        Err = Err+1;
%    end
% end
% error=Err/size(testY,1);
% fprintf('The test error of 1 bagged decision trees is %.4f\n', error);