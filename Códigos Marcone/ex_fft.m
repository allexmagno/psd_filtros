%%% Analyzing Cyclical Data with FFT %%%

% Limpando buffer:
% clear all; % apaga os valores atribuidos as variaveis
             % nao e recomendavel usar sempre
% close all; % fecha todas as janelas abertas
% clc; % limpa a tela

load sunspot.dat % arquivo com dados das manchas solares
year = sunspot(:,1);
relNums = sunspot(:,2);
figure(1);
subplot(2,1,1); % 2x1 - primeira imagem
plot(year,relNums)
xlabel('Year')
ylabel('Zurich Number')
title('Sunspot Data')

%%
%figure(2);
subplot(2,1,2); % 2x1 - segunda imagem
plot(year(1:50),relNums(1:50),'b.-');
xlabel('Year')
ylabel('Zurich Number')
title('Sunspot Data')

%%
y = fft(relNums); % transformada do numero de manchas querendo saber a freq
y(1) = [];
figure(3);
plot(y,'ro')
xlabel('real(y)')
ylabel('imag(y)')
title('Fourier Coefficients')

%%
n = length(y);
power = abs(y(1:floor(n/2))).^2; % power of first half of transform data
                                 % magnitude^2 = energia
maxfreq = 1/2;                   % maximum frequency
freq = (1:n/2)/(n/2)*maxfreq;    % equally spaced frequency grid
figure(4);
subplot(1,2,1);
plot(freq,power)
xlabel('Cycles/Year')
ylabel('Power')

%%
period = 1./freq;
%figure(5);
subplot(1,2,2);
plot(period,power);
%xlim([0 50]); %zoom in on max power
xlabel('Years/Cycle')
ylabel('Power')