%% TEST_3ESTRATOS
% 3 capas sobre semiespacio (roca flexible)

%% Testeo multicapa 3 capas y semiespacio (roca)
tipo_suelo = 1;

if tipo_suelo == 1
    G = [210000, 1750000, 4300000, 23000000]; % Modulo de rigidez (kN/ms2)
    rho = [16, 20, 23, 26.5]; % Densidad kN/m3
    D = [0.02, 0.02, 0.01, 0]; % Amortiguamiento (%)
    H = [9, 18, 26]; % Altura de cada estrato (m)
elseif tipo_suelo == 2
    G = [1750000, 210000, 4300000, 23000000]; % Modulo de rigidez (kN/ms2)
    rho = [20, 16, 23, 26.5]; % Densidad kN/m3
    D = [0.02, 0.02, 0.01, 0]; % Amortiguamiento (%)
    H = [18, 9, 26]; % Altura de cada estrato (m)
else
    error('Suelo desconocido');
end

% Calcula la velocidad
Vs = calc_vs(rho, G);

%% Genera las funciones de transferencia
ft_sb = ft_velt_sb(rho, Vs, D, H); % FT superficie/roca-basal
ft_sa = ft_velt_sa(rho, Vs, D, H); % FT superficie/afloramiento
ft_ab = ft_velt_ab(rho, Vs, D, H); % FT afloramiento/roca-basal

%% Grafica los factores
plot_ft(ft_sb, 0, 30, 'title', 'Funcion Transferencia | Superficie / Roca Basal', ...
    'use_freq', true, 'ylabel', '$FT_{sb}(\omega = 2 \pi f)$');
plot_ft(ft_sa, 0, 30, 'title', 'Funcion Transferencia | Superficie / Afloramiento Rocoso', ...
    'use_freq', true, 'ylabel', '$FT_{sa}(\omega = 2 \pi f)$');
plot_ft(ft_ab, 0, 30, 'title', 'Funcion Transferencia | Afloramiento Rocoso / Roca Basal', ...
    'use_freq', true, 'ylabel', '$FT_{ab}(\omega = 2 \pi f)$');

%% Genera el grafico
T = 0.3; % Periodo de la onda
dh = 0.2; % Discretizacion en la altura
dt = 0.002; % Discretizacion en el tiempo
quake_velt(rho, Vs, D, H, 1, T, dh, dt);

%% Borra las variables
clear rho Vs D H E1 T dh dt ft_sb ft_sa ft_ab G tipo_suelo ans;