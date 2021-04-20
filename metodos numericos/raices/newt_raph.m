function [R] = newt_raph(f,a_nr,tolerancia)
%Metodo para encontrar raices de una función
syms x
x0 = a_nr;
f_prima = diff(f);
if (subs(f,x,x0) ~= 0) && (subs(f_prima,x,x0) ~= 0)
    x1 = x0;
    x0 = x0 - ((subs(f,x,x0)/subs(f_prima,x,x0)));
    while abs(x0 - x1) > tolerancia
        x1 = x0;
        x0 = x0 - ((subs(f,x,x0)/subs(f_prima,x,x0)));
    end
end
R = x0;
end