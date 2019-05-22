% Projeto
As = 40;
Ap = 3;
wp = 1e3;
ws = 2e3;
Wp = 1;
Ws = ws/wp;
Rs = As;
Rp = Ap;

[n, Wn] = cheb1ord(Wp, Ws, Rp, Rs, 's') % fornece a ordem e o coeficiente da funcao de transf
[b, a] = cheby1(n, Rp,  Wp, 's');

[h, w] = freqs(b, a, logspace(-2, 2, 1000));
semilogx(w, 20*log10(abs(h)));
legend('chebyshev filter')
grid on
hold on