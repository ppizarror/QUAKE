%% TEST_5ESTRATOS
% 5 capas sobre semiespacio (roca), todas las capas son idénticas

%% Testeo multicapa 5 capas y semiespacio (roca)
Vs = [250, 250, 250, 250, 250, 1500]; % Velocidad onda de corte (m/s)
rho = [18, 18, 18, 18, 18, 25]; % Densidad kN/m3
D = [0.02, 0.02, 0.02, 0.02 0.02, 0.03]; % Amortiguamiento (%)
H = [10, 10, 10, 10, 10]; % Altura de cada estrato (m)
E1 = 1;
T = 0.3;

dh = 0.2;
dt = 0.002;

%% Genera el grafico
quake_velt(rho, Vs, D, H, E1, T, dh, dt);

%% Borra las variables
clear rho Vs D H E1 T dh dt;