clc; close all;
%question 3
w = 2.1915
z = .29435
sys=tf([w*w],[1 2*z*w w*w])
step(sys)
hold on
c_r=roots([1 2*z*w w*w])
T=.2
d_r=exp(c_r*T)
num = [ 1/6 ];
den = [poly(d_r)];
H = tf(num,den,T)
step(H)
hold off
%question 4
figure
num = [ 1 10 ];
den = [1 -.5];
g = tf(num,den,.01)
step(g)
d= tf([1],[1 0 -1],.01)
gcl=feedback(g*d,1)
step(gcl)
rlocus(g*d)
zgrid

