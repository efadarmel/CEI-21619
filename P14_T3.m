% =========================================================================
% Punto 14  del Taller 3 (Frecuencia Compleja)
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
% =========================================================================

clc
clear
close

% Ingresar los elementos
Vs = pha2rect(60,45);
Z1 = 13-1j*5;
Z2 = 10;
Z3 = 8+1j*6;
Z4 = 12;

% Aplicando Divisor de Tension
VZ1 = +Vs*(Z1)/(Z1+Z2);
VZ4 = +Vs*(Z4)/(Z3+Z4);

% Aplicando Ley de Ohm
Voc = VZ4-VZ1;
VTH = Voc;
[MVoc,AVoc] = rect2pha(Voc)
% %  Para ZTh
% Equivalentes paralelo
Zeq1 = 1/(1/Z1 + 1/Z2);
Zeq2 = 1/(1/Z3 + 1/Z4);
% Equivalente serie
Zth = Zeq1+Zeq2
% Transformación de fuente
IN = VTH/Zth;
[MIn,AIn] = rect2pha(IN)

Vth = (-12)*(1-1j*2)/(1+1j)
[Mag,Ang] = rect2pha(Vth)

function z = pha2rect(Mag,Ang)

z = Mag*exp(1j*Ang*pi/180);

end

function [Mag,Ang] = rect2pha(z)
Mag = abs(z);
Ang = angle(z)*180/pi;
end

