function u = u_elt(Vs, H, ab, T)
% U_ELT Retorna una funcion que permite obtener el desplazamiento t en una profundidad zj de un medio elastico de una sola capa.
%
%   u = u_elt(Vs, H, ab, T)
%   u(z,t) => u
%
% Parametros:
%   Vs      Velocidad onda de corte
%   H       Altura del estrato de suelo
%   ab      Amplitud basal
%   T       Periodo de la onda de corte

%% Verifica valores de input
if Vs <= 0
    error('La velocidad de onda de corte debe ser positiva');
end
if H <= 0
    error('La altura del estrato de suelo debe ser mayor a cero');
end
if ab <= 0
    error('La amplitud basal debe ser mayor a cero');
end
if T <= 0
    error('El periodo de la onda debe ser mayor a cero')
end

%% Calcula la frecuencia
w = 2 * pi / T;
cosval = cos(w*H/Vs);
if cosval == 0
    error('El periodo de la onda genera resonancia');
elseif abs(cosval) < 1e-15
    warning('El periodo de la onda está cerca de la resonancia, posible inestabilidad numérica');
end

%% Retorna la funcion de desplazamiento
u = @(z, t) (ab / cosval) * exp(1i*w*t) * cos(w*z/Vs);

end