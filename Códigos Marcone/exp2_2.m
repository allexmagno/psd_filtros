%  Exemplos e Experimentos baseados no livro:
% DINIZ, P. S. R., DA SILVA, E. A. B., e LIMA NETTO, S. Processamento Digital de Sinais: Projeto e An?lise de Sistemas. 2. ed. Porto Alegre: Bookman, 2014. 976 p. ISBN 978-8582601235.
%% Experimento 2.2
% Resposta em frequencia usando a fun??o freqz
format short
N = 1; % se aumentar o sinal se repete no eixo
num = [1 0 0];
%den = poly([0.8 0.2]);
den = poly([0.8 5]); % no caso de um sistema instavel, raiz fora do circulo unitario
% modo 1
[H,w]=freqz(num,den,-N*pi:pi/1000:N*pi-pi/100);
subplot(211);plot(w/pi, abs(H));
subplot(212);plot(w/pi, angle(H));
%% modo 2
%[H,w]=freqz(num,den);
%plot(w/pi, abs(H));
% modo 3
%[H,w]=freqz(num, den, 'whole');
%plot(w/pi, abs(H));
% modo 4
freqz(num, den, 'whole'); % substitui Z por e^jw, transformada Z
figure(2);
zplane(num,den);
 
%% Resposta em frequencia substituindo z -> e^(jw)
syms z % faz com que a variavel z seja simbolica, ou seja descreve uma funcao
Hf(z) = symfun(1/(z-0.2)/(z+0.8),z);
pretty(Hf) % printa em ascii na tela a equacao da forma convencional
latex(Hf) % printa a linha de cod necessaria para utilizar no Latex
N = 1;
w = 0:pi/100:N*pi-pi/100;
plot(w/pi,abs(Hf(exp(1i*w))))
%title(['$' latex(Hf) '$'],'interpreter','latex')
text(0.2,2,['H(z) = ' '$$' latex(Hf) '$$'],'interpreter','latex')
xlabel(['w/' '$$' '\pi' '$$'],'interpreter','latex')