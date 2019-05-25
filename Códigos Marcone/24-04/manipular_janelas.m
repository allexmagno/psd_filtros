clear all;
close all;
clc;

%% Hamming
figure(1)
hold on
w1 = hamming(32);
w2 = hamming(64);
title('Janelas Hamming');
stem(w1);grid minor;
stem(w2);legend('32','64');
hold off
wvtool(w1,w2);

%% Rectwin
figure(3)
hold on
w1 = rectwin(32);
w2 = rectwin(64);
title('Janelas Hamming');
stem(w1);grid minor;
stem(w2);legend('32','64');
hold off
wvtool(w1,w2);
