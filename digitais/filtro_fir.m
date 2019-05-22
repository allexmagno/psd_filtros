clear all
close all
clc 

N = 2;
bi = 2*(rand(1, N)-0.5);

%% tipo 1
b = [bi*(2*rand(1,1)-0.5) flip(bi)];
figure(1)
subplot(122)
zplane(b,1)
subplot(121)
%[h, w] = freqz(b, 1, 1000, 'whole');
[h, w] = freqz(b, 1, linspace(-3*pi,3*pi, 1000));
plot(w/pi, 20*log10(abs(h))); grid on
title('Filtro FIR tipo I')

%plot(w/pi, unwrap(angle(h)/pi));grid on
%grpdelay(b,1)
%% tipo 2
b = [bi flip(bi)];
figure(2)
subplot(122)
zplane(b,1)
subplot(121)
[h, w] = freqz(b, 1, 1000, 'whole');
plot(w/pi, 20*log10(abs(h))); grid on
title('Filtro FIR tipo II')
%grpdelay(b,1)

%% tipo 3
% Com zero em (-1) e^(jpi)
b = [bi 0 -flip(bi)];
figure(3)
subplot(122)
zplane(b,1)
subplot(121)
[h, w] = freqz(b, 1, 1000, 'whole');
plot(w/pi, 20*log10(abs(h))); grid on
title('Filtro FIR tipo III')
%grpdelay(b,1)
%% tipo 
% Com zero em (-1) e^(jpi)
b = [bi -flip(bi)];
figure(4)
subplot(122)
zplane(b,1)
subplot(121)
[h, w] = freqz(b, 1, 1000, 'whole');
plot(w/pi, 20*log10(abs(h))); grid on
title('Filtro FIR tipo IV')
%grpdelay(b,1)