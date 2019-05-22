%% Polinomio
%h_p = 1/((p+1)*(p^2+p+1));

%% Filtro analogico
% bp = 1;
% wp = 1e3;
% ws = 2e3;
% hO = ws/wp;
% Ap = 3;
% As = 40;
% G0 = 0;

bp = 1;
wp = 2*pi*3.4e3;
ws = 2*pi*4e3;
Ws = ws/wp;
hO = ws/wp;
Ap = 3;
As = 35;
G0 = 0;

% Ordem >= n 
n = ceil((log(10^(0.1*As)-1))/(2*log(Ws)));
% polos do filtro
k = 1:n;
pk = exp(1j*(2*k+n-1)/(2*n)*pi);
ap = poly(pk)
ap = real(ap); % nao vai ter numero real nessa equacao, pois sao complexos conjugados
% [z1,p1,k]=tf2zp(b,a)
%z2 = roots(b);
%p2 = roots(a);


figure(1)
zplane(bp,ap);

figure(2)
ws1 = wp1/wp;
[h, w] = freqs(b, a, logspace(0, 5, 10000));
% [h, w] = freqs(b, a, logspace(-1, 3, 5000));
% [he,we] = freqs(b, a, [0, 1, 2, 10, 100]);
% dbe = 20*log10(abs(he));
hold on
grid on
subplot(211)
semilogx(w*wp, 20*log10(abs(h)));
hold off
% hold on
% semilogx(we, dbe);
% hold off
subplot(212)
semilogx(w*wp, unwrap(angle(h)));

grid on

syms p
Np(p) = poly2sym(bp, p);
Dp(p) = poly2sym(ap, p);
Hp(p) = Np(p)/Dp(p);
pretty(vpa(collect(Hp(p)), 5))

%%
syms s
Hs(s) = collect(subs(Hp(p), s/wp));
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


%%
%close 1 2
figure(3)
grid on
zplane(bsn, asn)

figure(4)
grid on
subplot(211)
clear h w
[h, w] = freqs(bsn, asn, logspace(1, 4, 1000));
%hold on
semilogx(w, 20*log10(abs(h)));
ylim([-80 10])
grid on
hold on
semilogx([10 wp wp], [-Ap Ap -80], ':r');
semilogx([0 ws ws 10e4], [0 0 -As -As], ':r');
% hold off

subplot(212)
semilogx(w, unwrap(angle(h)));
grid on

%% Filtro telefonia

% wp = 2*pi*3.4e3;
% ws = 2*pi*4e3;
% Ws = ws/wp;
% hO = ws/wp;
% Ap = 3;
% As = 35;
% G0 = 0;

% n = ceil((log(10^(0.1*As)-1))/(2*log(Ws)));
% polos do filtro
% k = 1:n;
% pk = exp(1j*(2*k+n-1)/(2*n)*pi);
% ap = poly(pk)
% ap = real(ap);

