function b = train_model( X, train, Labels )
Xin = importdata('cleveland-train.csv');
Xout = importdata('cleveland-test.csv');

Yin = Xin.data(:,14);
Yout = Xout.data(:,14);

for n=1:size(Yin)
    if Yin(n,1) == -1
        Yin(n,1) = 0;
    end
end

Xin.data(:,14)=[];
Xout.data(:,14)=[];

b = glmfit(Xin.data,Yin,'binomial') % Logistic regression

[m,n]=size(Xin.data);
Xin.data=[ones(m,1),Xin.data];

[m,n]=size(Xout.data);
Xout.data=[ones(m,1),Xout.data];

 Ein = 0.0;
  for n=1:size(Xin.data,1);
      if Yin(n,1) == 0
            Yin(n,1) = -1;
      end
      Ein = Ein + log(1+exp(-Yin(n,1)*Xin.data(n,:)*b));
  end
  e_in = Ein/size(Xin.data,1)
  for n = 1:size(Xout.data)
    Ytout(n,1) = sign(Xout.data(n,:)*b);
    if Ytout(n,1) == -1
        Ytout(n,1) = 0;
    end
  end
  pout = 0;
  for n=1:size(Yout)
    if Yout(n,1) == Ytout(n,1)
        pout=pout+1;
    end
  end
  Poutcr= pout/size(Yout,1);
  test_error = 1-Poutcr;
end
