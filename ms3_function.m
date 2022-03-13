function [xd]=ms3_function(t,x,par)
D1=par(1);
D2=par(2);
mi1=par(3);
mi2=par(4);
mi3=par(5);
ro=par(6);
p1=par(7);
k1=par(8);
k2=par(9);
k3=par(10);
z2=par(11);
g=par(12);
pa=par(13);
H=par(14);

 
%sygna³ wejœciowy
z1u=0.07;
z3u=0.07;
%pola podstawy zbiorników
A1 = (pi * x(1)^2 *D1^2)/4*H^2;
A2=pi*D2^2/4;
%równania przep³ywu
q1=mi1*k1*z1u*sqrt(2*ro*(p1-pa));
q2=mi2*k2*z2*sqrt(2*ro*(ro*g*x(1)));
q3=mi3*k3*z3u*sqrt(2*ro*(ro*g*x(2)));
%symulacja modelu nieliniowego
xd(1,1)=3*(q1-q2)/A1;
xd(2,1)=(q2-q3)/A2;
 
end
