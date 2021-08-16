clc; close all;
a=0:1:19;
ed= zeros(22,1);
ed(2,1) = 1 ;
for k =2:22
    ed(k+1) = .6*ed(k) - .08*ed(k-1);
end
subplot(3,1,1)
plot(a,ed(2:21,1));
title('(a)')
xlabel('k')
ylabel('e(k)')
wd=zeros(23,1);
wd(3,1)=1;
for k=3:23
    wd(k+1) = -2.6*wd(k) - 2.19*wd(k-1) - .594*wd(k-2);
end
subplot(3,1,2)
plot(a,wd(3:22))
title('(b)')
xlabel('k')
ylabel('w(k)')
yd=zeros(24,1);
yd(4,1)=1;
for k=4:24
    yd(k+1)=.2*yd(k) - .02*yd(k-1) - .08*yd(k-2) - .16*yd(k-3);
end
subplot(3,1,3)
plot(a,yd(4:23))
title('(c)')
xlabel('k')
ylabel('y(k)')

