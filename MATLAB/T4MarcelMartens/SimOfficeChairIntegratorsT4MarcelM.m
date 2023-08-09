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
mdl1 = "OfficeChairIntegratorsMekT4MarcelM"; % modellens namn (mek)
mdl2 = "OfficeChairIntegratorsElekT4MarcelM";% modellens namn (elek)
simTime1 = 3;							     % total simuleringstid (mek)
simTime2 = 6.5*1e-4;                         % total simuleringstid (elek)
simOption1 = simset('MaxStep', simTime1/500);% steglängd (mek)
simOption2 = simset('MaxStep', simTime2/500);% steglängd (elek)

%% simulering av systemet
simOut1 = sim(mdl1, simTime1, simOption1);   % skapar sim-objekt (mek)
yout1 = simOut1.yout;						 % sparar positionsdata (mek)
yprimout1 = simOut1.yprimout;				 % sparar hastighetsdata (mek)

simOut2 = sim(mdl2, simTime2, simOption2);   % skapar sim-objekt (elek)
yout2 = simOut2.yout;                        % sparar laddningsdata (elek)
yprimout2 = simOut2.yprimout;                % sparar strömdata (elek)


%% efterberakning av värden
yout1 = yout1*100;		% gör om från meter till cm
yout2 = yout2*0.4e6;     % gör om från coulomb till megacoulomb

%% plot av simuleringsdiagram
% Beräknar rätt position och mått av fönster på skärmens upplösning
screenSize = get(groot, "ScreenSize");        % hämtar användarens skärmstorlek
windowWidth = screenSize(3)*0.8;              % beräknar fönstrets breddmått
windowHeight = screenSize(4)*0.8;             % beräknar fönstrets höjdmått
windowXPos = screenSize(3)/2 - windowWidth/2; % beräknar fönstrets x-position
windowYPos = screenSize(4)/2 - windowHeight/2;% beräknar fönstrets y-position
figure('Position', ...                        % skapar ny figur med specifik position
    [windowXPos, ...                          % väljer x-position
    windowYPos, ...                           % väljer y-position
    windowWidth, ...                          % väljer breddmått
    windowHeight] )                           % väljer höjdmått

% plot och konfigurering av grafegenskaper (mek)
subplot(1,2,1)                                                  % väljer subplot 1
plot(yout1, 'DisplayName', "Förflyttning [cm]", 'LineWidth', 3) % plot position
hold on													        % plotta i samma figur
plot(yprimout1, 'DisplayName', "Hastighet [m/s]", 'LineWidth', 3)% plot hastighet
hold off												        % sluta plotta i samma figur
title('Simulering av mekanisk oscillation av en kontorsstol')   % titel
xlabel("tid [s]")									        	% x-ettikett
grid on												        	% rutnät på
legend('show')										        	% funktionsettiketter på

% plot och konfigurering av grafegenskaper (elek)				
subplot(1,2,2)                                                       % väljer subplot 2
plot(yout2, 'DisplayName', "Laddning [Q]", 'LineWidth', 3)           % plot position
hold on												               	 % plotta i samma figur
plot(yprimout2, 'DisplayName', "Ström [A]", 'LineWidth', 3)          % plot hastighet
hold off												             % sluta plotta i samma figur
title('Simulering av Laddningens oscillation i ett elektriskt system')% titel
xlabel("tid [10^-4 s]")			                                     % x-ettikett
grid on											            		 % rutnät på
legend('show')											             % funktionsettiketter på

% Generell text för figuren
instructionText = "Stäng figur för att visa nästa!";
annotation('textbox', [0.47, 0.9, 0.1, 0.1], ...
    'String', instructionText, ...
    'HorizontalAlignment', 'center', ...
    'FontSize', 12, 'FontWeight', 'bold', ...
    'EdgeColor', 'none');

waitfor(gcf)							% väntar på på att figuren stängs

% plot och konfigurering av grafegenskaper (elek & mek)



