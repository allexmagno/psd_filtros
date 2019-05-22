% clear all;
close all;
clc

% wp = 1000;
% ws = 2000;
wp = 2*pi*3400;
ws = 2*pi*4000;
Ap = 3;
As = 35;
G0 = 0;

bp = 1;
Ws = ws/wp;
n = ceil(log(10^(0.1*As) -1) / (2*log(Ws)))
% n = 7;
k = 1:n;
pk = exp((1j*(2*k+n-1)/(2*n)*pi)); % polos
ap = poly(pk);
ap = real(ap);

%%

figure(1)
zplane(bp,ap);

figure(2)
subplot(211)
[h, w] = freqs(bp,ap, logspace(-2, 3, 10000));
[h0, w0] = freqs(bp,ap, [0, 1, Ws]);  % exibir em db para valores do vetor
% 20*log10(abs(h0))
% [h, w] = freqs(b,a, linspace(0, 10, 10000));
semilogx(w, 20*log10(abs(h)))
ylim([-80 10])
grid on
hold on
semilogx(w0, 20*log10(abs(h0)), '+r')
hold off

% plot(w, 20*log10(abs(h)))
subplot(212)
semilogx(w, unwrap(angle(h))/pi)
% plot(w, unwrap(angle(h))/pi)
grid on

syms p;
Np(p) = poly2sym(bp, p);
Dp(p) = poly2sym(ap, p);
Hp(p) = Np(p) / Dp(p);
pretty(vpa(collect(Hp(p)), 5))

%%
syms s;
Hs(s) = collect(subs(Hp(p), s/wp));
[N, D] = numden(Hs(s));
pretty(vpa(Hs(s), 3))

%% Normalizando de acordo com s^n
bs = sym2poly(N);
as = sym2poly(D);
an = as(1);
bsn = bs/an;
asn = as/an;
Hsn(s) = poly2sym(bsn, s)/poly2sym(asn, s);
pretty(vpa(Hsn(s), 5))

%% Plotando ...
figure(1)
zplane(bsn, asn)
grid on

close 2
figure(2)
subplot(211)
clear h w
[h, w] = freqs(bsn, asn, logspace(1, 6, 1000));
% [h0, w0] = freqs(bp,ap, [0, 1, 2, 10, 100]);  % exibir em db para valores do vetor
semilogx(w/2/pi, 20*log10(abs(h)))
ylim([-80 10])
grid on
hold on
semilogx([10 wp wp]/2/pi, [-Ap -Ap -80], ':r')
semilogx([0 ws ws 10e4]/2/pi, [0 0 -As -As], ':r')
% semilogx(w0, 20*log10(abs(h0)), '+r')

subplot(212)
semilogx(w, unwrap(angle(h))/pi)
grid on

