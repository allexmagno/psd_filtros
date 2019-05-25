a = [1:30]      %vetor

a(22) = 40      %atribuir valor a um ponto

b = 0.1

%format long
b
%format hex
b
format short

a(10,10) = 3;

c = [2 3; 4 5];
d = [5 0];      %matriz

d*c

d'              %matriz transposta

comlex = 3 + 4j

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clear all;

h = [1 : 10];
d = 1;
d(100) = 0;

d(15) = 10;

b = h;
x= d;
y = filter(b,1,x);

stem (y, d);

