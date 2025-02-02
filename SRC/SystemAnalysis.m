clear;

mc = 1.5;
mp = 0.5;
g = 9.82;
L = 1;
d1 = 0.01;
d2 = d1;

A = [0     0               1                 0
     0     0               0                 1
     0   g*mp/mc        -d1/mc           -d2/(L*mc)
     0 (g*(mc+mp)/(L*mc)) (-d1/(L*mc)) (-d2*(mc+mp)/(L^2*mc*mp))];

B = [0 0 1/mc 1/(L*mc)]';

C = zeros(4);
C(end,end) = 1;
D = zeros(4,1);

sys = ss(A,B,C,D)
polos = pole(sys)
autovalores = eig(sys)
zeros = zero(sys)

% Não é estável pois tem um polo positivo

[num,denom] = ss2tf(A,B,C,D)


