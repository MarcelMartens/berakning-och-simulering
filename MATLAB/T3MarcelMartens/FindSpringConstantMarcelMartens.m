%% kort beskrivning av simuleringen
% kort och grovt skript för att hitta fjäderkonstant
% för önskat jämviktsläge
% Använder sig av integreringsmodellen och kör
% igenom simulink-modellen och ökar/minskar k
% tills önskat(nära) jämviktsläge har uppnåtts

% För att koden ska gå snabbare har startvärdet för k
% valts till 20'000 och i och med att max() används för
% att hitta jämvikt har dämpning valts till ett högt värde
% för att ej oscillera kring jämvikt utan istället närma sig

% finns antagligen oändligt många sätt att förbättra
% och snabba upp koden, men hade ej tid att börja 
% effektivisera den mer än såhär.

%% init och def av alla ingående parametrar
tic
close all       % stänger eventuella öppna figurer
clear			% rensa variabler i minnet
target = 0.034;	% önskat jämviktsläge
k = 20000;		% fjäderkonstant
m = 5;			% sitsens massa
M = 75;			% personens massa
g = 9.82;		% tyngdacceleration
b = 4000;		% dämpningskonstanten

%% def av alla simuleringsstyrande värden
mdl = "OfficeChairIntegratorsMarcelM";	% simulink modellen
simTime = 20;							% total simuleringstid 
simOption1 = simset('MaxStep', simTime/100);% steglängd

%% loop för att hitta k-värde med modell 1
while true
	simOut = sim(mdl, simTime, simOption1);
	if (target - max(simOut.yout)) < -0.0001	% om jämvikt är för högt
		k = k + 10;								% ökar k
	elseif (target - max(simOut.yout)) > 0.0001 % om jämvikt är för lågt
		k = k - 10;								% minskar k
	elseif abs(target - max(simOut.yout)) < 0.0001 % dubbelkollar så k är inom gräns
		disp(['beräknad fjäderkonstant: k=',num2str(k)])
		disp(['beräknat jämviktsläge [m]: ',num2str(max(simOut.yout))])
		break
	end
end
toc		% printar total runtime för skriptet


