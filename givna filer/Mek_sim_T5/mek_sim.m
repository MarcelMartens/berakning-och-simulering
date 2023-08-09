%% mek_circuit

% För att skapa en modellfil med block som bör vara med använd matlabkoden

%ssc_new('mek_modell','translational')

%% parametrisering av komponenter
T_start=0;
F_0=0;
F=10;
b=10;
k=1000;
m=10;


%% simulering
simmek1=sim('mek_modell_1',10)

%% plot
plot(simmek1.simout)