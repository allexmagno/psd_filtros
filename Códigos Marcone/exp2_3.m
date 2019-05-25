%% Experimento 2.3 - Filtros Digitais
% Exemplos e Experimentos baseados no livro:
% DINIZ, P. S. R., DA SILVA, E. A. B., e LIMA NETTO, S. Processamento Digital de Sinais: Projeto e An?lise de Sistemas. 2. ed. Porto Alegre: Bookman, 2014. 976 p. ISBN 978-8582601235.
% FILE: Exp2_3.m
% A frequencia do filtro depende da frequencia do sinal

%% 1? filtro
p1 = 0.9*exp(1j*pi/4); %polo
Z = [1 -1 ]'; %vetor de zeros
P = [p1 p1']'; %vetor de polos , p1 e seu conjugado
%[num,den] = zp2tf(Z,P,1); % mesma coisa de ussar a funcao poly para cada
    %um, o numero 1 equivale ao ganho da funcao de transferencia 
    num = poly(Z);
    den = poly(P);
    
[h,w] = freqz(num,den);
%figure(1); plot(w/pi,abs(h)/max(abs(h)));
figure(1); plot(w/pi,abs(h));
figure(2); zplane(num,den);
 
%% 2? filtro
fa=2e6;
z1 = exp(1j*pi/8);
z2 = exp(1j*3*pi/8);
p1 = 0.9*exp(1j*pi/4);
Z = [1 -1 z1 z1' z2 z2']';
P = [p1 p1' p1 p1' p1 p1']';
[num,den] = zp2tf(Z,P,1);
[h,w] = freqz(num,den);
%figure(1); plot(w/pi,abs(h)/max(abs(h)));
%figure(1); plot(w/pi,abs(h)); %eixo y = amplitude, eixo x escala pi
figure(1); plot(w/pi*fa/2/1e3,20*log10(abs(h))); %esacala de decibeis
ylim([-50 50]);
xlabel('frequencia [kHz]');
ylabel('ganho de amplitude [dB]');
figure(2); zplane(num,den);

 
%% 3? filtro
fa=2e6; % 2 MHz
z1 = exp(1j*pi/8);
z2 = exp(1j*3*pi/8);
p1 = 0.99*exp(1j*pi/4);
p2 = 0.9*exp(1j*pi/4 - 1j*pi/30);
p3 = 0.9*exp(1j*pi/4 + 1j*pi/30);
Z = [1 -1 z1 z1' z2 z2']';
P = [p1 p1' p2 p2' p3 p3']';
[num,den] = zp2tf(Z,P,1);
[h,w] = freqz(num,den);
%figure(1); plot(w,abs(h)/max(abs(h)));
figure(1); plot(w/pi*fa/2/1e3,20*log10(abs(h))); %esacala de decibeis
ylim([-60 60]);
xlabel('frequencia [kHz]');
ylabel('ganho de amplitude [dB]');
figure(2); zplane(num,den);