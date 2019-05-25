%% Exemplo filtro passa_baixa digital

clear all;
close all;
clc;

fp = 941; fs =1209;
Ap = 1; As = 20;
fa = 8000;
ws = 2*pi*fs;
wp = 2*pi*fp;
wa = 2*pi*fa;

thetas = ws /(wa/2);
thetap = wp /(wa/2);

lambdas = 2*tan(thetas * pi/2);
lambdap = 2*tan(thetap * pi/2);

%% Utlilizando
Os = lambdas/lambdap;
Op = 1;

[n,Wn] = buttord(Op,Os,Ap,As,'s');
[b,a] = butter(n,Wn,'s');


