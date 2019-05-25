wp = 0.4*pi; ws = 0.6*pi; % spec
Dw = ws - wp;
As = 50;
betha = 0.5842*(As-21)^0.4 + 0.07886*(As-21);
N = ceil((As - 8)/(2.285*Dw)+1);
wkeiser = kaiser(N, betha);

%%
w0 = kaiser(100, 0);
w1 = kaiser(100, 2.5);
w2 = kaiser(100, 4);
w3 = kaiser(100, 30);
wvtool(w0, w1, w2, w3)
