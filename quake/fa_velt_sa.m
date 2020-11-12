function ft = fa_velt_sa(rho, Vs, D, H)
% FT_VELT_SA: Calcula factor de amplificacion caso viscoelastico entre la
% superficie (s) y el afloramiento rocoso (a). H_S,RS = 1/M.
%
% Parametros:
%   rho     Vector densidad de cada capa, (n)
%   Vs      Vector velocidad onda de corte cada capa, (n)
%   D       Vector de razon de amortiguamiento (1/4pi), (n)
%   H       Vector de altura cada capa, sin considerar semiespacio (n-1)

%% Obtiene el numero de capas y verifica compatibilidad de datos
n = length(rho);
if length(Vs) ~= n || length(D) ~= n
    error('Vectores rho,Vs,D deben tener igual dimension (numero de capas)');
end
if length(H) ~= (n - 1)
    error('Vector H de altura de capas no debe considerar semiespacio');
end

%% Retorna funcion de omega
ft = @(w) fa_velt_sb_w(rho, Vs, D, H, 1, n, 2*pi*w);

end

function a = fa_velt_sb_w(rho, Vs, D, H, E1, n, w)
% Calcula el factor de amplificacion con omega variable.

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
a = abs(E1) / abs(E(n));

end