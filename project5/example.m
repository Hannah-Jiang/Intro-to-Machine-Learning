adult = urlread(['http://archive.ics.uci.edu/ml/'...
    'machine-learning-databases/adult/adult.data']);
VarNames = {'age' 'workclass' 'fnlwgt' 'education' 'educationNum'...
    'maritalStatus' 'occupation' 'relationship' 'race'...
    'sex' 'capitalGain' 'capitalLoss'...
    'hoursPerWeek' 'nativeCountry' 'income'};
adult = strrep(adult,'?','');
adult = textscan(adult,'%f%s%f%s%f%s%s%s%s%s%f%f%f%s%s',...
    'Delimiter',',','TreatAsEmpty','');
adult = table(adult{:},'VariableNames',VarNames);
cat = varfun(@iscellstr,adult(:,1:end - 1),...
    'OutputFormat','uniform'); % Logical flag for categorical variables
catVars = find(cat);           % Indices of categorical variables

countCats = @(var)numel(categories(nominal(var)));
numCat = varfun(@(var)countCats(var),adult(:,catVars),...
    'OutputFormat','uniform');

figure;
barh(numCat);
set(gca,'YTickLabel',VarNames(catVars))
ylabel('Predictor');
xlabel('Number of categories');

X = classreg.regr.modelutils.predictormatrix(adult,'ResponseVar',...
    size(adult,2));
Y = nominal(adult.income);

rng(1); % For reproducibility
LBEnsemble = fitensemble(X,Y,'LogitBoost',300,'Tree',...
    'CategoricalPredictors',cat,'PredictorNames',VarNames(1:end-1),...
    'ResponseName','income');
GBEnsemble = fitensemble(X,Y,'GentleBoost',300,'Tree',...
    'CategoricalPredictors',cat,'PredictorNames',VarNames(1:end-1),...
    'ResponseName','income');

figure;
plot(resubLoss(LBEnsemble,'Mode','cumulative'));
hold on
plot(resubLoss(GBEnsemble,'Mode','cumulative'),'r--');
hold off
xlabel('Number of trees');
ylabel('Resubstitution error');
legend('LogitBoost','GentleBoost','Location','NE');
