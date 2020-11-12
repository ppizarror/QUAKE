%% TEST_4ESTRATOS
% 4 capas sobre semiespacio (roca), fuerte contraste de impedancias

%% Testeo multicapa 4 capas y semiespacio (roca)
Vs = [100, 700, 750, 900, 1500]; % Velocidad onda de corte (m/s)
rho = [15, 17, 17, 20, 27]; % Densidad kN/m3
D = [0.01, 0.03, 0.02, 0.01, 0.005]; % Amortiguamiento (%)
H = [10, 5, 15, 10]; % Altura de cada estrato (m)

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
clear rho Vs D H E1 T dh dt ft_sb ft_sa ft_ab;