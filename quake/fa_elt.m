function fa = fa_elt(Vs, H)
% FA_ELT: Retorna la funcion del factor de amplificacion en funcion de omega
% para el caso elastico de una sola capa.
%
%   fa := fa_elt(Vs, H)
%   fa(w)
%
% Parametros:
%   Vs      Velocidad onda de corte
%   H       Altura del estrato de suelo

fa = @(w) 1 / cos(w*H/Vs);

end