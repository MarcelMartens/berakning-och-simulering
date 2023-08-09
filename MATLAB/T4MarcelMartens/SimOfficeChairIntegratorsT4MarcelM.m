%% kort beskrivning av simuleringen
% Simulering av oscillationen när en person satter sig 
% på en kontorsstol med tre olika dämpningskonstanter
% systemet beskrivs med som en elektrisk krets med två integratorer
% Skriptet behandlar två olika metoder, elektrisk modell och en mekanisk
% modell. För att minska kommentarlängd kommer hädanefter mekaniska
% modellen benämnas "mek" och elektriska modellen benämns "elek"


%% init och def av alla ingående parametrar
close all       % stänger eventuella öppna figurer
clear			% rensa variabler i minnet
k = 25000;		% fjäderkonstant
m = 5;			% sitsens massa
M = 75;			% personens massa
g = 9.82;		% tyngdacceleration
b = 250;		% dämpningskonstant
C = 100*1e-6;	% Kapacitans
L = 1.5*1e-6;	% Induktans
Rx = 2.165e-2;  % Resistans
gamma = 1e4;    % parameter för att justera inspänning
u = 1;          % enhetssteg
v = gamma*u;    % inspänning

%% def av alla simuleringsstyrande värden
mdl1 = "OfficeChairIntegratorsMekT4MarcelM";	% modellens namn (mek)
mdl2 = "OfficeChairIntegratorsElekT4MarcelM";	% modellens namn (elek)
simTime1 = 3;									% total simuleringstid (mek)
simTime2 = 6.5*1e-4;							% total simuleringstid (elek)
simOption1 = simset('MaxStep', simTime1/500, ...% steglängd (mek)
	'AbsTol', 1e-9, ...							% feltolerans för släta kurvor
	'RelTol', 1e-6);							% feltolerans för släta kurvor
simOption2 = simset('MaxStep', simTime2/500, ...% steglängd (elek)
	'AbsTol', 1e-9, ...							% feltolerans för släta kurvor
	'RelTol', 1e-6);							% feltolerans för släta kurvor

%% simulering av systemet
simOut1 = sim(mdl1, simTime1, simOption1);   % skapar sim-objekt (mek)
yout1 = simOut1.yout;						 % sparar positionsdata (mek)
yprimout1 = simOut1.yprimout;				 % sparar hastighetsdata (mek)

simOut2 = sim(mdl2, simTime2, simOption2);   % skapar sim-objekt (elek)
yout2 = simOut2.yout;                        % sparar laddningsdata (elek)
yprimout2 = simOut2.yprimout;                % sparar strömdata (elek)


%% efterberäkning av värden
yout1.Data = yout1.Data*100;		% gör om från meter till cm
yout2.Data = yout2.Data*1e6;		% gör om från coulomb till microcoulomb

%% plot av simuleringsdiagram
% Beräknar rätt position och mått av fönster på skärmens upplösning
screenSize = get(groot, "ScreenSize");        % hämtar användarens skärmstorlek
windowWidth = screenSize(3)*0.8;              % beräknar fönstrets breddmått
windowHeight = screenSize(4)*0.8;             % beräknar fönstrets höjdmått
windowXPos = screenSize(3)/2 - windowWidth/2; % beräknar fönstrets x-position
windowYPos = screenSize(4)/2 - windowHeight/2;% beräknar fönstrets y-position
figure('Position', ...                        % skapar ny figur med relativ position
    [windowXPos, ...                          % väljer x-position
    windowYPos, ...                           % väljer y-position
    windowWidth, ...                          % väljer breddmått
    windowHeight] )                           % väljer höjdmått

% plot och konfigurering av grafegenskaper (mek)
subplot(1,2,1)														% väljer subplot 1
plot(yout1, 'DisplayName', "Position [cm]", 'LineWidth', 3)			% plot position
hold on																% plotta i samma figur
plot(yprimout1, 'DisplayName', "Speed [m/s]", 'LineWidth', 3)		% plot hastighet
hold off															% sluta plotta i samma figur
title('Simulering av mekanisk oscillation av en kontorsstol')		% titel
xlabel("tid [s]")													% x-ettikett
grid on																% rutnät på
legend('Interpreter','latex', 'FontSize', 12, 'FontName', 'Arial')	% Legendinställningar(engelska pga latex)

