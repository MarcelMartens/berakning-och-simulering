%init
clear


%def ortsvektorer för huset
h1=[2;0];h2=[3;0];h3=[3;1];
h4=[4;1];h5=[4;0];h6=[6;0];
h7=[6;2];h8=[4;3];h9=[2;2];


%def matris med ortsvektorer för huset
h=[h1 h2 h3 h4 h5 h6 h7 h8 h9 h1];
h = [h
    ones(1,length(h))]; %lägger till tredje dimension för att
                        %behålla linjäritet vid translation


%def avbildningsmatriser
T1 = [-1 0 0
       0 1 0
       0 0 1];    %spegling kring y-axel

T2 = [cos(pi/2) -sin(pi/2) 0
      sin(pi/2) cos(pi/2) 0
      0 0 1];   %rotation 90 grader moturs

T3 = [1 0 4
      0 1 4
      0 0 1];   %translation från [0,-4,1] till [4,0,1]

T4 = [1 0 -4
      0 1 0
      0 0 1];   %translation från [4,0,1] till [0,0,1]

T5 = [1 0 4
      0 1 0
      0 0 1];   %translation från [0,0,1] till [4,0,1]

T6 = [cos(pi/180) -sin(pi/180) 0
      sin(pi/180) cos(pi/180) 0
      0 0 1];   %rotation en grad moturs


%transformering av husets position
figure(gcf)
update(h,1);  %plotta huset vid standardpositionen

h = T1*h;
update(h,1);  %plotta huset efter spegling kring y-axeln

h = T2*h;
update(h,1);  %plotta huset efter 90 graders rotation moturs

h = T3*h;
update(h,1)   %plotta huset efter translation till [4,0,1]

h = T4*h;
h = T1*h;
h = T5*h;
update(h,1)   %plotta huset efter spegling kring punkten [4,0]

h = T4*h;
h = T2*h;
h = T5*h;
update(h,1)   %plotta huset efter rotation kring x=4

for i = 0:1:360 %loop för ett helt varvs rotation av huset
    h = T6*h;
    update(h,0.0001)  %plotta huset efter rotation pi/180 moturs
end


%Funktion för att plotta huset utan att behöva skriva om den
function update(hus_matris,delay)
    plot(hus_matris(1,:),hus_matris(2,:),LineWidth=4,Color='b')
    axis([-8 8 -8 8], 'square')
    hold on
    plot([0 0],[-8 8],Color='r',LineWidth=2)
    plot([-8 8], [0 0],Color='r',LineWidth=2)
    hold off
    title("Hus")
    grid on
    pause(delay)
end

