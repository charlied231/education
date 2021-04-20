%Regla de integración por punto medio
function [R,er] = punto_medio(f,Ie)
    h = f(0);
    base = 2;
    R = base*h;
    er = (Ie-R)/Ie;
end
