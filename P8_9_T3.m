% =========================================================================
% Punto 8 y 9 del Taller 3 (Frecuencia Compleja)
% Universidad Industrial de Santander
% =========================================================================
% 
% MIT License
% 
% Copyright (c) 2026 Edinson Fabián Adarme
% 
% Permission is hereby granted, free of charge, to any person obtaining a copy
% of this software and associated documentation files (the "Software"), to deal
% in the Software without restriction, including without limitation the rights
% to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
% copies of the Software, and to permit persons to whom the Software is
% furnished to do so, subject to the following conditions:
% 
% The above copyright notice and this permission notice shall be included in all
% copies or substantial portions of the Software.
% 
% THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
% IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
% FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
% AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
% LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
% OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
% SOFTWARE.
% =========================================================================clc
%% Punto 8
clc
clear
close

% Ingresar los elementos
Is = pha2rect(4,90);
Z1 = 4-1j*3;
Z2 = 2+1j*1;
Z3 = 1j*5;
Z4 = 1-1j*2;

% Aplicando transformación de fuente
Vs = Is*Z1;
[MVs,AVs] = rect2pha(Vs)
% Impedancia equivalente en serie
Zeq1 = Z1+Z2
% Aplicando transformación de fuente
Is2 = Vs/Zeq1;
[MIs2,AIs2] = rect2pha(Is2);

% Aplicando un divisor de corriente
Io = Is2*(1/Z4) / (1/Z4+1/Z3+1/Zeq1);
[MIo,AIo] = rect2pha(Io)

%% Punto 9
clc
clear
close

% % Vs1:ON  Is:OFF Vs2:OFF
% Transformar los elementos al dominio de la frecuencia
Vs1 = pha2rect(50,0); w = 2000;
ZR1 = 80; ZR2 = 60; ZR3 = 100;
C = 20*1e-6; XC = 1/(w*C);
ZC = -1j*XC;
L = 40*1e-3; XL = w*L;
ZL = 1j*XL;

% Equivalente serie entre ZL y ZC
Zeq1 = ZL+ZC
% Transformación de fuente
Ix = Vs1/Zeq1;

%Equivalente serie entre ZR2 y ZR3
Zeq2 = ZR2+ZR3;

% Divisor de corriente
Io1 = -Ix*(1/Zeq2) / (1/Zeq1 +1/ZR1 +1/Zeq2 );
[MIo1,AIo1] = rect2pha(Io1)
% % Vs1:OFF  Is:ON Vs2:OFF
% Transformar los elementos al dominio de la frecuencia
Is = pha2rect(2,0); w2 = 4000;
XC2 = 1/(w2*C); ZC2 = -1j*XC2;
XL2 = w2*L; ZL2 = 1j*XL2;

% Aplicando la técnica de análisis de malla
% Ia(ZC2+ZR1+ZL2) + Ib(-ZR1) = Is*ZL2
% Ia(-ZR1)        + Ib(ZR3+ZR2+ZR1) = Is*ZR2

A = [(ZC2+ZR1+ZL2) , -ZR1;
         -ZR1      , ZR3+ZR2+ZR1];
b = [Is*ZL2;
     Is*ZR2];
Iab = A\b;
Ib = Iab(2);
Io2 = -Ib;
[MIo2,AIo2] = rect2pha(Io2)

% % Vs1:ON  Is:OFF Vs2:ON
Vs2 = 24;

Io3 = Vs2/(ZR1+ZR2+ZR3);

%%
fprintf('io(t) = %0.3fcos(%0.0ft+%0.3f°) + %0.3fsin(%0.0ft%0.3f°) + %0.3f V',MIo1,w,AIo1,MIo2,w2,AIo2,Io3)

%% Funciones auxiliares
function z = pha2rect(Mag,Ang)

z = Mag*exp(1j*Ang*pi/180);

end

function [Mag,Ang] = rect2pha(z)
Mag = abs(z);
Ang = angle(z)*180/pi;
end
