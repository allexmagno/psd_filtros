%% Projeto do filtro Chebyshev
% 
clear all;
close all;
clc
% Determinando a ordem
As = 40; % stop bando
Ap = 3,01; % passgem
wp = 1e3; % freq de passagem
ws = 2e3; % freq de stop
Ws = ws/wp;
% para Ap = 3dB E=1
E = sqrt(10^(0.1*Ap) - 1);
n = ceil(acosh(sqrt((10^(0.1*As) - 1)/(10^(0.1*Ap) -1)))/acosh(Ws)); % Ordem
% Formula retirada do livro e wiki
for n=2:10
% achando os polos (Formula do livro/wiki)
fi2 = 1/n * asinh(1/E);

k = 1:n;
tk = (2*k-1)*pi/(2*n);
pk = -sinh(fi2)*sin(tk) + 1j*cosh(fi2)*cos(tk);

plot(real(pk), imag(pk), 'x'); axis([-1.1 1.1 -1.1 1.1]); axis square
plot(pk, 'x'); axis([-1.1 1.1 -1.1 1.1]); axis square
zplane(1, poly(pk));
n = 6;
% fazendo o produtorio
dp = real(poly(pk));
%d0 = dp(end)
d0 = real(prod(-pk))
if mod(n, 2) == 0
    H0 = sqrt(1/(1+E^2)) * d0 % quando a ordem eh par
else
    H0 =  1 * d0 % quando a ordem eh impar
end


syms p;
Dp(p) = poly2sym(dp, p);
Hp(p) = H0 / Dp(p);
pretty(vpa(collect(Hp(p)), 5))

%%

%freqs(d0,dp)

[h, w] = freqs(d0, dp, logspace(-2, 2, 1000));

semilogx(w, 20*log10(abs(h)));
grid on
hold on
end



%% polinomios para filtro ordem n (0 a 5)
% c0 = [1];
% c1 = [1 0];
% c2 = [2 0 -1]; 
% c3 = [4 0 -3 0];
% c4 = [8 0 -8 1];
% c5 = [16 0 -20 0 5 0];
% 
% % Polos de Cn
% p2 = roots(c2);
% p3 = roots(c3);
% p4 = roots(c4);
% p5 = roots(c5);
% 
% % Elevando os polinomios ao quadrado
% c0_2 = 1; 
% c1_2a = [1 0 0]; % maneira na mao
% c1_2 = conv(c1, c1); % utilizando a convolucao
% c2_2 = conv(c2, c2); 
% c3_2 = conv(c3, c3);
% c4_2 = conv(c4, c4);
% c5_2 = conv(c5, c5);
% cn = [c0_2 c1_2 c2_2 c3_2 c4_2 c5_2];
% 
% 
% %% Na mao
% % para n impar
% H0i = 1;
% 
% % para n impar
% H0p = 1/(E^2 + 1);
% 
% % Modulo par
% % h2w = H0p^2/(1 + E^2*cn(2+1));
% % h2w = H0p^2/(1 + E^2*cn(4+1));
% W = [0:0.01:1000];
% 
% % p/ n = 2
% H2w_c2 = 1./(4*W.^4- 4*W.^2 +2);
% semilogx(W, 10*log10(H2w_c2))
% grid on
% hold on
% 
% % p/ n = 3
% H2w_c3 = 1./(16*W.^6 - 24*W.^4 + 9*W.^2 + 2);
% semilogx(W, 10*log10(H2w_c3))
% 
% % p/ n = 4
% H2w_c4 = 1./(64*W.^8 - 128*W.^6 + 80*W.^4 - 16*W.^2 + 2);
% semilogx(W, 10*log10(H2w_c4))
% 
% 
% % p/ n = 5
% H2w_c5 = 1./(256*W.^10 - 640*W.^8 + 560*W.^6 - 200*W.^4 + 25*W.^2);
% semilogx(W, 10*log10(H2w_c5))
% 
% hold off
% 
% % Modula impar
% % h2w = H0i^2/(1 + E^2*cn(1+1));
% % h2w = H0i^2/(1 + E^2*cn(3+1));
% % h2w = H0i^2/(1 + E^2*cn(5+1));

