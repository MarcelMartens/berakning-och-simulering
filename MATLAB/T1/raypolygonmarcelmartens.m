%simulating
%def hörn
v1 = [3;0];
v2 = [0;3];
v3 = [-2;0];
v4 = [-1;-2];
%def avbildningsmatris för rotation 90 grader moturs
A = [0,1;-1,0];
%def normaliserade normalvektorer
n1 = (A*(v1-v2))/norm(A*(v1-v2));
n2 = (A*(v2-v3))/norm(A*(v2-v3));
n3 = (A*(v3-v4))/norm(A*(v3-v4));
n4 = (A*(v4-v1))/norm(A*(v4-v1));
%def polygon
poly = [v1 v2 v3 v4 v1];
%clear figur
figure(gcf);
clf;
%anpassa figur efter polygons storlek
ax = 1.2*(max(max(abs(poly))));
axis([-ax ax -ax ax]), axis('square');
hold on;
%plot polygon + normalvektorer
plot(poly(1,:),poly(2,:),LineWidth=2);
quiver(v1(1),v1(2),n1(1),n1(2),LineWidth=3,Color='g')
quiver(v2(1),v2(2),n2(1),n2(2),LineWidth=3,Color='g')
quiver(v3(1),v3(2),n3(1),n3(2),LineWidth=3,Color='g')
quiver(v4(1),v4(2),n4(1),n4(2),LineWidth=3,Color='g')
grid on;
%def strålens startpunkt och riktning + stegstorlek och antal steg
r0 = [0;0];
r = r0;
r_last = r0;
c = [.3;.2];
dt = .1*ax;
kmax = 1000;
%foorloop för att detektera kant och sätta ny riktning på strålen
%körs en gång varje fem hundradelars sekund och sparar strålens förra position
%varje steg av exekveringen
for t=0:dt:dt*kmax
    r=r+c*dt;
    pause(0.05)
    if dot(n1,r-v1)<=0
        cn=dot(c,n1)*n1;
        c=c-2*cn;
        r=r_last;
    elseif dot(n2,r-v2)<=0
        cn=dot(c,n2)*n2;
        c=c-2*cn;
        r=r_last;
    elseif dot(n3,r-v3)<=0
        cn=dot(c,n3)*n3;
        c=c-2*cn;
        r=r_last;
    elseif dot(n4,r-v4)<=0
        cn=dot(c,n4)*n4;
        c=c-2*cn;
        r=r_last;
%om strålen ej är utanför polygonen sätts r_last till strålens nuvarande pos
%när den går utanför är förra positionen sparad så den kan backa ett steg
    else
        r_last=r; 
    end
    plot(r(1),r(2),'.r')
end
%ställer in figur-parametrar och bestämmer att figuren är färdig
hold off
title("Stråles reflektion i en polygon")
xlabel("x-axis")
ylabel("y-axis")



