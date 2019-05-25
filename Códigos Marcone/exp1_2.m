%  Exemplos e Experimentos baseados no livro:
% DINIZ, P. S. R., DA SILVA, E. A. B., e LIMA NETTO, S. Processamento Digital de Sinais: Projeto e An?lise de Sistemas. 2. ed. Porto Alegre: Bookman, 2014. 976 p. ISBN 978-8582601235.
%% Experimento 1.2
fs = 10; % frequencia (Hz) de amostragem dos sinais, preferencialmente sempre maior que o dobro
Ts = 1/fs; fase = 0;
%fase = pi/3;
A1 = 1; % amplitude do sinal cos
time = 0:Ts:(1-Ts);% utiliza 1-Ts para preservar a quantidade de amostras
f1 = 3; % frequencia (Hz) do sinal s_1
f2 = 7; % frequencia (Hz) do sinal s_2
s_1 = A1*cos(2*pi*f1*time+fase); % utilizado escala de hertz
s_2 = cos(2*pi*f2*time+fase);
fsa = 1000; % frequ?ncia auxiliar de amostragem usada apenas para representa??o dos sinais originais
Tsa = 1/fsa;
time_aux = 0:Tsa:(1-Tsa);
figure(1);
stem(time,s_1,'ob');
hold on; % retem o plot para novos plots, nao sobrescreve
plot(time_aux, A1*cos(2*pi*f1*time_aux+fase),'--k');
stem(time,s_2,'+r');
plot(time_aux, cos(2*pi*f2*time_aux+fase),'--m');
hold off;
legend('s_1 discreto','s_1 cont?nuo','s_2 discreto','s_{23} cont?nuo')