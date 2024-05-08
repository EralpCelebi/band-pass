% Eralp Çelebi <eralp.celebi.personal@gmail.com>

clear all;
clc;

Options = optimset('TolX',10^-10);

R = [100 200 220 250 330 570 1000 1500];
Fc = (01:99).*1000;

Resolution = 400;
Voltage_Amplitude = 10;

% Component Values.
Results_First = zeros(8, 99);
Results_Second = zeros(8, 99, Resolution);

function Capacitance = Find_Capacitance_From_Freq(Fc, R)
  Capacitance = 1 ./ (2 .* pi .* R .* Fc);
end

% Freq_C * 1/4 -> Freq_C * 4
function Empedances = Find_Empedances_From_Cap(w,C)
  Empedances = -j./(w .* C);
end

for i = 1:99
  % Freq_C = sqrt(Freq_L * Freq_H);
  % Freq_H - Freq_L = 3.5kHz = 0.1*Freq_C;
  % Freq_H = Freq_C^2 / Freq_L;
  % Freq_C^2 / Freq_L - Freq_L = 0.1 *Freq_C;
  % (Freq_C^2 - Freq_L^2) / Freq_L = 0.1 * Freq_C;
  % Burada Freq_L elde edilir.
  % Freq_H = Freq_C^2 / Freq_L;
  Freq_C = Fc(i);
  Freq_L = fsolve(@(F_L) (Freq_C.^2 - F_L.^2) ./ F_L - 0.1 * Freq_C, Freq_C, Options);
  Freq_H = Freq_C.^2 / Freq_L;

  Res_L = R(randi(numel(R)));
  Res_H = R(randi(numel(R)));

  Cap_L = Find_Capacitance_From_Freq(Freq_L, Res_L);
  Cap_H = Find_Capacitance_From_Freq(Freq_H, Res_H);

  Results_First(1, i) = Freq_C; % Center Frequency
  Results_First(2, i) = Freq_L; % Low Frequency
  Results_First(3, i) = Freq_H; % High Frequency
  Results_First(4, i) = Res_L; % Low Pass Resistance
  Results_First(5, i) = Cap_L; % Low Pass Capacitance
  Results_First(6, i) = Res_H; % High Pass Resistance
  Results_First(7, i) = Cap_H; % High Pass Capacitance
  Results_First(8, i) = Resolution; % Resolution;

  F = linspace(Freq_L ./ 15, Freq_H * 15, Resolution);
  W = F .* (2*pi);

  Z_Res_L = Res_L .* ones(1, Resolution);
  Z_Cap_L = Find_Empedances_From_Cap(W, Cap_L);
  Z_Res_H = Res_H .* ones(1, Resolution);
  Z_Cap_H = Find_Empedances_From_Cap(W, Cap_H);

  % Thevenin/Norton Eq.
  V_Input_F = Voltage_Amplitude .* ones(1, Resolution);

  Z_Total_OC = Z_Res_H + Z_Cap_H + ((Z_Res_L).^(-1) + (Z_Cap_L).^(-1)).^(-1);
  I_Main_OC = V_Input_F ./ Z_Total_OC;
  V_OC_F = V_Input_F - I_Main_OC .* ( Z_Res_H + Z_Cap_H );

  Z_Total_SC = Z_Res_H + Z_Cap_H;
  I_Main_SC = V_Input_F ./ Z_Total_SC;
  I_SC_F = I_Main_SC;

  Z_Thevenin = V_OC_F ./ I_SC_F;
  V_Thevenin_F = V_OC_F;
  V_Output_F = V_Thevenin_F;

  V_Transfer = V_Output_F ./ V_Input_F;
  V_Gain = 20 .* log10(real(V_Transfer));

  Results_Second(1, i, :) = Z_Res_L;
  Results_Second(2, i, :) = Z_Cap_L;
  Results_Second(3, i, :) = Z_Res_H;
  Results_Second(4, i, :) = Z_Cap_H;
  Results_Second(5, i, :) = V_Input_F;
  Results_Second(6, i, :) = V_Output_F;
  Results_Second(7, i, :) = V_Gain;
  Results_Second(8, i, :) = F;
end