clc;close all; clear all
mc=980;
ic=92336;
l=6;
R=4;
mw=150;
iw=1150;
alpha=ic+mc*R*l
beta=mc*981*l
gamma=iw+((mw+mc)*R*R)
%cont time
Ac=[0 1; beta/alpha 0]
Bc= [0; gamma/alpha]
Ts=1/50
%disc
A=expm(Ac*Ts)
B=(A-eye(2))*inv(Ac)*Bc
%part 3
Aaug=[A(1,:) 0; A(2,:) 0;  0 0 1]
Baug=[B;Ts]
%part 4
%total equation now xk=(Aaug-Baug*K)*xk-1
ts_k=.9;
z_k=.9;
wn_k=(4/(ts_k*z_k))
zcl_k=exp(roots([1 2*z_k*wn_k wn_k^2])*Ts)
K=place(Aaug,Baug,[zcl_k; 0])
%part 5
Caug=[0 1 0; 0 0 1]
ts_l=.15;
z_l=.8;
wn_l=(4/(ts_l*z_l))
zcl_l=exp(roots([1 2*z_l*wn_l wn_l^2])*Ts)
L=place(Aaug',Caug',[zcl_l; abs(zcl_l(1,1))])
%part 6
N=400;
x=zeros(3,N); %initialize states, guess and output
xg=zeros(3,N);
x(2,1)=.2;
y=zeros(2,N);
y(:,1)=Caug*x(:,1);
yg=zeros(2,N);
error(:,1)=(xg(:,1)-x(:,1)); %initialize error
errorc(:,1)=(xg(:,1)-x(:,1));
for k=2:N-1
    ug(:,k-1)=-K*xg(:,k-1);
    x(:,k)=Aaug*x(:,k-1) + Baug*ug(:,k-1)  ;
    xg(:,k)=(Aaug-(Baug*K) - (L'*Caug))*xg(:,k-1)+L'*y(:,k-1);
    y(:,k)=Caug*x(:,k);
    yg(:,k)=Caug*xg(:,k);
    error(:,k)=(Aaug-(L'*Caug))*error(:,k-1); 
    errorc(:,k)=xg(:,k)-x(:,k);%testing both the forms of the error equation
end
t=0:.02:(N-1)*.02;
te=0:.02:N*.02 - .04;
figure
plot(t,x(1,:),t,x(2,:),t,x(3,:))
title('State Values')
xlabel('Time (s) ')
ylabel('Thetas')
legend('State 1','State 2','State 3')
xlim([0 2.5])
figure
plot(te,error(1,:),te,error(2,:),te,error(3,:))
title('Error')
xlabel('Time (s) ')
legend('Error of State 1','Error of State 2','Error of State 3')
xlim([0 .3]);
figure

plot(t,y(1,:),t,yg(1,:),t,y(2,:),'-o',t,yg(2,:))
title('Appendix: W and W Estimated')
ylabel('Rad/s')
xlabel('Time (s)')
legend('Wp Actual','Wp Estimated','Ww Actual','Ww Estimated')
xlim([0,1.5]);
errorc(:,399)=0;
errorn=error-errorc;
figure
plot(te,errorn(1,:),te,errorn(2,:),te,errorn(3,:))
title('Appendix: Error-ErrorC (E= (A-LC)E, Ec=xg-x)');
legend('Error State 1','Error State 2','Error State 3');
xlim([0 1]);
figure
plot(t,x(1,:),t,xg(1,:),t,x(2,:),t,xg(2,:),t,x(3,:),t,xg(3,:))
title('Appendix: All states')
xlabel('Time (s) ')
legend('s1','s1cg','s2','s2g','s3','s3g')
%xlim([0 1]);

