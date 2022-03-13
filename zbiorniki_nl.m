clear;
clc;
%model nieliniowy 
%Parametry
D1=2;%�rednica podstawy zbiornika sto�kowego [m]
D2=2;%�rednica podstawy zbiornika walcowego [m]
mi1=0.9;%wsp�czynnik nat�enia przep�ywu ruroci�gu 1
mi2=0.9;%wsp�czynnik nat�enia przep�ywu ruroci�gu 2
mi3=0.9;%wsp�czynnik nat�enia przep�ywu ruroci�gu 3
ro=700;      %g�sto�� cieczy (benzyna) [kg/m^3]
p1=105000;    %ci�nienie cieczy na wlocie do ruroci�gu 1.05[bar] 
k1=0.05;%wsp�czynnik zmiany pola przep�ywu zaworu 1
k2=0.05;%wsp�czynnik zmiany pola przep�ywu zaworu 2
k3=0.05;%wsp�czynnik zmiany pola przep�ywu zaworu 3
z2=0.08;%przemieszczenie grzyba zaworu z2 [m]
g=9.81;%przyspieszenie grawitacyjne [m/s^2]
pa=101325;% 1013,25[hPa] ci�nienie atmosferyczne
%alfa=pi/6;%k�t rozwarcia zbiorika sto�kowego
H=1;
%pa=105000;
%wektor parametr�w 
par=[D1,D2,mi1,mi2,mi3,ro,p1,k1,k2,k3,z2,g,pa,H];
 
%% Warto�ci pocz�tkowe h1 i h2:
x0=[0.1 0.1];
 
%Czas symulacji
t=0:0.01:20;
 
%Parametry symulacji
options=odeset('RelTol',1e-3,'AbsTol',1e-3);
 
%wywo�anie funkcji ode45
[t,x]=ode45(@ms3_function,t,x0,options,par);
 
figure(1)
plot(t,x(: ,1),'k-','linewidth',1);hold on;
plot(t,x(: ,2),'k-','linewidth',2);hold on;
xlabel('czas[s]');ylabel('h1[m] i h2[m]');grid on;
legend('h1','h2');
title('Zmiana poziomu cieczy w zbiornikach w uk�adzie nieliniowym');
