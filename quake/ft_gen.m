function [w, ft] = ft_gen(ew_s, ns_s, ew_r, ns_r, filtro)
% FT_GEN: Genera la curva de funcion de transferencia para dos registros,
% en superficie y roca.

%% Genera la FFT para el suelo
data_ew = load(ew_s);
data_ew(1, :) = []; % Elimina la primera linea

data_ns = load(ns_s);
data_ns(1, :) = []; % Elimina la primera linea

% Se guarda en columnas separadas tiempo y registro
ns_acc = data_ns(:, 2);
ew_acc = data_ew(:, 2);

ns_t = data_ns(:, 1);

% Calcula frecuencia y dt
dt = ns_t(2) - ns_t(1);
f = 1 / dt;

% Correccion por linea base
ns_acc = detrend(ns_acc, 0);
ew_acc = detrend(ew_acc, 0);

% Crea base para FFT
t_len = floor(length(ns_t));
t_len_h = floor(t_len/2);

% Tuckey (5%)
tuckey = tukeywin(t_len, 0.05);

% Arreglo frecuencias
freq_arr = 0:f / t_len:f - 1 / t_len;
w_suelo = freq_arr(1:t_len_h);

% Calcula Nakamura, se utiliza todo el espectro, no hay ventanas

% Tuckey window
ns_itr = ns_acc .* tuckey;
ew_itr = ew_acc .* tuckey;

% FFT
ns_fft_itr = fft(ns_itr);
ew_fft_itr = fft(ew_itr);

% Selecciona mitad de los datos
fft_ns = ns_fft_itr(1:t_len_h);
fft_ew = ew_fft_itr(1:t_len_h);

% FFT para suelo
fft_ns_suelo = medfilt1(abs(fft_ns), filtro);
fft_ew_suelo = medfilt1(abs(fft_ew), filtro);

%% Genera la FFT para la roca
data_ew = load(ew_r);
data_ew(1, :) = []; % Elimina la primera linea

data_ns = load(ns_r);
data_ns(1, :) = []; % Elimina la primera linea

% Se guarda en columnas separadas tiempo y registro
ns_acc = data_ns(:, 2);
ew_acc = data_ew(:, 2);

ns_t = data_ns(:, 1);

% Correccion por linea base
ns_acc = detrend(ns_acc, 0);
ew_acc = detrend(ew_acc, 0);

% Crea base para FFT
t_len = floor(length(ns_t));
t_len_h = floor(t_len/2);

% Tuckey (5%)
tuckey = tukeywin(t_len, 0.05);

% Arreglo frecuencias
freq_arr = 0:f / t_len:f - 1 / t_len;
w_roca = freq_arr(1:t_len_h);

% Calcula Nakamura, se utiliza todo el espectro, no hay ventanas

% Tuckey window
ns_itr = ns_acc .* tuckey;
ew_itr = ew_acc .* tuckey;

% FFT
ns_fft_itr = fft(ns_itr);
ew_fft_itr = fft(ew_itr);

% Selecciona mitad de los datos
fft_ns = ns_fft_itr(1:t_len_h);
fft_ew = ew_fft_itr(1:t_len_h);

% FFT para suelo
fft_ns_roca = medfilt1(abs(fft_ns), filtro);
fft_ew_roca = medfilt1(abs(fft_ew), filtro);

%% Genera el promedio para ambos fft
fft_h_suelo = zeros(1, length(w_suelo));
fft_h_roca = zeros(1, length(w_roca));

for i = 1:length(w_suelo)
    fft_h_suelo(i) = sqrt(fft_ns_suelo(i)^2+fft_ew_suelo(i)^2);
end
for i = 1:length(w_roca)
    fft_h_roca(i) = sqrt(fft_ns_roca(i)^2+fft_ew_roca(i)^2);
end

%% Interpola y normaliza para una misma frecuencia
wmin = max(min(w_suelo), min(w_roca));
wmax = min(max(w_suelo), max(w_roca));
wminl = min(length(w_suelo), length(w_roca));

% Genera vector w comun
w = linspace(wmin, wmax, wminl);

fft_h_suelo = interp1(w_suelo(:), fft_h_suelo(:), w(:), 'linear', 'extrap');
fft_h_roca = interp1(w_roca(:), fft_h_roca(:), w(:), 'linear', 'extrap');

%% Calcula la FT
ft = zeros(1, wminl);
for i = 1:wminl
    ft(i) = fft_h_suelo(i) / fft_h_roca(i);
end

plot(w, ft);
hold on;
grid on;

end