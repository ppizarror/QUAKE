%% TEST_9ESTRATOS
% 9 capas sobre semiespacio (roca), fuerte contraste de impedancias

% Genera las curvas FTsb (Funcion de transferencia superficie-roca basal) y
% FTsa (Roca-basal y Afloramiento rocoso)

%% Crea sistema de capas
Vs = [180, 200, 250, 200, 720, 250, 250, 720, 1800]; % Velocidad onda de corte (m/s)
rho = [18, 15, 20, 16, 21, 17, 17, 19, 25]; % Densidad kN/m3
D = [0.02, 0.02, 0.02, 0.02, 0.02, 0.02, 0.02, 0.02, 0.01]; % Amortiguamiento (%)
H = [6, 5, 2, 8, 5, 8, 11, 16]; % Altura de cada estrato (m)

%% Genera las funciones de transferencia
ft_sb = fa_velt_sb(rho, Vs, D, H); % FT superficie/roca-basal
ft_sa = fa_velt_sa(rho, Vs, D, H); % FT superficie/afloramiento
ft_ab = fa_velt_ab(rho, Vs, D, H); % FT afloramiento/roca-basal

%% Grafica los factores
plot_fa(ft_sb, 0, 30, 'Funcion Transferencia Superficie / Roca Basal', 'FTsb', false);
plot_fa(ft_sa, 0, 30, 'Funcion Transferencia Superficie / Afloramiento Rocoso', 'FTsa', false);
plot_fa(ft_ab, 0, 30, 'Funcion Transferencia Afloramiento Rocoso / Roca Basal', 'FTab', false);

%% Borra las variables
clear rho Vs D H E1 T dh dt ft_sb ft_sa ft_ab;