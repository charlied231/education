function [yf] = eulerE(df,f0,n,a,b)
%Metodo para resolver la edo f, con a y b como los intervalos, n como el
%numero de saltos y f0 como la condición inicial.
x = linspace(a,b,n);
y = linspace(0,0,n);
h = (b-a)/(n-1);
y(1) = f0;
    for i = 1:n
        y(i+1)  = y(i) + h*df(x(i));
    end
yf = y(n);
end