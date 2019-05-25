clear all;
close all;
clc;

fsamp = 8000;
As = 50; Ap = 1;

fcuts = [1600 2400]; % valores de acordo com o exemplo passado (aula_20_nova_janela.m)
w = fcuts/8000*(2*pi);
wp = w(1)/pi; ws = w(2)/pi;
mags = [1 0];
devs = [1-10^(-Ap/20) 10^(-As/20)];
[n,Wn,beta,ftype] = kaiserord(fcuts,mags,devs,fsamp);
Ge = 0;
N1 = n;

% primeiro ajuste de ganho
    G2 = -0.0235; %correção do ganho 
% secundo ajuste, largura da transição
    fcuts2 = [1778 2394];
    N2 = ceil(N1*(fcuts2(2) - fcuts2(1))/(fcuts(2) - fcuts(1)));
    n = N2;
% terceiro ajuste, frequência de corte
    fcuts3 = [1722 2488];
    df3= fcuts - fcuts3;
    delta3 = sum(df3)/2;
    Wn = Wn + delta3/(fsamp/2);

h_fir = fir1(n,Wn,ftype,kaiser(n+1,beta),'noscale');
h_fir = h_fir*10^(Ge/20);
[Hw,w] =freqz(h_fir,1,10000);
plot(w*fsamp/2/pi,20*log10(abs(Hw)));ylim([-80 5]);grid minor;
title_txt = ['Kaiser filter N = ' num2str(n)];
title(title_txt)
%fvtool(h_fir,1)
hold on
plot([0,wp,wp]*fsamp/2,[-Ap,-Ap,-80], '-red')
plot([0,ws,ws,1]*fsamp/2,[0,0,-As,-As], '-red')
%hold off

%% [n,fo,ao,w] = firpmord(f,a,dev)
devs = [1-10^(-Ap/2/20) 10^(-As/20)];
% ajuste do ganho na banda de passagem
devs = [1-10^((-Ap/2+0.166)/20) 10^((-As-3.08764)/20)];

G0 = Ap/2;
[n,f0,a0,w0]= firpmord(fcuts,mags,devs,fsamp);
h_pm = firpm(n,f0,a0,w0);
h_pm = h_pm * 10^(-G0/20);
clear Hw w;
[Hw,w] =freqz(h_pm,1,10000);
plot(w*fsamp/2/pi,20*log10(abs(Hw)));
title_txt = [title_txt,[' - PM filter N = ' num2str(n)]];
title(title_txt)

