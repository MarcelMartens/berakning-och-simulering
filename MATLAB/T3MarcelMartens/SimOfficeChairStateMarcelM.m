%% kort beskrivning av simuleringen
% Simulering av oscillationen när en person satter sig 
% på en kontorsstol med tre olika dämpningskonstanter
% systemet beskrivs med tillståndsekvationer i matrisform 
% fjäderkonstanten har beräknats med filen
% "FindSpringConstantMarcelMartens"

%% init och def av alla ingående parametrar
close all       % stänger eventuella öppna figurer 	
clear			% rensa variabler i minnet
k = 21610;		% fjäderkonstant
m = 5;			% sitsens massa
M = 75;			% personens massa
Mtot = M + m;	% total massa
g = 9.82;		% tyngdacceleration	
b1 = 400;		% dämpningskonstant 1
b2 = 1200;		% dämpningskonstant 2
b3 = 2400;		% dämpningskonstant 3
B = [0; 1/Mtot];% matris B
C = [1 0];		% matris C



%% def av alla simuleringsstyrande varden
mdl = "OfficeChairStateMarcelM";			% modellens namn
simTime = 3;								% total simuleringstid
simOption1 = simset('MaxStep', simTime/500);% steglängd

%% simulering med de olika dämpningarna
% sim1
b = b1;									%väljer dämpning
A = [0 1; -k/Mtot -b/Mtot];				%skapar matris med nya b
simOut = sim(mdl, simTime, simOption1); % skapar sim-objekt
yout1 = simOut.yout;					% sparar sim-data
% sim2
b = b2;
A = [0 1; -k/Mtot -b/Mtot];
simOut = sim(mdl, simTime, simOption1);
yout2 = simOut.yout;
% sim3
b = b3;
A = [0 1; -k/Mtot -b/Mtot];
simOut = sim(mdl, simTime, simOption1);
yout3 = simOut.yout;

%% efterberakning av värden
yout1 = yout1*100;		% gör om från meter till cm
yout2 = yout2*100;
yout3 = yout3*100;

%% plot av simuleringsdiagram
figure(gcf)		% Specifiera figur
hold on			% plotta i samma figur
plot(yout1, 'DisplayName', "dämpning=400", 'LineWidth', 3)
plot(yout2, 'DisplayName', "dämpning=1200", 'LineWidth', 3)
plot(yout3, 'DisplayName', "dämpning=2400", 'LineWidth', 3)
hold off		% sluta plotta i samma figur

%% generering av figurelement
title(['Simulering av kontorsstol med dämpningskonstanterna ' ...
	'b=',num2str(b1),[', ' ...		
	'b='],num2str(b2),[', ' ...		
	'b='],num2str(b3), ...			
	' [Nm*s/m]'])					%titel med dämpning som string
xlabel("tid [s]")						%x-ettikett
ylabel("avstånd från jämviktsläge [cm]")%y-ettikett
grid on									%rutnät på
legend('show')			%funktionsettiketter på


