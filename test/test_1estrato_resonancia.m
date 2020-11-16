%% TEST_1ESTRATO_RESONANCIA
% Estrato sobre semiespacio (roca), caso cercano a resonancia

%% Testeo quake sistema elastico
H = 20; % (m)
Vs = 150; % (m/s)
ab = 10; % Amplitud basal (m)

% Calcula omega resonante
T = 4 * H / Vs;
fprintf('Periodo resonante: %f\n', T);

%% Crea el grafico de la funcion de transferencia
ft = ft_elt(Vs, H);
plot_ft(ft, 0, 50, 'title', 'Funcion de Transferencia');

%% Genera el grafico (en resonancia) quake
dh = 0.2;
dt = 0.01;
quake_elt(Vs, H, ab, T, dh, dt);

%% Borra las variables
clear T H Vs ab dh dt ft ans;