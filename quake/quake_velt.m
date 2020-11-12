function quake_velt(rho, Vs, D, H, E1, T, dh, dt, plot_normalize, plot_pause, plot_cp, plot_maxp, mult_umax, disp_legend, show_max)
% QUAKE_VELT: Genera un grafico de u(z,t) en funcion del tiempo, sistema
% multicapas viscoelastico.
%
% Parametros:
%   rho             Vector densidad de cada capa, (n)
%   Vs              Vector velocidad onda de corte cada capa, (n)
%   D               Vector de razon de amortiguamiento, (n)
%   H               Vector de altura cada capa, sin considerar semiespacio (n-1)
%   E1              Primer valor de Ej, Fj
%   T               Periodo de la onda
%   dh              Delta paso en profundidad
%   dt              Delta paso en tiempo
%   plot_normalize  Normaliza los resultados por u0 (despl. basal)
%   plot_pause      Tiempo de pausa
%   plot_cp         Muestra las capas
%   plot_maxp       Muestra los puntos maximos
%   mult_umax       Factor en que crece umax
%   disp_legend     Muestra la leyenda
%   show_max        Muestra el maximo de u(z,t) por cada z

%% Inicia variables
if ~exist('plot_normalize', 'var')
    plot_normalize = true;
end
if ~exist('plot_pause', 'var')
    plot_pause = 1 / 30; % Default a 30FPS
end
if ~exist('plot_cp', 'var')
    plot_cp = true;
end
if ~exist('plot_maxp', 'var')
    plot_maxp = true;
end
if ~exist('mult_umax', 'var')
    mult_umax = 1.2;
end
if ~exist('disp_legend', 'var')
    disp_legend = false;
end
if ~exist('show_max', 'var')
    show_max = true;
end

%% Crea la funcion u(z,t)
u = u_velt(rho, Vs, D, H, E1, T);

%% Crea puntos de evaluacion
z = 0:dh:sum(H);
t = 0:dt:(10000 * T);

%% Calcula los maximos desplazamientos
umax = 0; % Desplazamiento maximo en toda la onda
u0 = 0; % Desplazamiento maximo en base
us = 0; % Deslazamiento maximo en superficie
mt = 0:dt:T;
uzmax = zeros(length(z), 1);
for i = 1:length(mt)
    for j = 1:length(z)
        uzj = u(z(j), mt(i));
        uzmax(j) = max(uzmax(j), abs(uzj));
        umax = max(umax, abs(uzj));
    end
    us = max(us, max(abs(u(z(1), mt(i)))));
    u0 = max(u0, max(abs(u(z(end), mt(i)))));
end
ft = us / u0;
z0 = max(z);
if plot_normalize % Normaliza por u0
    us = us / u0;
    umax = umax / u0;
end

%% Genera las capas para graficar
ncp = length(H) + 1;
Hcp = zeros(ncp, 1);
for i = 2:ncp
    Hcp(i) = Hcp(i-1) + H(i-1);
end
if plot_normalize
    for i = 1:ncp
        Hcp(i) = Hcp(i) / z0;
    end
end

%% Genera el grafico
plt = figure();

% Modifica la figura
movegui(plt, 'center');
set(gcf, 'name', 'Quake');
set(axes, 'YAxisLocation', 'Right');

% Propiedades del grafico dependiendo si se normaliza o no
zz = 1; % Pondera a h
uu = u0; % Pondera a uu
plot_xlabel = 'u/u0';
plot_ylabel = 'z/h';

if ~plot_normalize
    u0 = 1;
    uu = 1;
    zz = z0;
    plot_xlabel = 'u';
    plot_ylabel = 'z';
end

umax = mult_umax * umax; % Pondera el factor umax

%% Escribe u(z,t) grafico para cada t
u_ = zeros(length(z), 1);

for i = 1:length(t)
    
    % Si el usuario cierra el plot termina de graficar
    if ~ishandle(plt)
        return;
    end
    
    % Se asegura de tener el foco en la figura
    figure(plt);
    
    % Calcula el desplazamiento
    for j = 1:length(z)
        u_(j) = u(z(j), t(i));
    end
    
    % Grafica el desplazamiento
    plot(real(u_)./u0, z./z0, 'b');
    hold on;
    plot(imag(u_)./u0, z./z0, 'r');
    grid on;
    
    % Grafica el maximo desplazamiento
    if show_max
        plot(uzmax./u0, z./z0, 'k:');
        plot(-uzmax./u0, z./z0, 'k:');
    end
    
    % Grafica las capas
    if plot_cp
        for j = 1:ncp
            line([-umax, umax], [Hcp(j), Hcp(j)], 'Color', 'black');
        end
    end
    
    % Grafica los puntos maximos
    if plot_maxp
        plot(us, 0, '*k', 'MarkerFaceColor', 'black'); % Superficie
        plot(-us, 0, '*k', 'MarkerFaceColor', 'black');
        plot(u0/uu, zz, '*k', 'MarkerFaceColor', 'black'); % Basamiento
        plot(-u0/uu, zz, '*k', 'MarkerFaceColor', 'black');
    end
    
    % Invierte el grafico
    set(gca, 'Ydir', 'reverse');
    xlim([-umax, umax]);
    ylim([0, zz]);
    xlabel(plot_xlabel, 'interpreter', 'latex');
    ylabel(plot_ylabel, 'interpreter', 'latex');
    title(sprintf('Quake Visco-Elastico | Re(u):azul, Im(u):rojo | FT: %.3f', ft), 'interpreter', 'latex');
    if disp_legend
        legend({'Re(u(z,t))', 'Im(u(z,t))'}, 'Location', 'southwest');
    end
    
    % Pausa
    pause(plot_pause);
    hold off;
    
end

end