% plot och konfigurering av grafegenskaper (elek)				
subplot(1,2,2)                                                       % väljer subplot 2
plot(yout2, 'DisplayName', "Charge [$\mu$C]", 'LineWidth', 3)        % plot position
hold on												               	 % plotta i samma figur
plot(yprimout2, 'DisplayName', "Current [A]", 'LineWidth', 3)        % plot hastighet
hold off												             % sluta plotta i samma figur
title('Simulering av Laddningens oscillation i ett elektriskt system')% titel
xlabel("tid [s]")													 % x-ettikett
grid on											            		 % rutnät på
legend('Interpreter','latex', 'FontSize', 12, 'FontName', 'Arial')	 % Legendinställningar(engelska pga latex)

% Generell text för figuren (ej kopplad till subplot)
annotation('textbox', [0.5, 0.9, 0.1, 0.1], ...			% position och storlek av textruta
    'String', "Stäng figur för att visa nästa!", ...	% text att visa
    'HorizontalAlignment', 'center', ...				% centrerar texten i "rutan"
    'FontSize', 15, 'FontWeight', 'bold', ...			% textstorlek och stil
    'EdgeColor', 'none');								% tar bort rutans kant

% parametrar och funktioner för att förbereda nästa plot
waitfor(gcf)							   	  % väntar på att nuvarande figuren stängs
clf											  % rensar nuvarande figur
close(gcf)									  % stänger nuvarande figur
figure('Position', ...                        % skapar ny figur med relativ position
    [windowXPos, ...                          % väljer x-position
    windowYPos, ...                           % väljer y-position
    windowWidth, ...                          % väljer breddmått
    windowHeight] )                           % väljer höjdmått

% efterberäkningar för att skala elektriska simuleringen till mekaniska
beta = simTime1/simTime2;					 % skalär för att matcha tidselement
lambda = 4e-5;								 % skalär för att matcha amplitud

% plot och konfigurering av grafegenskaper (elek & mek)				
plot(yout2.Time*beta, yout2.Data*lambda, ...						 % skalning av simulering
	'DisplayName', "Elektrisk modell", 'LineWidth', 5)			     % plot skalad elektrisk modell
hold on												               	 % plotta i samma figur
plot(yout1, 'DisplayName', "Mekanisk modell", 'LineWidth', 5, ...	 % plot mekanisk modell
	'LineStyle', '--')												 % streckad linje
hold off												             % sluta plotta i samma figur
title('mekanisk modell och skalad elektrisk modell i samma graf')	 % titel
xlabel("tid (relativ till respektive simulering)")					 % x-ettikett
ylabel("Position eller laddning")									 % y-ettikett
grid on											            		 % rutnät på
legend('show')											             % funktionsettiketter på

% generell text för figuren (ej kopplad till subplot)
annotationText = ['$\beta$=',num2str(beta), ...			% skriver ut beta i figuren
	'\hspace{3cm}',...									% lägger till mellanrum mellan beta och lambda			
	'elektrisk modell har amplitud skalad med', ...
	' en faktor $\lambda$=0.00004'];					% skriver ut lambda i figuren
annotation('textbox', [0.45, 0.9, 0.1, 0.1], ...		% position och storlek av textruta
    'String', annotationText, ...						% text att visa
    'HorizontalAlignment', 'center', ...				% centrerar texten i "rutan"
    'FontSize', 20, 'FontWeight', 'bold', ...			% textstorlek och stil
	'FontName', 'Arial',...								% väljer typsnitt
    'EdgeColor', 'none', ...							% tar bort rutans kant
	'Interpreter','latex');								% tillåter latexkod för tecken
	

