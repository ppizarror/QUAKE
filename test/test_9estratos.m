%% TEST_9ESTRATOS
% 9 capas sobre semiespacio (roca), fuerte contraste de impedancias

%% Crea sistema de capas
Vs = [180, 200, 250, 200, 720, 250, 250, 720, 1800]; % Velocidad onda de corte (m/s)
rho = [18, 15, 20, 16, 21, 17, 17, 19, 25]; % Densidad kN/m3
D = [0.02, 0.02, 0.02, 0.02, 0.02, 0.02, 0.02, 0.02, 0.01]; % Amortiguamiento (%)
H = [6, 5, 2, 8, 5, 8, 11, 16]; % Altura de cada estrato (m)

%% Genera las funciones de transferencia
ft_sb = ft_velt_sb(rho, Vs, D, H); % FT superficie/roca-basal
ft_sa = ft_velt_sa(rho, Vs, D, H); % FT superficie/afloramiento
ft_ab = ft_velt_ab(rho, Vs, D, H); % FT afloramiento/roca-basal

plot_ft(ft_sb, 0, 30, 'title', 'Funcion Transferencia | Superficie / Roca Basal', ...
    'use_freq', true, 'ylabel', '$FT_{sb}(\omega = 2 \pi f)$');
plot_ft(ft_sa, 0, 30, 'title', 'Funcion Transferencia | Superficie / Afloramiento Rocoso', ...
    'use_freq', true, 'ylabel', '$FT_{sa}(\omega = 2 \pi f)$');
plot_ft(ft_ab, 0, 30, 'title', 'Funcion Transferencia | Afloramiento Rocoso / Roca Basal', ...
    'use_freq', true, 'ylabel', '$FT_{ab}(\omega = 2 \pi f)$');

%% Borra las variables
clear rho Vs D H E1 T dh dt ft_sb ft_sa ft_ab ans;