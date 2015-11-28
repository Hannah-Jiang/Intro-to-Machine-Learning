function [ test_error ] = find_test_error( w, X, y )
%FIND_TEST_ERROR Find the test error of a linear separator
%   This function takes as inputs the weight vector representing a linear
%   separator (w), the test examples in matrix form with each row
%   representing an example (X), and the labels for the test data as a
%   column vector (y). The labels are assumed to be plus or minus one. The
%   function returns the error on the test examples as a fraction. The
%   hypothesis is assumed to be of the form (sign ( [1 x(n,:)] * w )
% Xin = importdata('cleveland-train.csv');
 Xout = importdata('cleveland-test.csv');
 Xout = Xout.data;
% Nin = size(Xin.data,1);
% Yin = Xin.data(:,14);
%Xout = X;
Nout = size(Xout,1);
Yout = Xout(:,14);
% Yout = y;
% for n=1:size(Yin)
%     if Yin(n,1) == 0
%         Yin(n,1) = -1;
%     end
% end
for n=1:size(Yout)
    if Yout(n,1) == 0
        Yout(n,1) = -1;
    end
end
% Xin.data(:,14)=[];
 Xout(:,14)=[];
% [min,nin]=size(Xin.data);
% Xin.data=[ones(min,1),Xin.data];

[mout,nout]=size(Xout);
Xout=[ones(mout,1),Xout];

w = [-6.7206   -0.0190    0.9163    0.5694    0.0255    0.0021   -0.9602    0.3231   -0.0132    0.6898    0.1226    0.4536    1.0486    0.2655];
size(w)
size(Xout)
% for n = 1:Nin
%     YTin(n,1) = sign(Xin.data(n,:)*w');
% end
for n = 1:Nout
    YTout(n,1) = sign(Xout(n,:)*w');
end
pin=0;
% for n=1:size(Yin)
%     if Yin(n,1) == YTin(n,1)
%         pin=pin+1;
%     end
% end
pout=0;
for n=1:size(Yout)
    if Yout(n,1) == YTout(n,1)
        pout=pout+1;
    end
end
% Pincr= pin/size(Yin,1);
% Pinerr = 1-Pincr;

Poutcr= pout/size(Yout,1);
test_error = 1-Poutcr

end

