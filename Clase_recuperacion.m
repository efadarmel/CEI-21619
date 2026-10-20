% =========================================================================
% Clase de recuperación - 19 de octubre del 2026
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
%% Ejercicio 3 del taller
clc
clear
close

%Ingresar los elementos
Vs1 = pha2rect(15,0);
ZR1 = 4;
ZL  = 1j*4;
Vs2 = pha2rect(20,60);
ZC  = -1j*1;
ZR2 = 2;

% Técnica de análisis de nodos
% Eq auxiliar
% Va(1) + Vb(-1) = Vs2
% Eq del supernodo
% Va(1/ZR1 + 1/ZL) + Vb (1/ZC + 1/ZR2) = Vs1(1/ZR1)

A = [1          -1 ;
     1/ZR1+1/ZL , 1/ZC+1/ZR2];
b = [Vs2 ; Vs1*(1/ZR1)];
 
Vab = A\b;
Va = Vab(1);
Vb = Vab(2);

[MVa,AVa] = rect2pha(Va)
[MVb,AVb] = rect2pha(Vb)
IZR1 = (Vs1-Va)/ZR1;
[MIZR1,AIZR1] = rect2pha(IZR1)
IZL = (Va-0)/ZL;
% LCK 
% IZR1+IVS2=IZL
IVS2 = IZL-IZR1;
[MIVS2,AIVS2] = rect2pha(IVS2)
%% Ejercicio 6 del taller
clc
clear
close
% Ingresar los elementos
Vs1 = pha2rect(50,0);
ZR1 = 10;
ZC1 = -1j*4;
ZR2 = 5;
ZC2 = -1j*6;
ZL = 1j*8;
Is = pha2rect(2,0);

% Técnica de análisis de malla
% Eq. auxiliar
% Is = Ia(0)+Ib(-1)+Ic(1)

% Supermalla
% Ia(-ZR2-ZC1)+Ib(ZL+ZC1)+IC(ZC2+ZR2)=0

% Malla a
% Ia(ZR1+ZC1+ZR2)+Ib(-ZC1)+Ic(-ZR2)=Vs1

%    Ia               Ib        Ic
A = [0            ,   -1    ,   1;
     -ZR2-ZC1     , ZL+ZC1  , ZC2+ZR2;
     ZR1+ZC1+ZR2  ,-ZC1     ,-ZR2];
b = [Is ;
     0  ;
     Vs1];

Iabc = A\b;
Ia = Iabc(1);
Ib = Iabc(2);
Ic = Iabc(3);

[MIa,AIa] = rect2pha(Ia);
[MIb,AIb] = rect2pha(Ib);
[MIc,AIc] = rect2pha(Ic);

Io=Ia;
[MIo,AIo] = rect2pha(Io)
% LVK
% +Va+VIs+Vb=0
% VIs = -(Va+Vb)
Va = ZL*Ib;
Vb =ZC1*(Ib-Ia);
VIs = -(Va+Vb);

[MVIs,AVIs] = rect2pha(VIs)
%% Funciones
function z = pha2rect(Mag,Ang)
z = Mag*exp(1j*Ang*pi/180);
end

function [Mag,Ang] = rect2pha(z)
Mag = abs(z);
Ang = angle(z)*180/pi;
end
