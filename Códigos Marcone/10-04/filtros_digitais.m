clear all;
close all;
clc;

%% Filtro passa baixa

fp = 941;
fs = 1209;
fa = 8000;
fN = fa/2;
Ap =1;
As = 20;

Wp = fp/fN;
Ws = fs/fN;

[n,Wn] = buttord(Wp,Ws,Ap,As);  % usa essa função para calcular a ordem do filtro
%[b,a] = butter(6,fp/(fa/2));   %especifica uma ordem aleatória para fazer o filtro
[b,a] = butter(n,Wn);
[h,w] = freqz(b,a);
plot(w/pi*fN, 20*log10(abs(h))); ylim([-80 15]); grid on;

%% Filtro passa alta

fs = 941; %stop
fp = 1209;  %pass
fa = 8000;
fN = fa/2;
Ap =1;
As = 20;

Wp = fp/fN;
Ws = fs/fN;

[n,Wn] = buttord(Wp,Ws,Ap,As);  % usa essa função para calcular a ordem do filtro
%[b,a] = butter(6,fp/(fa/2));   %especifica uma ordem aleatória para fazer o filtro
[b,a] = butter(n,Wn,'high');
[h,w] = freqz(b,a);
plot(w/pi*fN, 20*log10(abs(h))); ylim([-80 15]); grid on;

%% Filtro passa faixa

fs1 = 770; fs2 = 941; %stop
fp1 = 811; fp2 = 895.5; %pass
fa = 8000;
fN = fa/2;
Ap =1;
As = 20;

Wp = [fp1 fp2]/fN;
Ws = [fs1 fs2]/fN;

[n,Wn] = buttord(Wp,Ws,Ap,As);  % usa essa função para calcular a ordem do filtro
%[b,a] = butter(6,fp/(fa/2));   %especifica uma ordem aleatória para fazer o filtro
[b,a] = butter(n,Wn,'bandpass');
[h,w] = freqz(b,a);
plot(w/pi*fN, 20*log10(abs(h))); grid on; %ylim([-80 15]);

%% Filtro rejeita faixa

fs1 = 53; fs2 = 67; %stop
fp1 = 58; fp2 = 62; %pass
fa = 200;
fN = fa/2;
Ap =1;
As = 30;

Wp = [fp1 fp2]/fN;
Ws = [fs1 fs2]/fN;

[n,Wn] = buttord(Wp,Ws,Ap,As);  % usa essa função para calcular a ordem do filtro
%[b,a] = butter(6,fp/(fa/2));   %especifica uma ordem aleatória para fazer o filtro
[b,a] = butter(n,Wn,'stop');
[h,w] = freqz(b,a,10000);
figure(1)
subplot(121)
plot(w/pi*fN, 20*log10(abs(h))); grid on; xlim([55 65]);ylim([-150 5]);
subplot(122)
zplane(b,a);

%% iirnotch

fa = 200;
fN = fa/2;
wo = 60/fN; 
bw = 4/fN;
[b, a] = iirnotch (wo, bw);
fvtool (b, a);
syms z;
N(z) = poly2sym(b,z);
D(z) = poly2sym(a,z);
H(z) = N(z)/D(z);
pretty(vpa(collect(H(z)),5))

%% iirpeak

fa = 200;
fN = fa/2;
wo = 60/fN; 
bw = 4/fN;
[b, a] = iirpeak (wo, bw);
fvtool (b, a);
syms z;
N(z) = poly2sym(b,z);
D(z) = poly2sym(a,z);
H(z) = N(z)/D(z);
pretty(vpa(collect(H(z)),5))    % 5, casas decimais

%% iircomb

fa = 8000;  
fo = 500;  %frequência central
fN = fa/2;
bw = 20/fN;
[b,a] = iircomb(fa/fo,bw,'notch'); % Note type flag 'notch'
fvtool(b,a);

%% iircomb

fa = 8000;  
fo = 500;  %frequência central
fN = fa/2;
bw = 20/fN;
[b,a] = iircomb(fa/fo,bw,'peak'); % Note type flag 'notch'
fvtool(b,a);

