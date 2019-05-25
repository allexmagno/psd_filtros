%% Varia??o do Experimento 3.1 do livro:
% DINIZ, P. S. R., DA SILVA, E. A. B., e LIMA NETTO, S. Processamento Digital de Sinais: Projeto e An?lise de Sistemas. 2. ed. Porto Alegre: Bookman, 2014. 976 p. ISBN 978-8582601235.
% FILE: Ex3_1.m
% Exemplificando as possiveis formas de realizar a filtragem de um sinal x(n)
 
clc;close all;
%% Definindo valores iniciais
%Nh = 10; Nx = 20;
Nh = 400; Nx = 10000;
x = ones(1,Nx); %vetor de 1
% A resposta ao inpulso de um sistema h(n) 
% no filtro FIR aos coeficientes b(n) = h(n) 
h = 1:Nh; b = h;
%% Filtrando o sinal e medindo tempos
 
% Filtragem utilizando a convolu??o
% NOTE: length(y) = length(x) + length(h) -1
tic;  % iniciar a contagem do tempo
y1 = conv(x,h); %funcao convolucao
t(1) = toc; % terminar acontagem e mostrar tempo no console
 
% filtragem utilizando a equa??o recursiva
% NOTE: length(y) = length(x)
tic;
y2 = filter(b,1,x);
t(2) = toc;
 
% filtragem utilizando a equa??o recursiva
% aumentando o tamanho de x para que length(y3) = length(y1)
x3 = [x zeros(1,length(h)-1)];
tic;
y3 = filter(h,1,x3); 
t(3) = toc;
 
length_y = length(x) + length(h) - 1;
 
% filtragem utilizando a FFT
% a y = IFFT(FFT(x)*FFT(h))
tic;
X = fft(x,length_y);
H = fft(h,length_y);
Y4 = X.*H;
y4 = ifft(Y4);
t(4) = toc;
 
% filtragem utilizando a fun??o fftfilt
% a y = IFFT(FFT(x)*FFT(h))
 
tic
y5 = fftfilt(h,x3);
t(5) = toc;
 
disp('Comprimento do vetor de sa?da length(y)')
disp(['    ' num2str([length(y1) length(y2) length(y3) length(y4) length(y5)])])
disp('Tempo usado na filtragem em micro segundos')
disp(['    ' num2str(t*1e6) ' us'])
 
%%  Plotando o gr?fico
subplot(411);stem(y1);
hold on;
stem(y2,'xr');
stem(y3,'+m');
legend('y1', 'y2', 'y3')
hold off
subplot(412);stem(y1, 'ob');legend('y1')
subplot(413);stem(y2, 'xr'); hold on; stem(zeros(size(y1)),'.w');hold off; legend('y2')
subplot(414);stem(y3, '+m');legend('y3')