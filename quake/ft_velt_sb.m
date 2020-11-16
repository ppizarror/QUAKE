function ft = ft_velt_sb(rho, Vs, D, H)
% FT_VELT_SB: Calcula la funcion de transferencia caso viscoelastico entre
% la superficie (s) y el basamento rocoso (b), H_S,RB = 2/(M+N).
% Retorna una funcion FT(w).
%
% Parametros:
%   rho     Vector densidad de cada capa, (n)
%   Vs      Vector velocidad onda de corte cada capa, (n)
%   D       Vector de razon de amortiguamiento, (n)
%   H       Vector de altura cada capa, sin considerar semiespacio (n-1)
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

%% Obtiene el numero de capas y verifica compatibilidad de datos
n = length(rho);
if length(Vs) ~= n || length(D) ~= n
    error('Vectores rho,Vs,D deben tener igual dimension (numero de capas)');
end
if length(H) ~= (n - 1)
    error('Vector H de altura de capas no debe considerar semiespacio');
end

%% Retorna funcion de omega
ft = @(w) ft_velt_sb_w(rho, Vs, D, H, 1, n, w);

end

function a = ft_velt_sb_w(rho, Vs, D, H, E1, n, w)
% Calcula la funcion de transferencia con omega variable.

%% Calcula propiedades N capas (Kelvin-Voigt)
nVs = Vs .* sqrt(1+2*1i*D); % Velocidad onda de corte compleja (si D!=0)
nG = nVs .* nVs .* rho; %#ok<NASGU> % Modulo de corte complejo (si D!=0)
k = w ./ nVs; % Numero de onda complejo (si D!=0)

%% Calcula el vector de impedancias
imp = zeros(n-1, 1);
for i = 1:(n - 1)
    imp(i) = (rho(i) * nVs(i)) / (rho(i+1) * nVs(i+1));
end

%% Calcula los coeficientes E, F
E = zeros(n, 1);
F = zeros(n, 1);
E(1) = E1;
F(1) = E1; % Por condicion de superficie libre
for j = 1:(n - 1)
    E(j+1) = 0.5 * (E(j) * (1 + imp(j)) * exp(1i*k(j)*H(j)) + F(j) * (1 - imp(j)) * exp(-1i*k(j)*H(j)));
    F(j+1) = 0.5 * (E(j) * (1 - imp(j)) * exp(1i*k(j)*H(j)) + F(j) * (1 + imp(j)) * exp(-1i*k(j)*H(j)));
end

%% Retorna el resultado de la amplitud
a = 2 * abs(E1) / (abs(E(n)) + abs(F(n)));

end