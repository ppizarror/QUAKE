function u = u_elt(Vs, H, ab, T)
% U_ELT: Retorna una funcion que permite obtener el desplazamiento t en una
% profundidad zj de un medio elastico de una sola capa.
%
%   u = u_elt(Vs, H, ab, T)
%   u(z,t) => u
%
% Parametros:
%   Vs      Velocidad onda de corte
%   H       Altura del estrato de suelo
%   ab      Amplitud basal
%   T       Periodo de la onda de corte (s)
%
% MIT License
% Copyright (c) 2019-2020 Pablo Pizarro R.
%
% Permission is hereby granted, free of charge, to any person obtaining a copy
% of this software and associated documentation files (the "Software"), to deal
% in the Software without restriction, including without limitation the rights
% to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
% copies of the Software, and to permit persons to whom the Software is
% furnished to do so, subject to the following conditions:
%
% The above copyright notice and this permission notice shall be included in all
% copies or substantial portions of the Software.
%
% THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
% IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
% FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
% AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
% LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
% OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
% SOFTWARE.

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
    warning('El periodo de la onda esta cerca de la resonancia, posible inestabilidad numerica');
end

%% Retorna la funcion de desplazamiento
u = @(z, t) (ab / cosval) * exp(1i*w*t) * cos(w*z/Vs);

end