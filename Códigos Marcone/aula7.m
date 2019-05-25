clear all
close all
clc

b = 1;

n = 3; % quantidade de polos
k = 1:n;
pk = exp((1j*(2*k+n-1)/(2*n)*pi)); % polos da funcao
a = poly(pk);

% Para voltar a funcao original
% pk'
% poly([pk(1) pk(7)])
% poly([pk(2) pk(6)])
% poly([pk(3) pk(5)])
% poly([pk(4)])

%% 
zplane(b,a);

%%
wp = 1000;
ws = 2000;
wp1 = logspace(0, 5, 10000);
ws1 = wp1/wp;
[h,w] = freqs(b,a,ws1);

% wp1(1:10) % pega so os valores de 1 ate 10 de wp1

% Para saber os valores exatos de cada pontos, nas freq abaixo
% [he,we] = freqs(b,a,[0,1,2,10,100]);
% 20*log10(abs(he))

figure(2)
subplot(211)
semilogx(w*wp, 20*log10(abs(h)));
hold on
subplot(212)
semilogx(w*wp, unwrap(angle(h))); %unwrap
%semilogx(we, 20*log10(abs(he)), '+r') % coloca + vermelhos em cima de cada 
                                      % ponto escolhido (0, 1, 2, 10, 100)