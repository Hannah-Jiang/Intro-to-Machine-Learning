X = importdata('cleveland-train.csv');
Y = X.data(:,14);
[w, e_in] = logistic_reg( X, Y, 10^4 );
find_test_error( w, X, Y );