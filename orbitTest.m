% Calculates the force between a planet and a stationary central star and plots the orbit
clear
%variables =============================
dt = 0.001;         
n = 2000;         %the number of calculations to do 
speed_planet = 3;     % the initial speed of the planet in the y direction starting at position (1,0)
%G = 6.67E-11;     %gravitational constant
%G=3.964E-14;  %AU**3Msun**-1s**-2
G = 10;
%AU = 1.496E11;  %m, the astronomical unit
AU = 1;
%Msun = 1.989E30;    %kg, 1 solar mass
Msun = 1;
Mplanet = (3E-6)*Msun;   %rough earth mass        
%year = 365.25*24*60*60;   %year length in seconds
%year = 20;

r = AU;          %initial starting distance between stars
position_star = [0, 0];

%=====the initial position of the planet and the array storing successive positions
position_planet = [-r, 0];
positions_planet_x = [-r];
positions_planet_y = [0];

%==== the initial velocity of the planet and array storing successive velocities
%speed_planet = 2*pi*r/year;

velocity_planet = [0, speed_planet];    %planet stars at position -r on x axis and velocity in positive y direction

for i=1:n
  % find new x and y position based upon the current velocity in x and y
  new_x_pos = position_planet(1) + velocity_planet(1)*dt;
  new_y_pos = position_planet(2) + velocity_planet(2)*dt;
  %add the new position to the array storing position
  positions_planet_x(end+1) = new_x_pos;
  positions_planet_y(end+1) = new_y_pos;
  % get new distance between sun and planet (since sun remains at 0,0) we can just find the distance from there
  r = sqrt(new_x_pos*new_x_pos + new_y_pos*new_y_pos);
  r_unit = [new_x_pos,new_y_pos]/r;     %unit vector along r
  %update the acceleration
  acceleration_mag = G*Msun/(r*r);    
  acceleration_vector = acceleration_mag.*-(r_unit);  %acceleration is towards the centre
  %calculate new velocity for next loop
  velocity_planet(1) = velocity_planet(1) + acceleration_vector(1)*dt;
  velocity_planet(2) = velocity_planet(2) + acceleration_vector(2)*dt;
  %set position of planet to newly calculated position for next loop
  position_planet(1) = new_x_pos;
  position_planet(2) = new_y_pos;
endfor

figure(1)
scatter(positions_planet_x, positions_planet_y)
xlabel("x/AU","FontSize",20)
ylabel("y/AU","FontSize",20)
title("Orbit plot","FontSize",20)
axis("equal")