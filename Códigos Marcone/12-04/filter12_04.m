clear all;
close all;
clc;

N = 10;
bi = 2*(rand(1, N)-0.5);

%% Tipo I - LP, HP, BS, BP
b = [bi (2*rand(1,1)-0.5) flip(bi)];
subplot(122)
zplane(b, 1)
subplot(121)
[h, w] = freqz(b, 1, 'whole')
% plot(w/pi, 20*log10(abs(h))); grid on;
% plot(w/pi, unwrap(angle(h))/pi); grid on;
grpdelay(b, 1)

%% Tipo II - LP, BP
% tem um zero em -1
b = [bi flip(bi)];
subplot(122)
zplane(b, 1)
subplot(121)
[h, w] = freqz(b, 10000, 'whole');
plot(w/pi, 20*log10(abs(h))); grid on;

%% Tipo III - BP
% tem um zero em 1 e -1
b = [bi 0 -flip(bi)];
subplot(122)
zplane(b, 1)
subplot(121)
[h, w] = freqz(b, 10000, 'whole');
plot(w/pi, 20*log10(abs(h))); grid on;

%% Tipo IV - BP, HP
% tem um zero em 1
b = [bi -flip(bi)];
subplot(122)
zplane(b, 1)
subplot(121)
[h, w] = freqz(b, 10000, 'whole');
plot(w/pi, 20*log10(abs(h))); grid on;

