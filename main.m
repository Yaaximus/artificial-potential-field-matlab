clc
clear
close all

%......................Artificial Potential Field.........................

Robot_Coordinate     = [3 3]               ;% Rabot Coordinate = [x-axis y-axis]
Obstacle1_Coordinate = [6 7]               ;% Obstacle1 Coordinate = [x-axis y-axis]
Obstacle2_Coordinate = [6 5]               ;% Obstacle2 Coordinate = [x-axis y-axis]
Goal_Coordinate      = [9 9]               ;% Target Coordinate = [x-axis y-axis]
Sensor_Range         = 2                   ;% Sensor Range being used
Step_Size   = 0.4*Sensor_Range             ;% Radius of Circle for Artificial Points
Obstacle             = [1 4]               ;% Obstacle = [Aplha Mew][0.5 0.5]
Goal                 = [1 4]               ;% Target   = [Alpha Mew][4 70]
NPTS                 = 60                  ;% Number of Artificial Points %60
StepDegree           = 360/NPTS            ;% Step Degree in Degree for Artificial Points
Confirm_Message      = 'Solution Exists'   ;% Message Displayed if a Good Artificial Point Exists
Error_Message        = 'No Solution Exists';% Message Displayed if no Good Artificial Point Exists
Bacteria_x           = Robot_Coordinate(1) ;% Artificial Best Point x
Bacteria_y           = Robot_Coordinate(2) ;% Artificial Best Point y
%.................................Plot.....................................

hold on
axis([0 12 0 12])

%............................Create a Target...............................

backx  = Goal_Coordinate(1) - 0.15;backy1 = Goal_Coordinate(2) + 0.15;
frontx = Goal_Coordinate(1) + 0.15;fronty1 = Goal_Coordinate(2) + 0.15;
middlex = Goal_Coordinate(1);middley1 = Goal_Coordinate(2)+ 0.15;
middley2 = Goal_Coordinate(2)- 0.15;
tri2 = [backx middlex frontx ;backy1 middley1 fronty1 ];
plot(tri2(1,:), tri2(2,:));
tri3 = [middlex middlex ;middley1 middley2];
plot(tri3(1,:), tri3(2,:));

%.............Create a purple transparent circular Obstacle................

xc = Obstacle1_Coordinate(1);
yc = Obstacle1_Coordinate(2);
r = 0.2;
x = r*sin(-pi:0.2*pi:pi) + xc;
y = r*cos(-pi:0.2*pi:pi) + yc;
c = [0.6 0 1];
fill(x, y, c, 'FaceAlpha', 0.4)

xc = Obstacle2_Coordinate(1);
yc = Obstacle2_Coordinate(2);
r = 0.2;
x = r*sin(-pi:0.2*pi:pi) + xc;
y = r*cos(-pi:0.2*pi:pi) + yc;
c = [0.6 0 1];
fill(x, y, c, 'FaceAlpha', 0.4)

