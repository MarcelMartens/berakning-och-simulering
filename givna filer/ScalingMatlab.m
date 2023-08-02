
% Demo of including simulation parameters in title and adjusting font size
% As an example, a square wave and a duty cycle signal are used

t=0:1e-7:100e-6;%time axis
fc=25e3;%control frequency
tdel=1/2/fc:1e-7:100e-6+1/2/fc;% delayed time axis
d=30;%duty cycle
Vc=500;%amplitude
vAB1=Vc*square(2*pi*fc*t);%square wave
vAB2p=Vc*(square(2*pi*fc*t,d/2)+1)/2;%positive part of pwm
vAB2m=-Vc*(square(2*pi*fc*tdel,d/2)+1)/2;%negative part of pwm
vAB2=vAB2p+vAB2m;%pwm

figure (1)
plot(t,vAB1,'LineWidth',2)
set(gca,'FontSize',12);%font size change in axis numbers
title({'Control signal,';...
   ['Control frequency =', num2str(fc),'Hz,'];...%plot of parameter value
   ['   Amplitude = ', num2str(Vc),'V'];...
    },'FontSize',12);
xlabel('t  [s]','FontSize',12),ylabel('uAB  [V]','FontSize',12)
scal=1.1;
axis([min(t) max(t) -Vc*scal Vc*scal])

figure (2)
plot(t,vAB2)
set(gca,'FontSize',12);
title({'Control signal,';...
   ['Control frequency =', num2str(fc),'Hz,'];...
   ['Duty cycle =', num2str(d),'%,',...
   '   Amplitude = ', num2str(Vc),'V'];...
    },'FontSize',12);
xlabel('t  [s]','FontSize',12),ylabel('uAB  [V]','FontSize',12)
scal=1.1;
axis([min(t) max(t) -Vc*scal Vc*scal])

