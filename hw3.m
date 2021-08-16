clc; close all;
%part 1
c=.2005;
b=.9967;
a=.1;
T=.1;
num= c*[1 b];
den=[1 -exp(-a*T)-1 exp(-a*T)];
sys=tf([num],[den],T);
A=[0 1; -den(1,3) -den(1,2)]
B=[0 1]'
C=[c*b c]
%part 2
ts=5
z=.1
wn=(4/(ts*z))
ztest=exp(roots([1 2*z*wn wn^2])*T)
K=acker(A,B,ztest)
%part 3
T=.1;
tsl=.5
zl=.1
wnl=(4/(tsl*zl))
zl=exp(roots([1 2*zl*wnl wnl^2])*T)
L = place(A',C',zl)
%part 4
x0=[1 -1]';
x0g=[2 -2]';
N=100;
x=zeros(2,N);
xg=zeros(2,N);
x(1,1)=1; x(2,1)=-1;
xg(1,1)=2; xg(2,1)=-2;
y=zeros(1,N);
yg=zeros(1,N);
error(:,1)=(xg(:,1)-x(:,1));
for k=2:N-1
    u(:,k-1)=-K*x(:,k-1);
    ug(:,k-1)=-K*xg(:,k-1);
    x(:,k)=A*x(:,k-1) + B*u(:,k-1)  ;
    xg(:,k)=A*x(:,k-1) + B*ug(:,k-1);
    y(:,k)=C*x(:,k);
    yg(:,k)=C*xg(:,k);
    error(:,k)=(A-(L'*C))*error(:,k-1);
end
t=0:.1:9.9;
figure
te=0:.1:9.8;
plot(t,y(1,:),t,yg(1,:))
title('Theta Actual and Theta Estimated')
ylabel('Theta')
xlabel('Time (s)')
legend('Theta Actual','Theta Estimated')
figure
subplot(2,1,1)
plot(te,error(1,:))
title('Error of state 1')
xlabel('Time (s) ')
xlim([0 1.5])
subplot(2,1,2)
plot(te,error(2,:))
title('Error of state 2')
xlabel('Time (s)')
xlim([0 1.5])
figure
subplot(2,1,1)
plot(t,x(1,:),t,xg(1,:))
title('X state 1')
xlim([0,.2])
xlabel('Time (s)')
legend('Theta Actual','Theta Estimated')
subplot(2,1,2)
plot(t,x(2,:),t,xg(2,:))
title('X state 2')
xlabel('Time (s)')
legend('Theta Actual','Theta Estimated')
xlim([0,1])