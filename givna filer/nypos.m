%% funktionsfil som ber�knar ny position f�r str�len i uppgift T0
% hej �r nuvarande position
% c_nu �r nuvarande hastighet
% dt_nu �r uppdateringsintervall (samplingsintervall)


%l�ng och f�rst�elig
function [r,c_nu]=nypos(hej,c_nu,dt_nu)
c=c_nu;
dt=dt_nu;
r_nu=hej;
r=r_nu+c*dt;
end


%kort och koncis
% function [r,c]=nypos(r,c,dt)
% r=r+c*dt;
% end