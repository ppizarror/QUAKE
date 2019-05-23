%% TEST_1ESTRATO_SEMIESPACIO
% Estrato sobre semiespacio (roca)

%% Testeo quake sistema elastico
T = 1.8; % (s)
H = 20; % (m)
Vs = 150; % (m/s)
ab = 10; % Amplitud basal (m)

%% Genera u(z,t)
u = u_elt(Vs, H, ab, T);
fa = fa_elt(Vs, H);
fprintf('Frecuencia: %.4f\n', 2*pi/T);
fprintf('u(0,0): %.4f\n', u(0, 0));
fprintf('u(H,0): %.4f\n', u(H, 0));
fprintf('u(H/2,5): %.4f\n', u(H/2, 5));
fprintf('FT: %f\n', fa(2*pi/T));

% Calcula omega resonante
fprintf('Periodo resonante: %f\n', 4*H/Vs);

dh = 0.2;
dt = 0.005;

%% Crea el grafico del factor de amplificacion
plot_fa(fa, 0, 45, -25, 25, 'Factor Amplificacion');

%% Genera el grafico
quake_elt(Vs, H, ab, T, dh, dt);

%% Borra las variables
clear T H Vs ab dh dt;