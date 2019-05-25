%% Projeto filtro Chebyshev
clear all;
close all;
clc

W = [0.01:0.01:10];

%Polinomios de Chebyshev
C0 = [1];
C1 = [1 0];
C2 = [2 0 -1]; 
C3 = [4 0 -3 0];
C4 = [8 0 -8 0 1];
C5 = [16 0 -20 0 5 0];

%raizes do polinomio
p1 = roots(C1);
p2 = roots(C2);
p3 = roots(C3);
p4 = roots(C4);
p5 = roots(C5);

%polinomios ao quadrado
C0_2 = conv(C0,C0);
C1_2 = conv(C1,C1);
C2_2 = conv(C2,C2);
C3_2 = conv(C3,C3);
C4_2 = conv(C4,C4);
C5_2 = conv(C5,C5);

%Para Ap = 3dB E = 1;
As = 40;
Ap = 3.01;
wp = 1000;
ws = 2000;
Ws = ws/wp;

E = sqrt(10^(0.1*Ap)-1);

n = (acosh(sqrt((10^(0.1*As)-1)/(10^(0.1*Ap)-1)))/acosh(Ws)) % 4,02
n = ceil(n); % obtem o proximo valor inteiro de n

k = 1:n;
fi2 = 1/n*asinh(1/E);
tk = (2*k-1)*pi/(2*n);
pk = -sinh(fi2)*sin(tk)+1j*cosh(fi2)*cos(tk);

figure(2)
plot(real(pk),imag(pk),'x');axis([-1.1 1.1 -1.1 1.1]); grid minor;
figure(3)
%zplane(1,poly(pk));grid minor;

dp = real(poly(pk));
%d0 = real(prod(-pk)) %duas formas de encontrar d0
d0 = dp(end);

%verificar se H0 e par ou impar
if mod(n,2) == 1    %H0 impar
    H0 = d0;     
else    %H0 par
   H0 = d0*(sqrt(1/ (1+E^2)));
end 

syms p;
Dp(p) = poly2sym(dp, p);
Hp(p) = H0 / Dp(p);
pretty(vpa(collect(Hp(p)), 5))

figure(3)
[h,w] = freqs(d0,dp,logspace(-2,2,1000));
semilogx(w,20*log10(abs(h)))


%%
figure(1)
hold on;
% ------------------------ Para n par --------------
H0p = 1/(E^2 + 1); %modulo de H0 ao quadrado

% n = 2
%h2w = H0p^2/(1+E^2*C2_2);
H2w = 1./(1+(4*W.^4-4*W.^2 + 1));
semilogx(W,10*log10(H2w)); grid minor; % plotar em dB

% n = 4
%h2w = H0p^2/(1+E^2*C4_2);
H2w = 1./(1+(64*W.^8 - 128*W.^6 + 80*W.^4 -16*W.^2 + 1));
semilogx(W,10*log10(H2w)); grid minor; % plotar em dB

% ----------------------- Para n impar ----------------
H0i = 1;    %modulo de H0 ao quadrado

% n = 1
%h2w = H0i^2/(1+E^2*C1_2);
H2w = 1./(1+(1*W.^2));
semilogx(W,10*log10(H2w)); grid minor; % plotar em dB

% n = 3
%h2w = H0i^2/(1+E^2*C3_2);
H2w = 1./(1+(16*W.^6 - 24*W.^4 + 9*W.^2));
semilogx(W,10*log10(H2w)); grid minor; % plotar em dB

% n = 5
%h2w = H0i^2/(1+E^2*C5_2);
H2w = 1./(1+(256*W.^10 - 640*W.^8 + 560*W.^6 - 200*W.^4 + 25*W.^2));
semilogx(W,10*log10(H2w)); grid minor; % plotar em dB

hold off;



