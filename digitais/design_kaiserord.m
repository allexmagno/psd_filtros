clear all;
close all;
clc

%% Projeto do filtro
fsamp = 8000;
As = 50; Ap = 1;
fcuts = [1600 2400];
w = fcuts/8000*(2*pi);
wp = w(1)/pi; ws = w(2)/pi;
mags = [1 0]; % Passa baixa
devs = [10^(-Ap/20) 10^(-As/20)];%Desvios
[n, Wn, beta, ftype] = kaiserord(fcuts, mags, devs, fsamp);

h_fir = fir1(n,Wn,ftype,kaiser(n+1,beta),'noscale');
[Hw,w] = freqz(h_fir);
plot(w*fsamp/2/pi,20*log10(abs(Hw))); 
title(['Kaiser filter N = ' num2str(n)])
hold on
plot([0 ws*(fsamp/2) ws*(fsamp/2) fsamp/2], [0 0 -As -As],'-- red')
plot([0 wp*(fsamp/2) wp*(fsamp/2) fsamp/2], [-Ap -Ap -80 -80], 'blue')
hold off
