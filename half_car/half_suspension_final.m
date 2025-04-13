clear;
close all;
clc;

% Define system parameters
% distance from cg in metre, mass in kg, moment of inertia in kgm^2, spring stiffness in N/m, damping coefficient in Ns/m

 a  = 1.1;
 b  = 1.5;
 d  = 0.25;   
 
 Mf = 25;        % Unsprung mass 1: Front Wheel and Axle
 Mb = 25;        % Unsprung mass 1: Back Wheel and Axle
 Mc = 1080;      % Sprung mass 1: Chassis
 Ic = 210000;    % Body moment of inertia: Chassis
 Ms = 100;       % Sprung mass 2: Seat and driver
 
 
 k1 = 25000;     % Spring stiffness (front tyre)
 k3 = 25000;     % Spring stiffness (back tyre)
 k2 = 15000;     % Spring stiffness (chassis-front wheel)
 k4 = 15000;     % Spring stiffness (chassis-back wheel)
 k5 = 8000;      % Spring stiffness (seat-chassis)
 
 c1 = 3700;      % Damper coefficient (chassis-wheel)
 c2 = 3700;      % Damper coefficient (chassis-wheel)
 c3 = 1000;      % Damper coefficient (seat-chassis)
 c4 = 500;       % Damper coefficient (seat back friction)




A = [0            0           0                     0                           0           1           0                     0                                  0                                  0               ;
     0            0           0                     0                           0           0           1                     0                                  0                                  0               ;
     0            0           0                     0                           0           0           0                     1                                  0                                  0               ;
     0            0           0                     0                           0           0           0                     0                                  1                                  0               ;
     0            0           0                     0                           0           0           0                     0                                  0                                  1               ;
     -(k1+k2)/Mf  0           k2/Mf                 (a*k2)/Mf                   0           -c1/Mf      0                     c1/Mf                              (a*c1)/Mf                          0               ;
     0            -(k3+k4)/Mb k4/Mb                 (-b*k4)/Mb                  0           0           -c2/Mb                c2/Mb                              (-b*c2)/Mb                         0               ; 
     k2/Mc        k4/Mc       -(k2+k4+k5)/Mc        (-a*k2+b*k4+d*k5)/Mc        k5/Mc       c1/Mc       c2/Mc                 -(c1+c2+c3+c4)/Mc                  (-a*c1+b*c2+d*c3+d*c4)/Mc          (c3+c4)/Mc      ;
     (a*k2)/Ic    (-b*k4)/Ic  (-a*k2+b*k4+d*k5)/Ic  -(a^2*k2+b^2*k4-d^2*k5)/Ic  (-d*k5)/Ic  (a*c1)/Ic   (-b*c2)/Ic            (-a*c1+b*c2+d*c3+d*c4)/Ic          -(a^2*c1+b^2*c2-d^2*c3-d^2*c4)/Ic  -(d*c3+d*c4)/Ic ;
     0            0           k5/Ms                 (d*k5)/Ms                   -k5/Ms      0           0                     (c3+c4)/Ms                         (d*c3+d*c4)/Ms                     -(c3+c4)/Ms]    ;


B =[0      0       ;
    0      0       ;
    0      0       ;
    0      0       ;
    0      0       ;
    k1/Mf  0       ;
    0     k3/Mb    ;
    0      0       ;
    0      0       ;
    0      0       ];
 

C = [0 0 1 0 0 0 0 0 0 0;
     0 0 0 1 0 0 0 0 0 0;
     0 0 0 0 1 0 0 0 0 0];
     

D= [0 0;
    0 0;
    0 0];

sys = ss(A, B, C, D);

step(sys);