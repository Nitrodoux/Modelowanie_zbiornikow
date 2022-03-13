clear all;
%deklaracja zmiennych symbolicznych
syms h1 h2 H dh1 dh2 z1 z2 z3 D1 D2 mi1 mi2 mi3 ro p1 k1 k2 k3 z2 g pa alfa ;
%% 
%zmienne stanu h1 h2
%wej�cia z1 z3
%wyj�cia h1 h2
%pola powierzchni podstaw
A1 = (pi * h1^2 *D1^2)/4*H^2;
A2=pi*D2^2/4;
%wyznaczenie odp�yw�w
q1=mi1*k1*z1*sqrt(2*ro*(p1-pa));
q2=mi2*k2*z2*sqrt(2*ro*(ro*g*h1));
q3=mi3*k3*z3*sqrt(2*ro*(ro*g*h2));
%r�wnania stanu uk�adu nieliniowego
dh1=3*(q1-q2)/A1;
dh2=(q2-q3)/A2;
%obliczenie warto�ci zawor�w w punkcie pracy
z1l=solve(3*(q1-q2)/A1,z1)
z3l=solve((q2-q3)/A2,z3)
%macierz stanu uk�adu liniowego
A(1,1)=simplify(diff(3*(q1-q2)/A1,h1));
A(1,2)=diff(3*(q1-q2)/A1,h2);
A(2,1)=diff((q2-q3)/A2,h1);
A(2,2)=diff((q2-q3)/A2,h2);
%macierz wej�� uk�adu liniowego
B(1,1)=diff(3*(q1-q2)/A1,z1);
B(1,2)=diff(3*(q1-q2)/A1,z3);
B(2,1)=diff((q2-q3)/A2,z1);
B(2,2)=diff((q2-q3)/A2,z3);
%macierz wyj�� uk�adu liniowego
C=[1 0;0 1];
%macierz przenoszenia uk�adu liniowego
D=[0 0;0 0];
%wy�wietlenie macierzy uk�adu
display(A);display(B),display(C);display(D);