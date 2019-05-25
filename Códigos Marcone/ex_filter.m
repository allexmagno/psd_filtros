%%%%%%%%%%%%%%%%%%%%%%%%% 15.02 %%%%%%%%%%%%%%%%%%%%%%%%%
% Entrando no doc filter(p.e.) e querendo executar um exemplo:
% - Selecionar as linhas que deseja executar e apertar F9

% linspace -> escaka linear
% logspace -> escala logaritmica

% SINAL DE ENTRADA x[n]
t = linspace(-pi,pi,100);
rng default % controla a gera?ao dos numeros randomicos
x1 = sin(t);
x2 = 0.25*rand(size(t));
x = x1 + x2;

%plot(t,x)
%hold on % para que o plote anterior continue na janela

%plot(t,x1,t,x2,t,x) % faz com que nao precise do hold on, plota todos
                    % os graficos na mesma janela
                    
plot(t,x1,t,x2,t,x,':k')

%% FILTRO MEDIA MOVEL
windowSize = 0.55556; % selecionando o numero, clicando com o botao direito
                      % e clicando em increment value and run section
windowSize = ceil(windowSize); % caso o valor seja quebrado, ele arredonda
b = (1/windowSize)*ones(1,windowSize);
a = 1;
y = filter(b,a,x);

% Plots:
plot(t,x)
hold on
plot(t,y)

grid on
legend('Input Data','Filtered Data','Location','NorthWest')
title('Plot of Input and Filtered Data')
hold off