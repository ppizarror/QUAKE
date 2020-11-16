%% TEST_5ESTRATOS
% 5 capas sobre semiespacio (roca), todas las capas son idénticas

%% Testeo multicapa 5 capas y semiespacio (roca)
Vs = [250, 250, 250, 250, 250, 1500]; % Velocidad onda de corte (m/s)
rho = [18, 18, 18, 18, 18, 25]; % Densidad kN/m3
D = [0.02, 0.02, 0.02, 0.02 0.02, 0.03]; % Amortiguamiento (%)
H = [10, 10, 10, 10, 10]; % Altura de cada estrato (m)

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

%% Genera el grafico quake
T = 0.3; % Periodo de la onda
dh = 0.2; % Discretizacion en la altura
dt = 0.002; % Discretizacion en el tiempo
quake_velt(rho, Vs, D, H, 1, T, dh, dt);

%% Borra las variables
clear rho Vs D H E1 T dh dt ft_sb ft_sa ft_ab ans;