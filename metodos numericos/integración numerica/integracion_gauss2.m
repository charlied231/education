% Regla de integración con cuadratura de gauss (n = 2)
function [R,er] = integracion_gauss2(f,Ie)
    R = f(-0.57735) + f(0.57735);
    er = (Ie-R)/Ie;
end
