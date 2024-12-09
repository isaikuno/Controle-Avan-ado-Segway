clc
clear
close all

%% Define model parameters
mc = 1.5; % mass of the cart
mp = 0.5; % mass of the pendulum
g = 9.82; % gravity
L = 1;    % length of the pendulum
d1 = 1e-2;  % damping of the cart displacement
d2 = 1e-2; % damping of the joint

%% Define matrices of dynamic model
A = [0,   0,   1,    0;
     0,   0,   0,    1;
     0,   g*mp/mc,   -d1/mc, -d2/(L*mc);
     0,   g*(mc+mp)/(L*mc),  -d1/(L*mc), -d2*(mc+mp)/(L^2*mc*mp)];
 
 B = [ 0; 0; 1/mc;  1/(L*mc)];
 
 C = [0 1 0 0];
     
 D = 0;
 
 % Build system
 sys  = ss(A,B,C,D)
 rlocus(sys)
 
% Controller
%  des_poles = 2*[-1, -1, -1, -1];
%  K=acker(A,B,des_poles)
%  eig(A-B*K)
 Q=20*eye(4);
 R=8;
 K_lqr2=lqr(A,B,Q,R);
 eig(A-B*K_lqr2)
 %K_lqr =  -14.1421  171.8846  -25.2787   54.7535
 
 