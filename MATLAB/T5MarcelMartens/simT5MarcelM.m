%% RLC_circuit
% Comparison between a mathematical model of an electrical system
% and the "physical" simulation of one through simscape
% The mathematical model is based on a state-space equation system
% and the matrices of this system are shown below

%% Initializing component- and matrix-values
R1 = 1e3;									% Resistance 1
R2 = 500;									% Resistance 2
R3 = 750;									% Resistance 3
C1 = 1e-6;									% Capacitance 1
L1 = 1e-5;									% Inductance 1
L2 = 1e-7;									% Inductance 2
V0 = 5;										% Source voltage
A = [0		 1/C1			 1/C1			% Matrix A
	-1/L1	-(R1+R2)/L1		-R1/L1
	-1/L2	-R1/L2			-(R1+R3)/L2];
B = [0; -1/L1; -1/L2];						% Matrix B
C = [-1 -R1 -R1];							% Matrix C
D = -1;										% Matrix (scalar) D


%% simulation och simulation-controlling values
simtime = 1e-2;												% Sim duration		
simoption1 = simset('MaxStep',simtime/1000,...				% MaxStep, smoother curves
'AbsTol', 1e-9, ...											% Error-tolerance, smoother curves
'RelTol', 1e-6);											% Error-tolerance, smoother curves
simulinkout = sim('T5SimulinkMarcelM',simtime,simoption1);	% Simulates chosen slx file
simscapeout = sim('T5SimScapeMarcelM',simtime,simoption1);	% Simulates chosen slx file

%% plot
% Calculating the optimal screen size for different monitors.
screenSize = get(groot, "ScreenSize");        % gets users resolution
windowWidth = screenSize(3)*0.8;              % calculates window-width
windowHeight = screenSize(4)*0.8;             % calculates window-height
windowXPos = screenSize(3)/2 - windowWidth/2; % calculates window's x-position
windowYPos = screenSize(4)/2 - windowHeight/2;% calculates window's y-position
figure('Position', ...                        % Creates new figure
    [windowXPos, ...                          % sets x-position
    windowYPos, ...                           % sets y-position
    windowWidth, ...                          % sets width
    windowHeight] )                           % sets height

% Plotting and setting of figure parameters
subplot(1,2,1)							% specifies sub plot 
plot(simulinkout.vload, ...				% what to plot	
	'DisplayName', 'Simulink Vload', ...% name of graph
	'LineWidth',3)						% linewidth of plot
title("Vload (Mathematical model)")		% name of plot
ylim([-1.2 0.4])						% limits y-axis for clearer graph
ylabel("(V)")							% Adds correct label for y-axis

subplot(1,2,2)							% Same as above comments:
plot(simscapeout.vload, ...
	'DisplayName', 'Simscape Vload', ...
	'LineWidth',3)
title("Vload (Physical model)")
ylim([-1.2 0.4])




