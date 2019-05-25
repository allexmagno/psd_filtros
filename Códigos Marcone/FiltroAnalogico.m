close all
clc 

%b = [1 1];
%a = [1 1 5];
b = 1;
a1 = [1 0.5176 1]; a2 = [1 1.414 1]; a3 = [1 1.9318 1];
a = conv(a3,conv(a1,a2));
[z1,p1,k] = tf2zp(b,a)
z2 = roots(b);
p2 = roots(a);
zplane(b,a);
%%
[h,w] = freqs(b,a,logspace(-1 ,3 , 5000))
semilogx(w,20*log10(abs(h)))
grid on;
%%
syms s  w
H(s) = (s+1)/(s^2 + s + 5);
pretty(H(1j*w))
latex(H(1j*w))
%%
ws = logspace(-2, 2, 5000); %vetor de 0,01 a 10 com 1000 valores distribuidos em escala logaritmica
h = H(1j*ws);
subplot(211)
semilogx(ws/2/pi,abs(h)); grid on; %eixo x logaritmico 
subplot(212)
semilogx(ws/2/pi,angle(h)/pi*180); grid on; %ws/2/pi = escala em Hz