clear all;
close all;
clc;

n = 10;
M = 10;
k = 1:n;
wc = 0.5*pi;
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
end
m = -M : M;
%mk = 0.04; % filtro hamming
mk = 0.00; % filtro hann
wk = (0.5+mk)+(0.5-mk)*cos(2*pi*m/(2*M+1));
b = b.*wk;

subplot(322)
stem([flip(bi) b0 bi]); grid on;title('Resposta ao impulso');
subplot(3,2,[4 6])
zplane(b, 1)
axis([-2 2 -2 2]);
subplot(321)
[h, w] = freqz(b,1,linspace(0,pi,10000)); 
%plot(w/pi,abs(h)); grid on; xlim([0 1])    %dominio do tempo
plot(w/pi,20*log10(abs(h))); grid on; xlim([0 1]);title('Resposta de magnitude de H(z)');
subplot(323)
plot(w/pi, unwrap(angle(h))/pi); grid on;title('Resposta de fase de H(z)');
subplot(325)
grpdelay(b, 1);title('Atraso de grupo');
