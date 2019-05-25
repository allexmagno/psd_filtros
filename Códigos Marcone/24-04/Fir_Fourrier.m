clear all;
close all;
clc;

wp = 0.4*pi;    %frequência de passagem especificada
ws = 0.6*pi;    %frequência de stop especificada
As = 50; 
Ap = 1;
wc = sqrt(wp*ws);   % frequência de corte, média das frequências
Dw = ws - wp;
M = ceil(3.32*pi/Dw); % ordem (3.32 tabela Hamming)
g0 = 0;

%Ajuste do ganho
    %levar o pico para abaixo de 0
    ganho = 0.020693; %ganho dB mediddo no plot do filtro
    g0 = ganho;

% primeiro ajuste de M (N/2)
    wp1 = 0.4344*pi; ws1 = 0.6224*pi; % valores medidos no gráfico
    Dw1 = ws1 - wp1;
    M2 = ceil(M*Dw1/Dw);
    M = M2; 
   

% segundo ajuste de M (N/2)
    wp2 = 0.4463*pi; ws2 = 0.5975*pi;
    Dw2 = ws2 - wp2;
    M3 = ceil(M*Dw2/Dw);
    M = M3;
  
    
% Terceiro ajuste da frequência de corte
    Dwp = 0.4*pi - wp2;
    Dws = 0.6*pi - ws2;
    wc3 = wc + (Dwp + Dws)/2;
    wc = wc3;


% % teste filtro BP
%     wc1 = 0.25*pi; wc2 = 0.55*pi;
%     M = ceil(M*5/3);


k = 1:M;
type = 'LP';

switch type
    case 'LP'
        bi = sin(k*wc)./(k*pi);
        b0 = wc/pi;
        b = [flip(bi) b0 bi];
    case 'HP'
        bi = -sin(k*wc)./(k*pi);
        b0 = 1 - ( wc/pi);
        b = [flip(bi) b0 bi];
    case 'BP'
        bi = (sin(k*wc2) - sin(k*wc1))./(k*pi);
        b0 = (wc2 - wc1)/pi;
        b = [flip(bi) b0 bi];
end
m = -M : M;
mk = 0.04; % filtro hamming
%mk = 0.00; % filtro hann
wk = (0.5+mk)+(0.5-mk)*cos(2*pi*m/(2*M+1)); %serve para filtro hamming ou hann
%wk = (0.42)+(0.5)*cos(2*pi*m/(2*M+1))+(0.08)*cos(4*pi*m/(2*M+1)); %filtro blackman
b = b.*wk*10^(-g0/20);
%b = b.*10^(-g0/20);     %janela retangular, basta tirar a janela


%Somente para acertar a janela no plot
wp = 0.4*pi;    %frequência de passagem
ws = 0.6*pi;    %frequência de stop


subplot(321)
[h, w] = freqz(b,1,linspace(0,pi,10000)); 
%plot(w/pi,abs(h)); grid on; xlim([0 1])    %dominio do tempo
hold on;
plot(w/pi,20*log10(abs(h))); grid on; xlim([0 1]);title('Resposta de magnitude de H(z)');ylim([-80 5]);
plot([0,wp/pi,wp/pi],[-Ap,-Ap,-80], '--red')
plot([0,ws/pi,ws/pi,1],[0,0,-As,-As], '--red')
hold off;

subplot(322)
stem([flip(bi) b0 bi]); grid on;title('Resposta ao impulso');

subplot(3,2,[4 6])
zplane(b, 1)
axis([-2 2 -2 2]);

subplot(323)
plot(w/pi, unwrap(angle(h))/pi); grid on;title('Resposta de fase de H(z)');
subplot(325)
grpdelay(b, 1);title('Atraso de grupo');

figure(2)
hold on;
plot(w/pi,20*log10(abs(h))); grid on; xlim([0 1]);title('Resposta de magnitude de H(z)');ylim([-80 5]);
plot([0,wp/pi,wp/pi],[-Ap,-Ap,-80], '--red')
plot([0,ws/pi,ws/pi,1],[0,0,-As,-As], '--red')
hold off;