clear all;
clc;

syms C1 C2 R1 R2 Vi Vo Z Z1 Z2 Z3 Z4 w;

Z1 = 1/(j * w * C1);
Z2 = R1;
Z3 = R2;
Z4 = 1/(j * w * C2);

Z_AB = Z1 + (1/Z2 + 1/(Z3 + Z4))^-1;
Vo_AB = Vi - Vi/Z_AB * Z1 - Z3 * ((Vi - Vi/Z_AB * Z1)/(Z3 + Z4));

Z_BA = Z3 + (1/Z4 + 1/(Z1 + Z2))^-1;
Vo_BA = Vi - Vi/Z_BA * Z3 - Z1 * ((Vi - Vi/Z_BA * Z3)/(Z1 + Z2));

Phs_AB = angle(Vo_AB);
H_AB = Vo_AB/Vi;

Phs_BA = angle(Vo_BA);
H_BA = Vo_BA/Vi;

Function_Vo_AB = matlabFunction(Vo_AB);
Function_Phs_AB = matlabFunction(Phs_AB);
Function_H_AB = matlabFunction(H_AB);

Function_Vo_BA = matlabFunction(Vo_BA);
Function_Phs_BA = matlabFunction(Phs_BA);
Function_H_BA = matlabFunction(H_BA);

f = 0:100:10^8;
y_Vo_AB = real(Function_Vo_AB(12.35*10^-9, 13.65*10^-9, 350, 350, 2, 2.*pi.*f));
y_H_AB = real(Function_H_AB(12.35*10^-9, 13.65*10^-9, 350, 350, 2, 2.*pi.*f));
y_Phs_AB = Function_Phs_AB(12.35*10^-9, 13.65*10^-9, 350, 350, 2, 2.*pi.*f);

y_Vo_BA = real(Function_Vo_BA(12.35*10^-9, 13.65*10^-9, 350, 350, 2, 2.*pi.*f));
y_H_BA = real(Function_H_BA(12.35*10^-9, 13.65*10^-9, 350, 350, 2, 2.*pi.*f));
y_Phs_BA = Function_Phs_BA(12.35*10^-9, 13.65*10^-9, 350, 350, 2, 2.*pi.*f);
