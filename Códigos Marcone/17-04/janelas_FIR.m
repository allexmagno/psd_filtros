clear all;
close all;
clc;

M = 8;
k = -M: M;

% retangular
wk = ones(size(k));
stem(wk,'x','green');hold on;
% bartlett
wk = 1 -abs(k)/(M+1);
stem(wk,'o','red');
%hann
wk = 0.5 + 0.5*cos(2*pi*k/(2*M+1));
stem(wk,'d','blue');
%hamming
wk = 0.54 + 0.46*cos(2*pi*k/(2*M+1));
stem(wk,'+','black');
legend('retangular','bartlett','hann','hamming');title('Janelas temporais usadas em filtros digitais');xlim([-1 19]); ylim([-0.5 1.5]);
hold off;