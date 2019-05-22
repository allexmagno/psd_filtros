%%  Exemplo 1: Filtro passa-baixas
clear all;
close all;
clc;

fp = 941; fs = 1209; %Hz 
Ap = 1; As = 20; %dB 
fa = 8e3; % freq de amostragem (telefonia)

wp = 2*pi*fp; % rad/s
ws = 2*pi*fs; % rad/s
wa = 2*pi*fa; % rad/s

tetha_s = ws/(wa/2); % referente a wa = 1
tetha_p = wp/(wa/2); % referente a wa = 1

%lambda sera os valores utilizados no projeto
lambda_s = 2*tan(tetha_s*pi/2); % Obter o valor desse angulo predistorcido ? para compensar a distor??o na frequ?ncia causada pela transforma??o bilinear
lambda_p = 2*tan(tetha_p*pi/2);

%% Projeto do filtro
Os = lambda_s/lambda_p;
Op = 1;

n = cheb1ord(Op, Os, Ap, As, 's'); % fornece a ordem e o coeficiente da funcao de transf
[b, a] = cheby1(n, Ap,  Op, 's');

figure(1)
title('H(p)')
[h, w] = freqs(b, a, logspace(-2, 1, 1000));
subplot(121)
plot(w, 20*log10(abs(h)));
xlim([0.8 1.5])
grid on
hold on
fmax = 1.5;
fmin = 0.8;
Amin = -25;
plot([fmin, Os, Os, fmax], [0, 0, -As, -As],'r')
plot([fmin, Op, Op], [-Ap, -Ap, Amin], 'y')
subplot(122)
zplane(b,a)


%%
syms p
Np(p) = poly2sym(b, p);
Dp(p) = poly2sym(a, p);
Hp(p) = Np(p)/Dp(p);
pretty(vpa(collect(Hp(p)), 5))

% H(p) -> H(s)
syms s
Hs(s) = collect(subs(Hp(p), s/lambda_p));
[N, D] = numden(Hs(s));
pretty(vpa(Hs(s), 3))

% Normalizando
bs = sym2poly(N);
as = sym2poly(D);
                                                                                                                                                                                                                
an = as(1); % para normalizar
bsn = bs/an; % bs normalizado
asn = as/an; % as normalizado
Hsn(s) = poly2sym(bsn, s)/poly2sym(asn, s);
pretty(vpa(Hsn(s), 5))
% Resposta em frequencia
clear h w
[h, w] = freqs(bsn, asn,  logspace(-1, 2, 1000));
%hold on
figure(2)
title('H(s)')
subplot(121)
semilogx(w, 20*log10(abs(h)));
xlim([0 2])
grid on
hold on
plot([0.1, lambda_s, lambda_s, 2], [0, 0, -As, -As],'r')
plot([0.1, lambda_p, lambda_p], [-Ap, -Ap, -25], 'g')
grid on
hold off
subplot(122)
zplane(bsn, asn)

%% H(s) -> H(z)
syms z;
Hz(z) = collect(subs(Hs(s), 2*((z-1)/(z+1))));   
[N, D] = numden(Hz(z));
pretty(vpa(Hz(z), 3))

bz = sym2poly(N);
az = sym2poly(D);

an = az(1); % para normalizar
bzn = bz/an; % bs normalizado
azn = az/an; % as normalizado
Hzn(z) = poly2sym(bzn, z)/poly2sym(azn, z);
pretty(vpa(Hzn(z), 5))

clear h w
figure(3)
[h, w] = freqz(bzn, azn, logspace(-3, 0, 10000));
subplot(121)
semilogx(w/pi*fa/2, 20*log10(abs(h)));
xlim([100 1.75e3])
grid on
hold on

plot([100, fs, fs, 2e3], [0, 0, -As, -As], 'r')
plot([100, fp,fp],[-Ap, -Ap, -20], 'y')
subplot(122)
zplane(bzn,azn)