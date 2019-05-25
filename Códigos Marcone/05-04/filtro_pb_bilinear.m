%%
close all;
clear all;
clc;

%% Passa baixa
fp = 941; fs = 1209;
Ap = 1; As = 20;

fa = 8000;

ws = 2*pi*fs;
wp = 2*pi*fp;
wa = fa * 2 * pi;

tetha_s = ws/(wa/2);
tetha_p = wp/(wa/2);

% nao pode ser muito perto de 1
% ver frequencia de amostragem
lambda_s = 2*tan(tetha_s * pi/2);
lambda_p = 2*tan(tetha_p * pi/2);

Os = lambda_s/lambda_p;
Op = 1;

[n1, Wn] = buttord(Op, Os, Ap, As, 's');
% n1 = 2;
[b,a] = butter(n1,Wn,'s');

[h, w] = freqs(b,a,logspace(-2, 1, 10000));

% Plotando centrado em 0
semilogx(w, 20*log10(abs(h)))
ylim([-80 10])
title('H(p)')
hold on
grid on
plot([10^-2,Os,Os,10^1],[0,0,-As,-As], 'r')
plot([10^-2,1,1],[-Ap,-Ap,-80], 'r')

syms p;
Np(p) = poly2sym(b,p);
Dp(p) = poly2sym(a,p);
Hp(p) = Np(p)/Dp(p);
pretty(vpa(collect(Hp(p)),5))

syms s;
Hs(s) = collect(subs(Hp(p), s/lambda_p));
pretty(vpa(Hs(s),3))
Hsc(s) = (Hs(s));
[N,D] = numden(Hsc(s));

bs = sym2poly(N);
as = sym2poly(D);

an = as(1);
bsn = bs/an;
asn = as/an;

Hsn(s) = poly2sym(bsn,s) / poly2sym(asn,s);
pretty(vpa(Hsn(s),5))

clear h w
figure(2)
[h,w] = freqs(bsn,asn,linspace(0,10,1000));
plot(w,20*log10(abs(h)));
ylim([-80 10])
title('H(s)')
grid on
hold on
% Fazer a mascara em cima do LAMBDA
plot([0,lambda_s,lambda_s,2],[0,0,-As,-As], 'r')
plot([0,lambda_p,lambda_p],[-Ap,-Ap,-80], 'r')

syms z;
aux = 2*((z-1)/(z+1));
Hz(z) = collect(subs(Hs(s), aux));
pretty(vpa(Hz(z),3))

[Nz,Dz] = numden(Hz(z));
bz = sym2poly(Nz);
az = sym2poly(Dz);

an = az(1);
bzn = bz/an;
azn = az/an;

Hzn(z) = poly2sym(bzn,z) / poly2sym(azn,z);
pretty(vpa(Hzn(z),5))

figure(3)
subplot(121)
[hz, wz] = freqz(bzn, azn, linspace(0, pi, 1000));
plot(wz/pi*fa/2, 20*log10(abs(hz)));
ylim([-80 10])
title('H(z)')
grid on
hold on
plot([0,fs,fs,2000],[0,0,-As,-As], 'r')
plot([0,fp,fp,],[-Ap,-Ap,-80], 'r')

subplot(122)
zplane(bzn, azn);