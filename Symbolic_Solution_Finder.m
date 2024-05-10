% Eralp Çelebi <eralp.celebi.personal@gmail.com>

clear all;
clc;

syms C1 C2 R1 R2 Vi Vo Z Z1 Z2 Z3 Z4 w;

Z1 = 1/(j * w * C1);
Z2 = R1;
Z3 = R2;
Z4 = 1/(j * w * C2);

Z = Z1 + (1/Z2 + 1/(Z3 + Z4))^-1;

Vo = Vi - Vi/Z * Z1 - Z3 * ((Vi - Vi/Z * Z1)/(Z3 + Z4));
Phs = angle(Vo);
H = Vo/Vi;

Function_Vo = matlabFunction(Vo);
Function_Phs = matlabFunction(Phs);
Function_H = matlabFunction(H);

f = 0:100:10^8;
y_Vo = real(Function_Vo(12.35*10^-9, 13.65*10^-9, 350, 350, 2, 2.*pi.*f));
y_H = real(Function_H(12.35*10^-9, 13.65*10^-9, 350, 350, 2, 2.*pi.*f));
y_Phs = Function_Phs(12.35*10^-9, 13.65*10^-9, 350, 350, 2, 2.*pi.*f);
