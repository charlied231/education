function [yf] = rk4(f,f0,n,a,b)
%Metodo para resolver la edo f, con a y b como los intervalos, n como el
%numero de saltos y f0 como la condición inicial.
x = linspace(a,b,n);
y = linspace(0,0,n);
h = (b-a)/(n-1);
y(1) = f0;
    for i = 1:n
        k1 = f(x(i),y(i));
        k2 = f((x(i)+(.5*h)),y(i)+0.5*h*k1);
        k3 = f((x(i)+(.5*h)),(y(i)+0.5*h*k2));
        k4 = f((x(i)+ h),(y(i)+k3*h));
        y(i+1)  = y(i) + (h/6)*(k1 + 2*k2 + 2*k3 + k4);
    end
yf = y(n);
end