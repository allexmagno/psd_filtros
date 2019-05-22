clear all;
close all;
clc;

figure(1)
%% Filtro PB
fp = 941; fs = 1209; fa = 8e3; %Hz 
Ap = 1; As = 20; %dB 
fN = fa/2;
Wp = fp/fN;
Ws = fs/fN;
[n, Wn] = buttord(Wp, Ws, Ap, As);
[b, a] = butter(n, Wn);
[h w] = freqz(b, a);
subplot(511)
plot(w/pi*fN, 20*log10(abs(h)))
ylim([-80 10])
grid on

%% Filtro PA
fs = 941; fp = 1209; fa = 8e3; %Hz 
Ap = 1; As = 20; %dB 
fN = fa/2;
Wp = fp/fN;
Ws = fs/fN;
[n, Wn] = buttord(Wp, Ws, Ap, As);
[b, a] = butter(n, Wn, 'high');
[h w] = freqz(b, a);
subplot(512)
plot(w/pi*fN, 20*log10(abs(h)))
ylim([-80 10])
grid on

%% Filtro PF

fp1 = 811; fp2 = 895; fs1 = 770; fs2 = 941;  fa = 8e3; %Hz 
Ap = 1; As = 20; %dB 
fN = fa/2;
Wp = [fp1 fp2]/fN;
Ws = [fs1 fs2]/fN;
[n, Wn] = buttord(Wp, Ws, Ap, As);
[b, a] = butter(n, Wn, 'bandpass');
[h w] = freqz(b, a);
subplot(513)
plot(w/pi*fN, 20*log10(abs(h)))
ylim([-80 10])
grid on

%% Filtro RF 2.1

fp1 = 58; fp2 = 62; fs1 = 53; fs2 = 67;  fa = 200; %Hz 
Ap = 1; As = 30; %dB 
fN = fa/2;
Wp = [fp1 fp2]/fN;
Ws = [fs1 fs2]/fN;
[n, Wn] = buttord(Wp, Ws, Ap, As);
[b, a] = butter(n, Wn, 'stop');
[h w] = freqz(b, a);
subplot(527)
plot(w/pi*fN, 20*log10(abs(h)))
ylim([-80 10])
xlim([0 80])
grid on
subplot(528)
zplane(b,a)

%% Filtro RF 2.2 - iirnotch
fp1 = 58; fp2 = 62; fs1 = 53; fs2 = 67;  fa = 200; %Hz 
Ap = 1; As = 30; %dB 
fN = fa/2;
wo = 60/fN;  bw = 4/fN;
[b,a] = iirnotch(wo,bw);
[h w] = freqz(b, a);
subplot(529)
plot(w/pi*fN, 20*log10(abs(h)))
grid on
ylim([-80 10])
xlim([0 80])
subplot(5,2,10)
zplane(b,a);
grid on
fvtool(b,a);
syms z;
N(z) = poly2sym(b, z);
D(z) = poly2sym(a, z);
H(z) = N(z)/D(z);
pretty(vpa(collect(H(z)),5))
%% Filtro iirpeak
[b a] = iirpeak(wo, bw)
fvtool(b,a);

%% iircomb - notch (Rejeita varias freq)
fa = 8e3; fo = 0.5e3; fN = fa/2; bw = 20/fN; 
[b,a] = iircomb(fa/fo,bw,'notch'); % Note type flag 'notch'
fvtool(b,a);
syms z;
N(z) = poly2sym(b,z);
D(z) = poly2sym(a,z);
H(z) = N(z)/D(z);
pretty(vpa(H(z),3))
zplane(b, a)
%% iircomb - peak (passa varias freq)
fa = 8e3; fo = 0.5e3; fN = fa/2; bw = 20/fN; 
[b,a] = iircomb(fa/fo,bw,'peak'); % Note type flag 'notch'
fvtool(b,a);
syms z;
N(z) = poly2sym(b,z);
D(z) = poly2sym(a,z);
H(z) = N(z)/D(z);
pretty(vpa(H(z),3))
zplane(b, a)