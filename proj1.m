clc; close all; clear all;
a=-.6713;
b1=1 
b2=-1;
G=tf([.0228 1.2666],[1 -.6714],1/50);
D=tf([1 a],poly([b2 b1]),1/50);
t=0:0.02:10;
oltf=series(G,D)
rlocus(oltf)
xlim([-1.1 1.1]);ylim([-1.1 1.1])
figure
cltf=feedback(series(.79*G,D),1)
step1=2*pi*ones(1,length(t));
[y1,t]=lsim(cltf,step1,t)
plot(t,y1,t,step1)
xlim([0 .1])
xlabel('Time (s)')
ylabel('Output (Rad/s)')
title('Response to 2pi rad/s Step')
legend('Response','Desired')
figure
alpha=1;
ramp=alpha*t       
[y2,t]=lsim(cltf,ramp,t)
plot(t,y2,t,ramp)
xlim([0 1.1]);ylim([0 1.1])
xlabel('Time (s)')
ylabel('Output (Rad/s)')
title('Response to Ramp 1rad/s/s')
legend('Response','Desired')

tr=.1
mp=.2
Ts=1/50
wn=1.8/tr
x = wn*(Ts)/pi
z=sqrt(((log(mp)^2))/((log(mp)^2) + pi*pi))
ts=4/(z*wn)
mag = exp(-8*Ts)

%zgrid(z,wn/Ts)
%hold on
%zgrid on
%hold off