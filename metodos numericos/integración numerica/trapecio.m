% Regla de integración del trapecio
function [R,er] = trapecio(f,Ie)
    h1 = f(-1);
    h2 = f(1);
    base = 2;
    R = ((h1 + h2) / 2)*base;
    er = (Ie-R)/Ie;
end