%%  Exemplo 1: Filtro passa-baixas
clear all;
close all;
clc;


fp = 941; fs = 1209; %Hz 
Ap = 1; As = 20; %dB 
Wp = 1;
Fs = fs/fp;

n = cheb1ord(Wp, Fs, Ap, As, 's') % fornece a ordem e o coeficiente da funcao de transf
[b, a] = cheby1(n, Ap,  Wp, 's');

figure(1)
[h, w] = freqs(b, a, logspace(-2, 2, 1000));
subplot(211)
semilogx(w, 20*log10(abs(h)));
xlim([0.8 1.5])
legend('chebyshev filter - PB')
grid on
hold on
fmax = 1.5;
fmin = 0.8;
Amin = -25;
plot([fmin, Fs, Fs, fmax], [0, 0, -As, -As])
plot([fmin, Wp, Wp], [-Ap, -Ap, Amin])

%
syms p
Np(p) = poly2sym(b, p);
Dp(p) = poly2sym(a, p);
Hp(p) = Np(p)/Dp(p);
pretty(vpa(collect(Hp(p)), 5))

%
syms s
Hs(s) = collect(subs(Hp(p), s/fp));
[N, D] = numden(Hs(s));
pretty(vpa(Hs(s), 3))

%
bs = sym2poly(N);
as = sym2poly(D);

an = as(1); % para normalizar
bsn = bs/an; % bs normalizado
asn = as/an; % as normalizado
Hsn(s) = poly2sym(bsn, s)/poly2sym(asn, s);
pretty(vpa(Hsn(s), 5))

% Resposta em frequencia

clear h w
[h, w] = freqs(bsn, asn, logspace(1, 6, 1000));
%hold on
subplot(212)
semilogx(w, 20*log10(abs(h)));
xlim([800 1.51e3])
grid on
hold on
plot([0, fs, fs, 1.5e3], [0, 0, -As, -As])
plot([800, fp, fp], [-Ap, -Ap, -25])
grid on
hold on


%%  Exemplo 2: Filtro passa-alta
clear fp fs;
fp = 1209; fs = 941; %Hz
clear Fs

Fs = fp/fs;

n = cheb1ord(Wp, Fs, Ap, As, 's'); % fornece a ordem e o coeficiente da funcao de transf
[~, ~] = cheby1(n, Ap,  Wp, 's');
[n, ~] = cheb1ord(Wp, Fs, Ap, As, 's'); % fornece a ordem e o coeficiente da funcao de transf
[b, a] = cheby1(n, Ap,  Wp, 's');

figure(2)
[h, w] = freqs(b, a, logspace(-2, 2, 1000));
subplot(211)
semilogx(w, 20*log10(abs(h)));
xlim([0.8 1.5])
legend('chebyshev filter - PA')
grid on
hold on
fmax = 1.5;
fmin = 0.8;
Amin = -25;
plot([fmin, Fs, Fs, fmax], [0, 0, -As, -As])
plot([fmin, Wp, Wp], [-Ap, -Ap, Amin])

%
syms p
Np(p) = poly2sym(b, p);
Dp(p) = poly2sym(a, p);
Hp(p) = Np(p)/Dp(p);
pretty(vpa(collect(Hp(p)), 5))

%
syms s
Hs(s) = collect(subs(Hp(p), fp/s));
[N, D] = numden(Hs(s));
pretty(vpa(Hs(s), 3))

%
bs = sym2poly(N);
as = sym2poly(D);

an = as(1); % para normalizar
bsn = bs/an; % bs normalizado
asn = as/an; % as normalizado
Hsn(s) = poly2sym(bsn, s)/poly2sym(asn, s);
pretty(vpa(Hsn(s), 5))

% Resposta em frequencia

clear h w
[h, w] = freqs(bsn, asn, logspace(1, 6, 1000));
%hold on
subplot(212)
semilogx(w, 20*log10(abs(h)));
xlim([900 1.51e3])
grid on
hold on
plot([1.5e3, fp, fp, 0], [-Ap, -Ap, -As, -As])
plot([1.5e3, fs, fs], [0, 0, -25])
grid on
hold off

%% Exemplo 3: Filtro passa-faixa
clear all; 
fp1 = 811; fp2 = 895.5; % Hz
% Atenuacao de passagem e de stoband
Ap = 1; As = 30; % dB
% Frequencia de stop
fs1 = 770; fs2 = 941; % Hz
% Frequencia media
f0 = sqrt(fp1*fp2);
% Largura de banda
B = fp2-fp1; % Hz
% w de passagem 
wp1 = 2*pi*fp1; wp2 = 2*pi*fp2;
% w media
w0 = 2*pi*f0; % rad/s
% Largurad de banda em W (omega)
Bw = 2*pi*B; 
% w de stop 
ws1 = 2*pi*fs1; ws2 = 2*pi*fs2; w0 = 2*pi*f0; 
% Omega maiusculo de stop. Deve ser o menor dentre os valores obtidos
Os1= abs(w0^2-ws1^2)/(Bw*ws1); 
Os2= abs(w0^2-ws2^2)/(Bw*ws2);
Os = min(Os2, Os1);
Op = 1;

% Projeto de filtro
[n1, Wn] = buttord(Op, Os, Ap, As, 's');
[b1, a1] = butter(n1, Wn,'s' );
[b2, a2] = butter(n1, 1,'s' );

figure(3)
subplot(211)
[h1, w] = freqs(b1 ,a1, logspace(-2, 1, 10000));
semilogx(w, 20*log10(abs(h1)))
grid on
hold on
[h2, w] = freqs(b2 ,a2, logspace(-2, 1, 10000));
semilogx(w, 20*log10(abs(h2)))

% Transforma??o de freq
%LP to LP

ap = a1; bp = b1; % Butterworh
syms p
Np(p) = poly2sym(bp, p);
Dp(p) = poly2sym(ap, p);
Hp(p) = Np(p)/Dp(p);
pretty(vpa(collect(Hp(p)), 5))

syms s
Hs(s) = collect(subs(Hp(p), (s^2 + w0^2)/(Bw*s)));
[N, D] = numden(Hs(s));
pretty(vpa(Hs(s), 3))

%
bs = sym2poly(N);
as = sym2poly(D);

an = as(1); % para normalizar
bsn = bs/an; % bs normalizado
asn = as/an; % as normalizado
Hsn(s) = poly2sym(bsn, s)/poly2sym(asn, s);
pretty(vpa(Hsn(s), 5))

% Resposta em frequencia
figure(3)
subplot(212)
clear h w
[h, w] = freqs(bsn, asn, linspace(990, 1.1e3*2*pi, 10000));
plot(w/2/pi, 20*log10(abs(h)));
xlim([700 1e3])
grid on

%zplane(bsn, asn)
