function b = train_model( X, train, Labels );
Xtest = importdata('zip.test');
Xtrain = importdata('zip.train');
% Xtest = importdata('features.test');
% Xtrain = importdata('features.train');
data = Xtrain;
test = Xtest;
Y = data(:,1);
Ytest = test(:,1);
data(:,1)=[];
test(:,1)=[];
for i=1:size(Y)
    if Y(i,1) ~= 1
        Y(i,1) = 0;
    end
end
for i=1:size(Ytest)
 if Ytest(i,1) ~= 1
        Ytest(i,1) = 0;
 end
end    
b = glmfit(data,Y,'binomial'); % Logistic regression
[m,n]=size(data);
data=[ones(m,1),data];
size(data)
for n = 1:size(data)
    Yin(n,1) = sign(data(n,:)*b);
    if Yin(n,1) == -1
        Yin(n,1) = 0;
    end
end
[m,n]=size(test);
test=[ones(m,1),test];
for n = 1:size(test)
    Yout(n,1) = sign(test(n,:)*b);
    if Yout(n,1) == -1
        Yout(n,1) = 0;
    end
end
pin = 0;
for n=1:size(data)
    if Yin(n,1) == Y(n,1)
        pin=pin+1;
    end
end

pout = 0;
for n=1:size(test)
    if Yout(n,1) == Ytest(n,1)
        pout=pout+1;
    end
end

Pincr= pin/size(Y,1);
Pinerr = 1-Pincr;

Poutcr= pout/size(Ytest,1);
Pouterr = 1-Poutcr;

 Ein = 0.0;
  for n=1:size(data,1);
        if Yin(n,1) == 0
            Yin(n,1) = -1;
        end
        Ein = Ein + log(1+exp(-Yin(n,1)*data(n,:)*b));
  end
  e_in = Ein/size(data,1);
  
  Eout = 0.0;
  for n=1:size(test,1);
      if Yout(n,1) == 0
        Yout(n,1) = -1;
      end
        Eout = Eout + log(1+exp(-Yout(n,1)*test(n,:)*b));
  end
  e_out = Eout/size(test,1);
end