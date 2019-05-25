%clear all; 
close all; 
clc;

Ap = 1; %ganho de passagem em dB
As = 20; %atenuação no stopband em dB

f0 = 1000; %hertz
Bh = 1; %hertz

Qfp1 = [ 1 -Bh -f0^2];
roots(Qfp1)
Qfp2 = [ 1 +Bh -f0^2];
roots(Qfp2)

fp2 = 1000.5; fp1 = 995.5; %banda de passagem em Hz
fs2 = 1010; fs1 = 990; %banda de stop em Hz

bh = fp2-fp1;
f0 = sqrt(fp1*fp2);

% substituindo de Hz para ômega
wp1 = 2*pi*fp1;
wp2 = 2*pi*fp2;
ws1 = 2*pi*fs1;
ws2 = 2*pi*fs2;

w0 = 2*pi*f0;
Bw = 2*pi*Bh;

Os1 = abs(w0^2 - ws1^2)/(Bw*ws1);
Os2 = abs(w0^2 - ws2^2)/(Bw*ws2);
Os = min(Os2,Os1);
Op = 1;

%% Butterworth
[n1,Wn] = buttord(Op,Os,Ap,As,'s');
[b1,a1] = butter(n1,Wn,'s');
[b2,a2] = butter(n1,1,'s');

%% Plot
figure(1)
[h1,w1] = freqs(b1,a1,logspace(-2,1,1000));
semilogx(w1,20*log10(abs(h1)))
hold on; grid on;
[h1,w1] = freqs(b2,a2,logspace(-2,1,1000));
semilogx(w1,20*log10(abs(h1)))

%% Transformação de frequência Lowpass para Bandpass
ap = a1; bp = b1; %% Butterworth
syms p;
Np(p) = poly2sym(bp, p);
Dp(p) = poly2sym(ap, p);
Hp(p) = Np(p) / Dp(p);
pretty(vpa(collect(Hp(p)), 5))

% transformação de frequência
syms s;
Hs(s) = collect(subs(Hp(p), (s^2 + w0^2)/(Bw*s)));
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
fmax = 2000; Gmin = -40; Gmax = 5;
[h, w] = freqs(bsn,asn, linspace(990*2*pi, 1010*2*pi, 10000));
plot(w/2/pi, 20*log10(abs(h))); grid minor; ylim([Gmin Gmax]);
grid on; hold on;
plot([0 fs1 fs1 fs2 fs2 fmax],[-As -As 0 0 -As -As] ,':r' );
plot([fp1 fp1 fp2 fp2],[Gmin -Ap -Ap Gmin] ,':r' );