%% TEST_1ESTRATO_SEMIESPACIO
% Estrato sobre semiespacio (roca)

%% Testeo quake sistema elastico
T = 1.8; % (s)
H = 20; % (m)
Vs = 150; % (m/s)
ab = 10; % Amplitud basal (m)

%% Genera u(z,t)
u = u_elt(Vs, H, ab, T);
ft = ft_elt(Vs, H);
fprintf('Frecuencia: %.4f\n', 2*pi/T);
fprintf('u(0,0): %.4f\n', u(0, 0));
fprintf('u(H,0): %.4f\n', u(H, 0));
fprintf('u(H/2,5): %.4f\n', u(H/2, 5));
fprintf('FT: %f\n', ft(2*pi/T));

% Calcula omega resonante
fprintf('Periodo resonante: %f\n', 4*H/Vs);

dh = 0.2;
dt = 0.005;

%% Crea el grafico de la funcion de transferencia
plot_ft(ft, 0, 45, 'title', 'Funcion de Transferencia');

%% Genera el grafico
quake_elt(Vs, H, ab, T, dh, dt);

%% Borra las variables
clear T H Vs ab dh dt ft ans u;