function Print_Findings(Results_First, Results_Second, N)
  F = Results_Second(8, N, :);
  V_Input_F = Results_Second(5, N, :);
  V_Output_F = Results_Second(6, N, :);
  V_Gain = Results_Second(7, N, :);

  subplot (4, 1, 1)
  semilogx(reshape(F,1,[]), reshape(V_Input_F,1,[]), 'g');
  title("Giriş Gerilimi Tepe Değeri");
  ylabel("V");
  xlabel("Frekans");
  grid on;

  subplot (4, 1, 2)
  semilogx(reshape(F,1,[]), reshape(real(V_Output_F),1,[]), 'k');
  title("Çıkış Gerilimi Tepe Değeri");
  ylabel("V");
  xlabel("Frekans");
  grid on;

  subplot (4, 1, 3)
  semilogx(reshape(F,1,[]), reshape(2.*pi.*angle(V_Output_F),1,[]), 'r');
  title("Açı");
  xlabel("Frekans");
  grid on;

  subplot (4, 1, 4)
  semilogx(reshape(F,1,[]), reshape(V_Gain,1,[]) , 'b');
  title("Kazanç");
  xlabel("Frekans");
  ylabel("dB");
  grid on;

  disp("Center Frequency: "); Results_First(1,N)
  disp("Low Frequency: "); Results_First(2,N)
  disp("High Frequency: "); Results_First(3,N)
  disp("Low Pass Resistance: "); Results_First(4,N)
  disp("Low Pass Capacitance: "); Results_First(5,N)
  disp("High Pass Resistance: "); Results_First(6,N)
  disp("High Pass Capacitance: "); Results_First(7,N)
  disp("Maximum Output Voltage-> ");
  [Max_Output, Index_Max_Output] = max(real(V_Output_F));
  disp("At Frequency: "); F(Index_Max_Output)
  disp("With Magnitude: "); Max_Output
end