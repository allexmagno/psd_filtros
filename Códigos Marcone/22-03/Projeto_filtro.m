clear all
close all
clc

%projeto do filtro
As = 40; Rs = As;Ap = 3; Rp = Ap;wp = 1000;ws = 2000;Wp = 1;Ws = ws/wp; %Lowpass
As = 40; Rs = As;Ap = 3; Rp = Ap;wp = 1000;ws = 500;Wp = 1;Ws = wp/ws; %Highpass

%% Butterworth
[n1,Wn] = buttord(Wp,Ws,Rp,Rs,'s');
[b1,a1] = butter(n1,Wn,'s');

%% Chebyshev I
n2 = cheb1ord(Wp,Ws,Rp,Rs,'s');
[b2,a2] = cheby1(n2,Rp,Wp,'s');

%% Chebyshev II
n3 = cheb2ord(Wp, Ws, Ap, As,'s');
[b3,a3] = cheby2(n3,As, Ws, 's');

%% Elliptic - Cauer
[n4, Wn] = ellipord(Wp, Ws, Ap, As,'s')
[b4,a4] = ellip(n4,Ap,As, Wn, 's');


%% Plot
figure(1)

subplot(221)
[h1,w1] = freqs(b1,a1,logspace(-2,1,1000));
semilogx(w1,20*log10(abs(h1)))
hold on; grid on;
[h2,w2] = freqs(b2,a2,logspace(-2,1,1000));
semilogx(w2,20*log10(abs(h2)));
[h3,w3] = freqs(b3,a3,logspace(-2,1,1000));
semilogx(w3,20*log10(abs(h3)));
[h4,w4] = freqs(b4,a4,logspace(-2,1,1000));
semilogx(w4,20*log10(abs(h4)));
hold off;
legend(['Butterworth n= ' num2str(n1)],['Chebyshev I n= ' num2str(n2)], ...
    ['Chebyshev II n= ' num2str(n3)],['Elliptic - Cauer n= ' num2str(n4)],'Location','southwest');

subplot(223)
semilogx(w1,(unwrap(angle(h1))/pi))
hold on; grid on;
semilogx(w2,(unwrap(angle(h2))/pi))
semilogx(w3,(unwrap(angle(h3))/pi))
semilogx(w4,(unwrap(angle(h4))/pi))
hold off;
legend(['Butterworth n= ' num2str(n1)],['Chebyshev I n= ' num2str(n2)], ...
    ['Chebyshev II n= ' num2str(n3)],['Elliptic - Cauer n= ' num2str(n4)],'Location','southwest');

subplot(2,2,[2,4])
plot(real(roots(b1)),imag(roots(b1)),'o',real(roots(a1)),imag(roots(a1)),'x');
hold on; grid on;
plot(real(roots(b2)),imag(roots(b2)),'o',real(roots(a2)),imag(roots(a2)),'x');
plot(real(roots(b3)),imag(roots(b3)),'o',real(roots(a3)),imag(roots(a3)),'x');
plot(real(roots(b4)),imag(roots(b4)),'o',real(roots(a4)),imag(roots(a4)),'x');
max = 4;
axis([-1.1 1.1 -1.1 1.1]*max);axis square;
hold off;
legend(['Butterworth n= ' num2str(n1)],['Chebyshev I n= ' num2str(n2)], ...
    ['Chebyshev II n= ' num2str(n3)],['Elliptic - Cauer n= ' num2str(n4)]);


%% Transformação de frequência Lowpass para Lowpass
ap = a4; bp = b4; %% Eliptico
syms p;
Np(p) = poly2sym(bp, p);
Dp(p) = poly2sym(ap, p);
Hp(p) = Np(p) / Dp(p);
pretty(vpa(collect(Hp(p)), 5))

% transformação de frequência
syms s;
Hs(s) = collect(subs(Hp(p), s/wp));
[N, D] = numden(Hs(s));
pretty(vpa(Hs(s), 3))

% Normalizando de acordo com p^n
bs = sym2poly(N);
as = sym2poly(D);
an = as(1);
bsn = bs/an;
asn = as/an;
Hsn(s) = poly2sym(bsn, s)/poly2sym(asn, s);
pretty(vpa(Hsn(s), 5))

% Resposta em frequência
figure(2)
clear h w
[h, w] = freqs(bsn,asn, logspace(1, 5, 10000));
semilogx(w, 20*log10(abs(h)))
grid on
hold on

%% Transformação de frequência Lowpass para Highpass
wp = 1000; ws = 500;
ap = a4; bp = b4; %% Eliptico
syms p;
Np(p) = poly2sym(bp, p);
Dp(p) = poly2sym(ap, p);
Hp(p) = Np(p) / Dp(p);
pretty(vpa(collect(Hp(p)), 5))

% transformação de frequência
syms s;
Hs(s) = collect(subs(Hp(p), wp/s));
[N, D] = numden(Hs(s));
pretty(vpa(Hs(s), 3))

% Normalizando de acordo com p^n
bs = sym2poly(N);
as = sym2poly(D);
an = as(1);
bsn = bs/an;
asn = as/an;
Hsn(s) = poly2sym(bsn, s)/poly2sym(asn, s);
pretty(vpa(Hsn(s), 5))

% Resposta em frequência
figure(2)
clear h w
[h, w] = freqs(bsn,asn, logspace(1, 5, 10000));
semilogx(w, 20*log10(abs(h)))

legend(['Lowpass'],['Highpass']);