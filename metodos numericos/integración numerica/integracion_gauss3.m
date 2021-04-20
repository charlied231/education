% Regla de integración con cuadratura de gauss (n = 3)
function [R,er] = integracion_gauss3(f,Ie)
    R = (0.55555)*f(-0.774596) + (0.55555)*f(0.774596) + (0.88888)*f(0);
    er = (Ie-R)/Ie;
end