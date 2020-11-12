function vs = calc_vs(rho, G)
% CALC_VS: Calcula la velocidad de corte en funcion del modulo de cizalle y
% la densidad.
%
%   vs := calc_vs(rho, G)
%
% Parametros:
%   rho     Densidad
%   G       Modulo de cizalle

if length(rho) ~= length(G)
    error('Vectores rho y G deben tener igual dimension (numero de capas)');
end
vs = sqrt(G ./ rho);

end