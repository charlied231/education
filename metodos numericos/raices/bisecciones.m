function [R] = bisecciones(f,a,c,tolerancia)
%Metodo para encontrar raices de una función
x1 = a;
x2 = c;
while abs(x1 - x2) > 2*tolerancia
    x3 = (x1 + x2)/2;
    
    if (f(x1)*f(x3)) < 0
        x2 = x3;
    else
        x1 = x3;
    end
end
R = x3;
end
