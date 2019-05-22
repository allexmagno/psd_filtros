clear all
close all
clc 

n = 100; k = 1:n;% Coeficientes
wc = 0.5*pi;
db = 0;
type = 'HP';
switch type
    case 'LP'
    %Passa Baixa
        bi = sin(wc*k)./(k*pi);
        % b0 = sin(wc*0)./(0*pi); Indeterminacao. Fazendo lophital
        b0 = wc*cos(wc*0)./(pi); % = wc/pi, pois cos(0) = 1
        b = [flip(bi) b0 bi];
    
    case 'HP'
    % Passa Alta
        bi = -sin(wc*k)./(k*pi);
        % b0 = sin(wc*0)./(0*pi); Indeterminacao. Fazendo lophital
        b0 = 1- wc*cos(wc*0)./(pi); % = wc/pi, pois cos(0) = 1
        b = [flip(bi) b0 bi];
end

figure(1)
subplot(322)
stem(b);
grid on

subplot(321)
%[h, w] = freqz(b, 1, 1000, 'whole');
%[h, w] = freqz(b, 1, linspace(-3*pi,3*pi, 10000));
[h, w] = freqz(b, 1, linspace(0,pi, 10000));
if db == 1
    plot(w/pi, 20*log10(abs(h))); grid on
else
    plot(w/pi,abs(h)); grid on
end

title('Filtro FIR')
subplot(323)
plot(w/pi, unwrap(angle(h)/pi));grid on
subplot(324)
zplane(b,1)
axis([-2 2 -2 2]);

subplot(325)
grpdelay(b,1)