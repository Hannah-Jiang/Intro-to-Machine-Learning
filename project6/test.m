load zip.train;
subsample = zip(find(zip(:,1)==1 | zip(:,1) == 3),:);
y_tr = subsample(:,1);
% y3 = find(y_tr == 5);
% y_tr(y3) = 1;
X_tr = subsample(:,2:257);

load zip.test;
subsample = zip(find(zip(:,1)==1 | zip(:,1) == 3),:);
y_te = subsample(:,1);
% ye3 = find(y_te == 5);
% y_te(ye3) = 1;
X_te = subsample(:,2:257);
[ train_err, test_err ] = AdaBoost( X_tr, y_tr, X_te, y_te, 10 );
plot(train_err);
hold on
plot(test_err, 'red');
xlabel('number of stumps')
ylabel('error')
hold off