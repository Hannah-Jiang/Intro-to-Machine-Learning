adult = urlread(['http://archive.ics.uci.edu/ml/machine-learning-databases/adult/adult.data']);
VarNames = {'age' 'workclass' 'fnlwgt' 'education' 'educationNum'...
    'maritalStatus' 'occupation' 'relationship' 'race'...
    'sex' 'capitalGain' 'capitalLoss'...
    'hoursPerWeek' 'nativeCountry' 'income'};
adult = strrep(adult,'?','');
adult = textscan(adult,'%f%s%f%s%f%s%s%s%s%s%f%f%f%s%s','Delimiter',',','TreatAsEmpty','');
adult = table(adult{:},'VariableNames',VarNames);

X = classreg.regr.modelutils.predictormatrix(adult,'ResponseVar',...
    size(adult,2));
Y = nominal(adult.income);

%tc = fitctree(X,Y,'CategoricalPredictors',[2,4,6,7,8,9,10,14])
rng(1); % For reproducibility
BaggedEnsemble = TreeBagger(200,X,Y,'OOBPred','On','CategoricalPredictors',[2,4,6,7,8,9,10,14])
oobErrorBaggedEnsemble = oobError(BaggedEnsemble);
plot(oobErrorBaggedEnsemble);
xlabel 'Number of grown trees';
ylabel 'Out-of-bag classification error';

test = urlread(['http://archive.ics.uci.edu/ml/machine-learning-databases/adult/adult.test']);

VarNames = {'age' 'workclass' 'fnlwgt' 'education' 'educationNum'...
    'maritalStatus' 'occupation' 'relationship' 'race'...
    'sex' 'capitalGain' 'capitalLoss'...
    'hoursPerWeek' 'nativeCountry' 'income'};
test = strrep(test,'?','');
test = strrep(test,'.','');
test = strrep(test,'|1x3 Cross validator','');
test = textscan(test,'%f%s%f%s%f%s%s%s%s%s%f%f%f%s%s','Delimiter',',','TreatAsEmpty','');
test = table(test{:},'VariableNames',VarNames);

testX = classreg.regr.modelutils.predictormatrix(test,'ResponseVar',...
    size(adult,2));
testY = nominal(test.income);
expectY = predict(BaggedEnsemble,testX);
error = testY == expectY;
test_error = 1-sum(error)/size(testY,1);