syms s;
%digits(20); % usando essa funcao, nao eh necessario usar o 10 na funcao
             % vpa
a = [1 2 3 4 5 6 1]
%a = [0.33 0.9342 0.2323 1/3 5.34 6 1]*pi;
Ds(s) = poly2sym(a,'s');
pretty(Ds)
%pretty(vpa(Ds,10)) % vpa faz com que voce mostre qts casas significativas quiser

Ds([0 1 2 3]) % Dando valores para s

as = sym2poly(Ds)