DTG = 1;
while(DTG > 0.6)
    
    %.............................Create a Robot...........................
    
    backx  = Robot_Coordinate(1) - 0.15;backy1 = Robot_Coordinate(2) + 0.15;
    backy2 = Robot_Coordinate(2) - 0.15;frontx = Robot_Coordinate(1) + 0.075;
    fronty1 = Robot_Coordinate(2) + 0.15;fronty2 = Robot_Coordinate(2);
    tri1 = [backx backx frontx frontx backx frontx;backy2 backy1 fronty1 fronty2 fronty2 backy2];
    plot(tri1(1,:), tri1(2,:));
    
    %.........................Potential Calculations.......................
    
    J_ObstT = Obstacle(1)*exp(-Obstacle(2)*((Robot_Coordinate(1)-Obstacle1_Coordinate(1))^2+(Robot_Coordinate(2)-Obstacle1_Coordinate(2))^2))
    J_ObstT = J_ObstT + Obstacle(1)*exp(-Obstacle(2)*((Robot_Coordinate(1)-Obstacle2_Coordinate(1))^2+(Robot_Coordinate(2)-Obstacle2_Coordinate(2))^2))
    J_GoalT = -Goal(1)*exp(-Goal(2)*((Robot_Coordinate(1)-Goal_Coordinate(1))^2+(Robot_Coordinate(2)-Goal_Coordinate(2))^2))
    JT = J_ObstT + J_GoalT;
    
    %...........................Distance to Goal...........................
    
    DTG = sqrt((Robot_Coordinate(1)-Goal_Coordinate(1))^2+(Robot_Coordinate(2)-Goal_Coordinate(2))^2)
    
    %...........................Artificial Points..........................
    
    Theta = zeros(1,NPTS);
    Theta(1) = StepDegree;
    for i=1:NPTS-1
        Theta(i+1) = Theta(i) + StepDegree;
    end
    
    %     a = 1;
    %     b = 360;
    %     Theta = a + (b-a).*rand(NPTS,1);
    
    Bacteria_x = zeros(1,NPTS);
    Bacteria_y = zeros(1,NPTS);
    for i=1:NPTS
        Bacteria_x(i) = Robot_Coordinate(1) + (Step_Size*cos(pi*Theta(i)/180));
        Bacteria_y(i) = Robot_Coordinate(2) + (Step_Size*sin(pi*Theta(i)/180));
    end
    plot(Bacteria_x,Bacteria_y,'.')
    pause(0.1);
    %........Calculating Cost Function and Distance of Artificial Point....
    
    [m,n] = size(Bacteria_x);
    J_ObstT_Bacteria = zeros(1,n);
    J_GoalT_Bacteria = zeros(1,n);
    JT_Bacteria = zeros(1,n);
    DTG_Bacteria = zeros(1,n);
    for i=1:n
        J_ObstT_Bacteria(i) = Obstacle(1)*exp(-Obstacle(2)*((Bacteria_x(i)-Obstacle1_Coordinate(1))^2+(Bacteria_y(i)-Obstacle1_Coordinate(2))^2));
        J_ObstT_Bacteria(i) = J_ObstT_Bacteria(i) + Obstacle(1)*exp(-Obstacle(2)*((Bacteria_x(i)-Obstacle2_Coordinate(1))^2+(Bacteria_y(i)-Obstacle2_Coordinate(2))^2));
        J_GoalT_Bacteria(i) = -Goal(1)*exp(-Goal(2)*((Bacteria_x(i)-Goal_Coordinate(1))^2+(Bacteria_y(i)-Goal_Coordinate(2))^2));
        JT_Bacteria(i) = J_ObstT_Bacteria(i) + J_GoalT_Bacteria(i);
        DTG_Bacteria(i) = sqrt((Bacteria_x(i)-Goal_Coordinate(1))^2+(Bacteria_y(i)-Goal_Coordinate(2))^2);
    end
    J_GoalT_Bacteria;
    
    %....................Error in Cost Function & Distance.................
    
    err_J   = zeros(1,n);
    err_DTG = zeros(1,n);
    Fitness = zeros(1,n);
    for i=1:n
        err_J(i)   = JT_Bacteria(i)  - JT;
        err_DTG(i) = DTG_Bacteria(i) - DTG;
        Fitness(i) = -err_DTG(i);
    end
    Fitness;
    %..........................Best Point Selection........................
    
    Check = 0;
    for t=1:n
        [~,k]= max(Fitness);
        if err_J(k) < 0
            if err_DTG(k)<0
                Check = Check + 1;
                Robot_Coordinate(1) = Bacteria_x(k);
                Robot_Coordinate(2) = Bacteria_y(k);
                DTG = sqrt((Robot_Coordinate(1)-Goal_Coordinate(1))^2+(Robot_Coordinate(2)-Goal_Coordinate(2))^2);
            else
                Fitness(k) = 0;
            end
        else
            Fitness(k) = 0;
        end
    end
    Check;
    if Check == 0
        disp(Error_Message)
    else
        disp(Confirm_Message)
    end
    All_Data = zeros(NPTS,3);
    All_Data(:,1) = Robot_Coordinate(1);
    All_Data(:,2) = Robot_Coordinate(2);
    All_Data(:,3) = Theta;
    All_Data(:,4) = J_ObstT_Bacteria;
    All_Data(:,5) = J_GoalT_Bacteria;
    All_Data(:,6) = JT_Bacteria;
    All_Data(:,7) = err_J;
    All_Data(:,8) = err_DTG;
    All_Data;
    %.................................Plot.................................
    
    %............................Create a Target...........................
    backx  = Goal_Coordinate(1) - 0.15;backy1 = Goal_Coordinate(2) + 0.15;
    frontx = Goal_Coordinate(1) + 0.15;fronty1 = Goal_Coordinate(2) + 0.15;
    middlex = Goal_Coordinate(1);middley1 = Goal_Coordinate(2)+ 0.15;
    middley2 = Goal_Coordinate(2)- 0.15;
    tri2 = [backx middlex frontx ;backy1 middley1 fronty1 ];
    plot(tri2(1,:), tri2(2,:));
    hold on
    tri3 = [middlex middlex ;middley1 middley2];
    plot(tri3(1,:), tri3(2,:));
    
    %.............Create a purple transparent circular Obstacle............
    
    xc = Obstacle1_Coordinate(1);
    yc = Obstacle1_Coordinate(2);
    r = 0.2;
    x = r*sin(-pi:0.2*pi:pi) + xc;
    y = r*cos(-pi:0.2*pi:pi) + yc;
    c = [0.6 0 1];
    fill(x, y, c, 'FaceAlpha', 0.4)

    xc = Obstacle2_Coordinate(1);
    yc = Obstacle2_Coordinate(2);
    r = 0.2;
    x = r*sin(-pi:0.2*pi:pi) + xc;
    y = r*cos(-pi:0.2*pi:pi) + yc;
    c = [0.6 0 1];
    fill(x, y, c, 'FaceAlpha', 0.4)
    
    %................................Outputs...............................
%     J_ObstT
%     J_GoalT
%     JT
%     DTG
%     JT_Bacteria
%     DTG_Bacteria
%     err_J
%     err_DTG
%     Check
%     k
%     Fitness
end
Variables = {'Rx' 'Ry' 'Theta' 'J_Obst_B' 'J_GoalT' 'JT' 'err_J' 'err_DTG'};
filename = 'E:\PathPlanning_Yasim\RPO First Iteration\RPO_Data.xlsx';
xlswrite(filename,Variables)
xlswrite(filename,All_Data,1,'A2');
