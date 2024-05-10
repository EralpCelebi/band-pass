% Eralp Çelebi <eralp.celebi.personal@gmail.com>

clear all;
clc;

syms C1 C2 R1 R2 Vi Vo Z Z1 Z2 Z3 Z4 w f;
w = 2*pi*f;

Z1 = 1/(j * w * C1);
Z2 = R1;
Z3 = R2;
Z4 = 1/(j * w * C2);

Z = Z1 + (1/Z2 + 1/(Z3 + Z4))^-1;

Vo = Vi - Vi/Z * Z1 - Z3 * ((Vi - Vi/Z * Z1)/(Z3 + Z4));
H = Vo/Vi;

Function_Vo = matlabFunction(Vo);
Function_H = matlabFunction(H);