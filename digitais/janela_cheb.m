clear all
close all
clc


%% Projeto janela de chebwin
As = 50;
betha = 0.5842*(As-21)^0.4 + 0.07886*(As-21);
wp = 0.4*pi; ws = 0.6*pi;
Dw = ws - wp;
wc = sqrt(wp*ws);
M = 12;
%% Primeiro ajuste
wp1 = 0.4246*pi; ws1 = 0.60164*pi;
Dw1 = ws1 - wp1;
M1 = ceil(M*Dw1/Dw);

%% Segundo ajuste
wp2 = 0.426*pi; ws2 = 0.6116*pi;
Dw2 = ws2 - wp2;
M2 = ceil(M1*Dw2/Dw1);

M = M2;
N = 2*M+1;
k = 1:M;% Coeficientes
Ap = 1;
db = 1;
% Ajuste do ganho G0
G0 = 0.027; %dB

type = 'LP';
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
        
    case 'BP'
        bi = (sin(wc2*k)-sin(wc1*k))./(pi*k);
        b0 = (wc2-wc1)./pi;
        b = [flip(bi) b0 bi];
    % Passa Faixa
        
end

m = -M:M;
mk = 0.04; % Hammingwkaiser = kaiser(N, betha);

%mk = 0; % Hann
%wk = (0.5+mk)+(0.5-mk)*cos(2*pi*m/(2*M+1));
%wkaiser = kaiser(N, betha)';
wcheb = chebwin(N, As-8)';
%wk = 1-abs(m)/(M+1); %bartlet
%wk = 0.42 +0.5*cos(2*pi*m/(2*M+1)) +0.08*cos(4*pi/(2*M+1)); %Blackman
b = b.*wcheb*10^(-G0/20);

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
hold on
plot([0 ws/pi ws/pi 1], [0 0 -As -As],'-- red')
plot([0 wp/pi wp/pi 1], [-Ap -Ap -80 -80], 'blue')
hold off
title('Filtro FIR')
subplot(323)
plot(w/pi, unwrap(angle(h))/pi);grid on
subplot(3,2,[4 6])
zplane(b,1)
axis([-2 2 -2 2]);

subplot(325)
grpdelay(b,1)
%
figure(2)
plot(w/pi, 20*log10(abs(h))); grid on
hold on
plot([0 ws/pi ws/pi 1], [0 0 -As -As], '--red')
plot([0 wp/pi wp/pi 1], [-Ap -Ap -80 -80],'green')
ylim([-80 5])
hold off

