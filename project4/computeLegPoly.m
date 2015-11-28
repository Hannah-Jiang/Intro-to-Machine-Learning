function [ z ] = computeLegPoly( x, Q )
%COMPUTELEGPOLY Return the Qth order Legendre polynomial of x
%   Inputs:
%       x: vector (or scalar) of reals in [-1, 1]
%       Q: order of the Legendre polynomial to compute
%   Output:
%       z: matrix where each column is the Legendre polynomials of order 0 
%          to Q, evaluated atthe corresponding x value in the input
for n=1:size(x(:,1))
    z(n,1) = 1;
    z(n,2) = x(n);
    k = 3;
    while k <= Q+1
        z(n,k) = (2*k-1)/k * x(n) * z(n,k-1) - (k-1)/k * z(n,k-2);
        k = k+1;
    end
end
end

