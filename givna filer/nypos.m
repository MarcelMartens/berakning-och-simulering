%% funktionsfil som beräknar ny position för strålen i uppgift T0
% hej är nuvarande position
% c_nu är nuvarande hastighet
% dt_nu är uppdateringsintervall (samplingsintervall)


%lång och förståelig
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