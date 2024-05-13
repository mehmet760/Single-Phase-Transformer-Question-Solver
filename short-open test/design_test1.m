clc;
clear;
close all;
% Given data
disp('Determine Power,VH,VL, Open circuit test and Short circuit test values');

S = input('Enter value of S: '); % 100KVA
VH= input('Enter value of VH: ');
VL= input('Enter value of VL: ');
Ihrated = S / VH ;
Ilrated = S / VL ; 
N = VH / VL;
power_factor = input('Enter value of pf: ');


V_SC = input('Enter value of V_SC: ');   % Short circuit test voltage (V)
I_SC = input('Enter value of I_SC: ');   % Short circuit test current (A)
P_SC = input('Enter value of P_SC: ');  % Short circuit test power (W)

V_OC = input('Enter value of V_OC: ');   % Open circuit test voltage (V)
I_OC = input('Enter value of I_OC: ');     % Open circuit test current (A)
P_OC = input('Enter value of P_OC: ');   % Open circuit test power (W)

% Short circuit test calculations
Zeq = V_SC / I_SC;
Req = P_SC / (I_SC^2);
Xeq = sqrt(Zeq^2 - Req^2);

% Open circuit test calculations
Rcore = (V_OC^2) / (P_OC);
Icl = V_OC / Rcore;
Iml =  sqrt(I_OC^2 - Icl^2);
Xmagnetization = V_OC / Iml;

Rcore_hside_value =Rcore *N ^2;
Xmagnetization_hside_value =Xmagnetization *N ^2;
Empedance= Req + j*Xeq;
arctan_rad = atan(Xeq/Req);
Empedance_deg = rad2deg(arctan_rad);
arccos_rad = acos(power_factor);
currentdegree =rad2deg(arccos_rad); 
radsum= arctan_rad+arccos_rad;
degreesum= currentdegree +  Empedance_deg;

AA = cos(radsum);

V2prime= VL* N;
I2prime = Ilrated / N;
Voltage =I2prime * Zeq;
Vreel = V2prime +Voltage*cos(radsum);
Vimg = Voltage*sin(radsum);
V1= sqrt(Vreel^2+Vimg^2);

Voltreg = (V1-V2prime)*100/(V2prime); % Voltage regulation formula

% Display the results
fprintf('V high side rated : %.0f V\n',VH);
fprintf('V low side: %.0f V\n ',VL);
fprintf('I High rated : %.0f A\n ',Ihrated);
fprintf('I low rated: %.0f A\n ',Ilrated);

fprintf('Equivalent Resistance (Req): %.4f ohms\n', Req);
fprintf('Equivalent Reactance (Xeq): %.4f ohms\n', Xeq);
fprintf('Core Resistance (Rcore): %.4f ohms\n', Rcore);
fprintf('Magnetization Reactance (Xmagnetization): %.4f ohms\n', Xmagnetization);
fprintf('Equivalent Resistance  with high voltage side : %.2f ohms\n', Rcore_hside_value);
fprintf('Equivalent Reactance  with high voltage side: %.2f ohms\n', Xmagnetization_hside_value );
fprintf('Voltage regulation:%.2f % \n',Voltreg);

