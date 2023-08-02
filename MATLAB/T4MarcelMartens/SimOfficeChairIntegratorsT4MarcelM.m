%% kort beskrivning av simuleringen
% Simulering av oscillationen när en person satter sig 
% på en kontorsstol med tre olika dämpningskonstanter
% systemet beskrivs med som en elektrisk krets med två integratorer 
% fjäderkonstanten har beräknats med filen
% "FindSpringConstantMarcelMartens"

%% init och def av alla ingående parametrar
close all       % stänger eventuella öppna figurer
clear			% rensa variabler i minnet
k = 25000;		% fjäderkonstant(ej speciferad så valde något)
m = 5;			% sitsens massa
M = 75;			% personens massa
g = 9.82;		% tyngdacceleration
b = 250;		% dämpningskonstant
C = 100*1e-6;	% Kapacitans
L = 1.5*1e-6;	% Induktaks

%% def av alla simuleringsstyrande varden
mdl = "OfficeChairIntegratorsT4MarcelM";	% modellens namn
simTime = 3;								% total simuleringstid
simOption1 = simset('MaxStep', simTime/500);% steglängd

%% simulering av systemet
simOut = sim(mdl, simTime, simOption1); % skapar sim-objekt
yout1 = simOut.yout;						% sparar sim-data (y)
yprimout1 = simOut.yprimout;				% sparar sim-data (y')

%% efterberakning av värden
yout1 = yout1*100;		% gör om från meter till cm

%% plot av simuleringsdiagram
figure(gcf)												% Specifiera figur
hold on													% plotta i samma figur
plot(yout1, 'DisplayName', "Förflyttning [cm]", 'LineWidth', 3)% plot position
plot(yprimout1, 'DisplayName', "Hastighet [m/s]", 'LineWidth', 3)% plot hastighet
hold off												% sluta plotta i samma figur
title('Simulering av oscillationen av enkontorsstol')	% titel
xlabel("tid [s]")										% x-ettikett




grid on													% rutnät på
legend('show')											% funktionsettiketter på


