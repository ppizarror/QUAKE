function [w, faw] = plot_fa(fa, wmin, wmax, plot_title, yaxis_label, logx, NPOINTS, plot_colorw, show_legend)
% PLOT_FA: Grafica la funcion del factor de amplificacion.
%
%   plot = plot_fa(fa, wmin, wmax, 'Plot title');
%   plot = plot_fa(fa, wmin, wmax, 'Plot title');
%   plot = plot_fa(fa, wmin, wmax, 'Plot title', false);
%   plot = plot_fa(fa, wmin, wmax, 'Plot title', true, 'FA');
%   plot = plot_fa(fa, wmin, wmax, 'Plot title', true, 'FA', 1000);
%   plot = plot_fa(fa, wmin, wmax, 'Plot title', true, 'FA', 100, 'k');
%   plot = plot_fa(fa, wmin, wmax, 'Plot title', true, 'FA', 100, 'k, false);
%
% Parametros:
%   fa              Funcion factor de amplificacion
%   wmin            Frecuencia minima de evaluacion, eje x
%   wmax            Frecuencia maxima de evaluacion, eje x
%   plot_title      Titulo del grafico
%   yaxis_label     Label de la leyenda en y
%   logx            Plot en semilogx
%   NPOINTS         Numero de puntos de evaluacion, por defecto es 100
%   plot_colorw     Color del grafico FA(w)
%   show_legend     Muestra la leyenda

%% Inicia variables
if ~exist('NPOINTS', 'var')
    NPOINTS = 1000;
end
if ~exist('plot_colorw', 'var')
    plot_colorw = 'k';
end
if ~exist('show_legend', 'var')
    show_legend = false;
end
if ~exist('yaxis_label', 'var')
    yaxis_label = 'FA($\omega$)';
end
if ~exist('logx', 'var')
    logx = false;
end

%% Genera el grafico
plt = figure();

% Modifica la figura
movegui(plt, 'center');
set(gcf, 'name', plot_title);

%% Crea las variables
if wmax <= wmin
    error('wmin debe ser menor que wmax');
end
w = linspace(wmin, wmax, NPOINTS);
faw = zeros(NPOINTS, 1);
for i = 1:NPOINTS
    faw(i) = fa(w(i));
end

%% Grafica
if ~logx
    plot(w, abs(faw), plot_colorw);
else
    semilogx(w, abs(faw), plot_colorw);
end
hold on;
grid on;
title(plot_title);
xlabel('$\omega$', 'interpreter', 'latex');
ylabel(yaxis_label, 'interpreter', 'latex');
if show_legend
    legend({yaxis_label}, 'Location', 'northwest')
end
hold off;

end