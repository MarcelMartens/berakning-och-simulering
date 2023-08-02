%%
%File used in the Matlab project in the course Linear algebra given autumn
%2009. A. Hultgren, BTH. The file is called rayrectangle.m
%% Operation 1
%Definition of a rectangle.
%
%assign the coordinates of the low left
%vertice to the parameter "lowerleftpoint" and assign the coordinates of
%the upper right vertice to the parameter "upperrightvertice". Assigne
%the vertice coordinate as a column vector, with x as the upper entry and y
%as the lower entry.
%
%assignment of the lower left vertice. Use values between -10 and 0.
lowerleftvertice=[-2
    -1];
%assignment of the upper right vertice. Use values between 0 and 10.
upperrightvertice=[1
    1];
%definition of the four vertices, 
v1=lowerleftvertice;
v2=[upperrightvertice(1)
    lowerleftvertice(2)];
v3=upperrightvertice;
v4=[lowerleftvertice(1)
    upperrightvertice(2)];
%definition of the rectangle
rectangle=[v1 v2 v3 v4 v1];
%% Operation 2
%Definition of a suitable plotting window
%
%calculate suitable window size as larger than the maximal values
scale=1.2*max(max(abs(rectangle)));
%plot the window and make it square
figure(2),clf,axis([-scale scale -scale scale]),axis('equal')
%lock the window for later use
hold on
%% Operation 3
%plot of rectangle
%
%enable fast plotting in the chosen window
set(gcf,'DoubleBuffer','on');
%plot the rectangle
plot(rectangle(1,:),rectangle(2,:))
%% Operation 4
%Calculation of switching parameters
%
%calculate the negative x edge
xmin=min(rectangle(1,:));
%calculate the positive x edge
xmax=max(rectangle(1,:));
%calculate the negative y edge
ymin=min(rectangle(2,:));
%calculate the positive y edge
ymax=max(rectangle(2,:));
%% Operation 5
%Ray definition                           
%
%Definition of ray parameters
%initial starting point of the ray
r0=[0;0];
%the ray velocity
c=[.2;.3];
%the ray time increment
dt=.1*scale;
%number of points in ray generation
kmax=100;
%% Operation 6, start of operation
%Ray generation, ray edge detection, and reflection of ray
%
%initialization of the ray
r=r0;%
%initialization of last ray position
rg=r0;
%ray increment repetition
for t=1:dt:dt*kmax
    %ray incement
    r=r+c*dt;
    %wait so the increment can be seen
    pause(0.1)
%% Operation 7
%Detection of ray - edge hit and calculation of new ray velocity
%
    %detection and reflection rectangle edge ymin
    if r(2) <= ymin
        %change ray velocity
        c=c-2*c(2)*[0;1];
        %initialize the ray position to the position before edge hit
        r=rg;
    %detection and reflection rectangular edge xmax
    elseif r(1) >= xmax
        %change ray velocity
        c=c-2*c(1)*[1;0];
        %initialize the ray position to the position before edge hit
        r=rg;
    %detection and reflection rectangular edge ymax
    elseif r(2) >= ymax
        %change ray velocity
        c=c-2*c(2)*[0;1];
        %initialize the ray position to the position before edge hit
        r=rg;
    %detection and reflection rectangular edge xmin
    elseif r(1) <= xmin
        %change ray velocity
        c=c-2*c(1)*[1;0];
        %initialize the ray position to the position before edge hit
        r=rg;
%% Operation 6, end of operation
    else
        %uppdate the last ray position
        rg=r;
    end
    %plot the ray position
    figure(2),plot(r(1),r(2),'.r')
end
%% Operation 8
%Unlock the window and write title and axes information
%
%unlock the window
hold off
%write title and axes labels
title('Ray reflection in a rectangle')
xlabel('x-axis, distance [m]')
ylabel('y-axis, distance [m]')
