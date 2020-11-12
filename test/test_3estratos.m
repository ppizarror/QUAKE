%% TEST_3ESTRATOS
% 3 capas sobre semiespacio (roca flexible)

%% Testeo multicapa 4 capas y semiespacio (roca)
G = [210000, 1750000, 4300000, 23000000]; % Modulo de rigidez (kN/ms2)
rho = [16, 20, 23, 26.5]; % Densidad kN/m3
D = [0.02, 0.02, 0.01, 0]; % Amortiguamiento (%)
H = [9, 18, 26]; % Altura de cada estrato (m)

% Calcula la velocidad
Vs = calc_vs(rho, G);

%% Genera las funciones de transferencia
ft_sb = fa_velt_sb(rho, Vs, D, H); % FT superficie/roca-basal
ft_sa = fa_velt_sa(rho, Vs, D, H); % FT superficie/afloramiento
ft_ab = fa_velt_ab(rho, Vs, D, H); % FT afloramiento/roca-basal

%% Grafica los factores
plot_fa(ft_sb, 0, 30, 'Funcion Transferencia Superficie / Roca Basal', 'FTsb', false);
plot_fa(ft_sa, 0, 30, 'Funcion Transferencia Superficie / Afloramiento Rocoso', 'FTsa', false);
plot_fa(ft_ab, 0, 30, 'Funcion Transferencia Afloramiento Rocoso / Roca Basal', 'FTab', false);

%% Genera el grafico
T = 0.3; % Periodo de la onda
dh = 0.2; % Discretizacion en la altura
dt = 0.002; % Discretizacion en el tiempo
quake_velt(rho, Vs, D, H, 1, T, dh, dt);

%% Borra las variables
clear rho Vs D H E1 T dh dt ft_sb ft_sa ft_ab G;