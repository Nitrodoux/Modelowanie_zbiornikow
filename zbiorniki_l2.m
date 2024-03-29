close all
%model liniowy 
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
z2=0.07;%przemieszczenie grzyba zaworu z2 [m]
g=9.81;%przyspieszenie grawitacyjne [m/s^2]
pa=101325;% 1013,25[hPa] ci�nienie atmosferyczne
r1=11;r2=11;r3=11;%promie� przekroju poprzecznego rur 1,2,3
alpfa=pi/4;%k�t rozwarcia zbiorika sto�kowego
 
par=[D1,D2,mi1,mi2,mi3,ro,p1,k1,k2,k3,z2,g,pa,];
%punkty pracy:
h1=0.1;
h2=2;

z1=(k2*mi2*z2*((p1-(g*h1*ro))*ro)^(1/2))/(k1*mi1*(ro*(p1 - pa))^(1/2));
z3=(k2*mi2*z2*((p1-(g*h1*ro))*ro)^(1/2))/(k3*mi3*(g*h2*ro^2)^(1/2));

A=[-(6*2^(1/2)*g*k2*mi2*ro^2*z2)/((D1*pi*(pa-g*h1*ro)*ro)^(1/2)),0;
  (2*2^(1/2)*g*k2*mi2*ro^2*z2)/((D2*pi*(pa-g*h1*ro)*ro)^(1/2)), -(2*2^(1/2)*g*k3*mi3*ro^2*z3)/(D2*pi*(g*h2*ro^2)^(1/2))]
B=[(12*2^(1/2)*k1*mi1*(ro*(p1 - pa))^(1/2))/(D1*pi),0;
    0, -(4*2^(1/2)*k3*mi3*(g*h2*ro^2)^(1/2))/(D2*pi)]
C=[1 0;0 1];
D=[0 0;0 0];


%Wartosci poczatkowe h1 i h2:
x0=[h1; h2]; 
%Czas symulacji
t=0:0.1:20;
u1=[z1+t*0;z3+t*0];
%Linearyzacja:
ob1 = ss(A,B,C,D);
x3=lsim(ob1,u1,t,x0);
 
%Parametry symulacji
options=odeset('RelTol',1e-3,'AbsTol',1e-3);
 
%wywo�anie funkcji ode45
[t,x]=ode45(@ms3_function,t,x0,options,par);
 
figure(2)
plot(t,x(: ,1),'k-','linewidth',2)
xlabel('czas[s]');ylabel('h1[m]');grid on;hold on;
title('zmiana poziomu cieczy w zbiorniku 1')
hold on

figure(3)
plot(t,x(: ,2),'k-','linewidth',2)
xlabel('czas[s]');ylabel('h2[m]');grid on;hold on;
title('zmiana poziomu cieczy w zbiorniku 2')
 
figure(2)
plot(t,x(:,2)-x3(:,1),'r--')
grid on;
title('poziom cieczy w zbiorniku 1')
ylabel('h1[m]')
xlabel('czas [s]')
legend('przed linearyzacj�','po linearyzacji');

figure(3)
plot(t,x(:,2)-x3(:,2),'b--')
grid on;
title('poziom cieczy w zbiorniku 2')
ylabel('h2 [m]')
xlabel('czas [s]')
legend('przed linearyzacj�','po linearyzacji');

