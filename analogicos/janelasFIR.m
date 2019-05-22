clear all;
close all
clc
%%
M = 16;
k = -M:M;

janela = 'bartlett'
switch janela
    case 'retangular'
        wk = ones(size(k));
        %subplot(311)
        
    case 'bartlett'
        wk = 1-abs(k)/(M+1);
        %subplot(312)
        
    case 'hamming'
        wk = 0.54+0.46*cos(2*pi*k/(2*M+1));
        %subplot(313)
        
end
stem(wk)
%hold on