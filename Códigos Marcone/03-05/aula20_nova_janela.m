clear all;
close all;
clc;

wp = 0.4*pi; ws = 0.6*pi; % spec
As = 50; Ap = 1; % spec
wc1 = sqrt(wp*ws); % media geometrica
% wc = 0.1*pi;
Dw1 = ws - wp;
G0 = 0;

% primeiro ajuste
G0 = 0.025; % db

% Projeto inicial
Dw = Dw1;
wc = wc1;
Ask = As + 0;
betha = 0.5842*(Ask-21)^0.4 + 0.07886*(Ask-21);
N = ceil((As - 8)/(2.285*Dw)+1);
M1 = (N-1)/2; % para impar
M = M1;
N = 2*M+1;

% segundo ajuste M (n/2)
wp2 = 0.4343*pi; ws2 = 0.5884*pi;
Dw2 = ws2 -wp2;
M2 = ceil(M1*Dw2/Dw1); % nova ordem do filtro 2*M2
M = M2;
N = 2*M+1;
wc = wc - 0.02*pi;
wkeiser = kaiser(N, betha)';

% % segundo ajuste M (n/2)
% wp2 = 0.4395*pi; ws2 = 0.5839*pi;
% Dw2 = ws2 -wp2;
% M2 = ceil(M1*Dw2/Dw1); % nova ordem do filtro 2*M2
% M = M2;
% 
% % terceiro ajuste M (n/2) (nem precisava - deu mesma ordem do segundo)
% wp3 = 0.4239*pi; ws3 = 0.6124*pi;
% Dw3 = ws3 - wp3;
% M3 = ceil(M2*Dw3/Dw1); % nova ordem do filtro 2*M2
% M = M3;

% % ajuste deslocamento
% Dws = ws - ws3;
% Dwp = wp - wp3;
% wc3 = wc1 + (Dwp + Dws)/2;
% wc = wc3;

wc1 = 0.25*pi; wc2 = 0.55*pi;

% M = ceil(M*5/3);
k = 1:M;
type = 'LP'; db = 1;
switch type
    case 'LP'
        bi = sin(wc*k)./(pi*k);
        b0 = wc/pi;
        b = [flip(bi) b0 bi];

    case 'HP'
        bi = -sin(wc*k)./(pi*k);
        b0 = 1-wc/pi;
        b = [flip(bi) b0 bi];
        
    case 'BP'
        bi = (sin(k*wc2) - sin(k*wc1))./(k*pi);
        b0 = (wc2-wc1)/pi
        b = [flip(bi) b0 bi];
        
end

m = -M:M;
mk= 0.04; %0.04 -> hamming
% mk= 0.0; %0.04 -> hann
wk = (0.5+mk)+(0.5-mk)*cos(2*pi*m/(2*M+1));
% wk = 1 - abs(m)/(M+1); % bartlett
% wk = 0.42 + 0.5*cos(2*pi*m/(2*M+1)) + 0.08*cos(4*pi*m/(2*M+1)); % blackmann
% b = b.*wk*10^(-G0/20); % regular altura do filtro em db
% b = b.*10^(-G0/20); % sem janela (retangular)
b = b.*wkeiser*10^(-G0/20); % janela de keiser

% subplot(3,2,[4 6])
% zplane(b, 1);
% axis([-2 2 -2 2])
% [h, w] = freqz(b, 1, 'whole');
% subplot(322)
% stem(b), grid on;
% subplot(321)
% [h, w] = freqz(b, 1, linspace(0,pi,10000));
% % plot(w/pi, abs(h)); grid on;
% plot(w/pi, 20*log10(abs(h))); grid on;
% ylim([-80 5])
% Amim = 80
% % plot([0 wp wp]/pi, -[Ap Ap Amin], 'r');
% 
% subplot(323)
% plot(w/pi, unwrap(angle(h))/pi); grid on;
% subplot(325)
% grpdelay(b, 1)


[h, w] = freqz(b, 1, linspace(0,pi,10000));
% plot(w/pi, abs(h)); grid on;
plot(w/pi, 20*log10(abs(h))); grid on;
ylim([-80 10])
hold on;
plot([0,wp,wp]/pi,[-Ap,-Ap,-80], '-red')
plot([0,ws/pi,ws/pi,1],[0,0,-As,-As], '-red')
