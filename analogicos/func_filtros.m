%% Projeto de filtro passa-baixas usando fun??es do Matlab  
%% Especifica??es do filtro 
wp =1000; ws = 20000; Ap = 3; As = 40; G0= 0; % LP
%wp =1000; ws = 500; Ap = 3; As = 40; G0= 0; % Ws = wp/ws LP
Wp = 1; Ws = ws/wp;

% Para analisar o filtro projetado, use fvtool(b,a) para observar plano s, resposta em magnitude, fase e atraso de grupo
 
%% Butterworth
[n1,Wn] = buttord(Wp, Ws, Ap, As,'s')
[b1,a1] = butter(n1,Wn, 's');
 
%% Chebyshev I
n2 = cheb1ord(Wp, Ws, Ap, As,'s')
[b2,a2] = cheby1(n2,Ap, Wp, 's');
 
%% Chebyshev II
n3 = cheb2ord(Wp, Ws, Ap, As,'s')
[b3,a3] = cheby2(n3,As, Ws, 's');
 
%% Elliptic - Cauer
[n4, Wn] = ellipord(Wp, Ws, Ap, As,'s')
[b4,a4] = ellip(n4,Ap,As, Wn, 's');

%% plotando
figure(1)
subplot(221)
[h1, w] = freqs(b1 ,a1, logspace(-2, 2, 10000));
semilogx(w, 20*log10(abs(h1)))
grid on
hold on
[h2, w] = freqs(b2 ,a2, logspace(-2, 2, 10000));
semilogx(w, 20*log10(abs(h2)))
[h3, w] = freqs(b3 ,a3, logspace(-2, 2, 10000));
semilogx(w, 20*log10(abs(h3)))
[h4, w] = freqs(b4 ,a4, logspace(-2, 2, 10000));
semilogx(w, 20*log10(abs(h4)))
hold off
% legend(['Butterworth n='num2str(n1)], ...
%     ['Chebyshev2 n='num2str(n2)],...
%     ['Chebyshev2 n='num2str(n3)], ...
%     ['Eliptico n='num2str(n4)]);
    
subplot(223)
semilogx(w, unwrap(angle(h1)))
grid on
hold on
semilogx(w, unwrap(angle(h2)))
semilogx(w, unwrap(angle(h3)))
semilogx(w, unwrap(angle(h4)))
hold off


subplot(2,2,[2,4])
plot(real(roots(b1)), imag(roots(b1)),'o', real(roots(a1)), imag(roots(a1)), 'x')
grid on
hold on
plot(real(roots(b2)), imag(roots(b2)),'o', real(roots(a2)), imag(roots(a2)), 'x')
plot(real(roots(b3)), imag(roots(b3)),'o', real(roots(a3)), imag(roots(a3)), 'x')
plot(real(roots(b4)), imag(roots(b4)),'o', real(roots(a4)), imag(roots(a4)), 'x')
max = 4;
axis([-1.1 1.1 -1.1 1.1]*max); axis square
hold off

%% Transforma??o de freq
%LP to LP

ap = a4, bp = b4; % Butterworh
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

%% Resposta em frequencia

clear h w
[h, w] = freqs(bsn, asn, logspace(1, 6, 1000));
%hold on
semilogx(w, 20*log10(abs(h)));
grid on
hold on

%% Transforma??o de freq
%LP to HP
wp = 1e3; ws = 500;
ap = a4, bp = b4; % Butterworh
syms p
Np(p) = poly2sym(bp, p);
Dp(p) = poly2sym(ap, p);
Hp(p) = Np(p)/Dp(p);
pretty(vpa(collect(Hp(p)), 5))

%
syms s
Hs(s) = collect(subs(Hp(p), wp/s));
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
semilogx(w, 20*log10(abs(h)));
grid on
hold on
