function [w, ftw] = plot_ft(ft, wmin, wmax, varargin)
% PLOT_FT: Grafica la funcion de transferencia.
%
%   ft = ft_velt_sa(...) / ft_velt_sb(...) / ft_elt(...)
%   plot = plot_ft(ft, wmin, wmax, 'Plot title', varargin);
%
% Parametros:
%   ft              Funcion de transferencia en omega, ft(w)
%   wmin            Frecuencia minima de evaluacion, eje x
%   wmax            Frecuencia maxima de evaluacion, eje x
%
% Parametros opcionales:
%   grid            Muestra una grilla
%   legend_loc      Ubicacion de la leyenda
%   logx            Plot en semilogx
%   NPOINTS         Numero de puntos de evaluacion, por defecto es 100
%   plot_colorw     Color del grafico FT(w)
%   show_legend     Muestra la leyenda
%   title           Titulo del grafico
%   use_freq        Usa frecuencias en el eje x
%   xlabel          Label en x, si es vacio entonces usa xlabel_w/f
%   xlabel_f        Label en x (frecuencia)
%   xlabel_w        Label en x (omega)
%   ylabel          Label en y, si es vacio entonces usa ylabel_w/f
%   ylabel_f        Label de la leyenda en y (frecuencia)
%   ylabel_w        Label de la leyenda en y (omega)
%
% MIT License
% Copyright (c) 2019-2020 Pablo Pizarro R.
%
% Permission is hereby granted, free of charge, to any person obtaining a copy
% of this software and associated documentation files (the "Software"), to deal
% in the Software without restriction, including without limitation the rights
% to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
% copies of the Software, and to permit persons to whom the Software is
% furnished to do so, subject to the following conditions:
%
% The above copyright notice and this permission notice shall be included in all
% copies or substantial portions of the Software.
%
% THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
% IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
% FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
% AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
% LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
% OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
% SOFTWARE.

%% Inicia variables
if nargin < 4
    error('Numero de parametros incorrectos');
end

p = inputParser;
p.KeepUnmatched = true;
p.addOptional('grid', true);
p.addOptional('legend_loc', 'northwest');
p.addOptional('logx', false);
p.addOptional('NPOINTS', 1000);
p.addOptional('plot_colorw', 'k');
p.addOptional('show_legend', false);
p.addOptional('title', 'Funcion de Transferencia');
p.addOptional('use_freq', false);
p.addOptional('xlabel_f', '$f$ (Hz)');
p.addOptional('xlabel_w', '$\omega$ (rad/s)');
p.addOptional('xlabel', '');
p.addOptional('ylabel_f', 'FT($f$)');
p.addOptional('ylabel_w', 'FT($\omega$)');
p.addOptional('ylabel', '');
parse(p, varargin{:});
r = p.Results;

%% Genera el grafico
plt = figure();

% Modifica la figura
movegui(plt, 'center');
set(gcf, 'name', r.title);

%% Crea las variables
if wmax <= wmin
    error('wmin debe ser menor que wmax');
end
w = linspace(wmin, wmax, r.NPOINTS);
ftw = zeros(r.NPOINTS, 1);
for i = 1:r.NPOINTS
    if ~r.use_freq
        ftw(i) = ft(w(i));
    else
        ftw(i) = ft(w(i) * 2 * pi);
    end
end

%% Grafica
if ~r.logx
    plot(w, abs(ftw), r.plot_colorw);
else
    semilogx(w, abs(ftw), r.plot_colorw);
end
hold on;
if r.grid
    grid on;
end

% Obtiene el label
x_label = r.xlabel;
if strcmp(x_label, '')
    if ~r.use_freq
        x_label = r.xlabel_w;
    else
        x_label = r.xlabel_f;
    end
end
y_label = r.ylabel;
if strcmp(y_label, '')
    if ~r.use_freq
        y_label = r.ylabel_w;
    else
        y_label = r.ylabel_f;
    end
end

title(r.title, 'interpreter', 'latex');
xlabel(x_label, 'interpreter', 'latex');
ylabel(y_label, 'interpreter', 'latex');
if r.show_legend
    legend({y_label}, 'Location', r.legend_loc)
end
hold off;

end