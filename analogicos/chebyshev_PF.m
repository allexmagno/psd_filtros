clear all; 
close all;
clc
fp1 = 999.5; fp2 = 1000.5; % Hz
% Atenuacao de passagem e de stoband
Ap = 3; As = 10; % dB
% Frequencia de stop
fs1 = 1001; fs2 = 999; % Hz
% Frequencia media
f0 = sqrt(fp1*fp2)
% Largura de banda
B = fp2-fp1; % Hz
% w de passagem 
wp1 = 2*pi*fp1; wp2 = 2*pi*fp2; w0 = 2*pi*f0; % rad/s
% w media
w0 = 2*pi*f0; % rad/s
% Largurad de banda em W (omega)
Bw = 2*pi*B; 
% w de stop 
ws1 = 2*pi*fs1; ws2 = 2*pi*fs2; w0 = 2*pi*f0; 
% Omega maiusculo de stop. Deve ser o menor dentre os valores obtidos
Os1= abs(w0^2-ws1^2)/(Bw*ws1) 
Os2= abs(w0^2-ws2^2)/(Bw*ws2)
Os = min(Os2, Os1);
Op = 1;

%% Projeto de filtro
[n1, Wn] = buttord(Op, Os, Ap, As, 's');
[b1, a1] = butter(n1, Wn,'s' );
[b2, a2] = butter(n1, 1,'s' );


[h1, w] = freqs(b1 ,a1, logspace(-2, 1, 10000));
semilogx(w, 20*log10(abs(h1)))
grid on
hold on
[h2, w] = freqs(b2 ,a2, logspace(-2, 1, 10000));
semilogx(w, 20*log10(abs(h2)))

%% Transforma??o de freq
%LP to LP

ap = a1, bp = b1; % Butterworh
syms p
Np(p) = poly2sym(bp, p);
Dp(p) = poly2sym(ap, p);
Hp(p) = Np(p)/Dp(p);
pretty(vpa(collect(Hp(p)), 5))

syms s
Hs(s) = collect(subs(Hp(p), (s^2 + w0^2)/(Bw*s)));
[N, D] = numden(Hs(s));
pretty(vpa(Hs(s), 3))

%%
bs = sym2poly(N);
as = sym2poly(D);

an = as(1); % para normalizar
bsn = bs/an; % bs normalizado
asn = as/an; % as normalizado
Hsn(s) = poly2sym(bsn, s)/poly2sym(asn, s);
pretty(vpa(Hsn(s), 5))

%% Resposta em frequencia
figure(2)
clear h w
[h, w] = freqs(bsn, asn, linspace(990, 1.1e3*2*pi, 10000));
plot(w/2/pi, 20*log10(abs(h)));
xlim([900 1.1e3])
grid on

%zplane(bsn, asn)
