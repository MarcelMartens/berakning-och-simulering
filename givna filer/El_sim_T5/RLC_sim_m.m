%% RLC_circuit

% För att skapa en modellfil med block som bör vara med använd matlabkoden

% ssc_new('RLC_modell','electrical')

%% parametrisering av komponenter
V_in=10;
%%
I_in=1e-3;
R=1e-1;
C=1e-6;
L=1e-6;


%% simulering
simrlc1=sim('RLC_modell',1e-4)

%% plot
plot(simrlc1.simout)