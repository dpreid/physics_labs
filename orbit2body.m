% Calculates the force between a planet and a stationary central star and plots the orbit

clear   % clear variable names
clf       %clear the figures
%variables =============================
dt = 0.001;         
n = 3000;         %the number of calculations to do 
speed_planet = 2;     % the initial speed of the planet in the y direction starting at position (1,0)
speed_star = -2;
%G = 6.67E-11;     %gravitational constant
%G=3.964E-14;  %AU**3Msun**-1s**-2
G = 10;
%AU = 1.496E11;  %m, the astronomical unit
AU = 1;
%Msun = 1.989E30;    %kg, 1 solar mass
Msun = 1;
%Mplanet = (3E-6)*Msun;   %rough earth mass        
Mplanet = Msun;
%year = 365.25*24*60*60;   %year length in seconds
%year = 20;

r = AU;          %initial starting distance between stars
position_star = [0, 0];

%=====the initial position of the planet and the array storing successive positions
position_planet = [-r, 0];
positions_planet_x = [-r];
positions_planet_y = [0];

%======initial position of the star===============
position_star = [0, 0];
positions_star_x = [0];
positions_star_y = [0];

velocity_planet = [0, speed_planet];    %planet stars at position -r on x axis and velocity in positive y direction
velocity_star = [0, speed_star];

for i=1:n
  % find new x and y position based upon the current velocity in x and y
  new_x_pos = position_planet(1) + velocity_planet(1)*dt;
  new_y_pos = position_planet(2) + velocity_planet(2)*dt;
  
  new_x_pos_star = position_star(1) + velocity_star(1)*dt;
  new_y_pos_star = position_star(2) + velocity_star(2)*dt;
  
  %add the new position to the array storing position
  positions_planet_x(end+1) = new_x_pos;
  positions_planet_y(end+1) = new_y_pos;
  positions_star_x(end+1) = new_x_pos_star;
  positions_star_y(end+1) = new_y_pos_star;
  
  % get new distance between sun and planet
  r_x = new_x_pos - new_x_pos_star;
  r_y = new_y_pos - new_y_pos_star;
  
  r = sqrt(r_x*r_x + r_y*r_y);  %r_magnitude
  %r = sqrt(new_x_pos*new_x_pos + new_y_pos*new_y_pos);
  r_unit = [r_x,r_y]/r;     %unit vector along r
  %update the acceleration 
  acceleration_mag_planet = G*Msun/(r*r);
acceleration_mag_star = G*Mplanet/(r*r);  
  acceleration_vector_planet = acceleration_mag_planet.*-(r_unit);  %acceleration is towards the centre
  acceleration_vector_star = acceleration_mag_star.*(r_unit); 
  %calculate new velocity for next loop
  velocity_planet(1) = velocity_planet(1) + acceleration_vector_planet(1)*dt;
  velocity_planet(2) = velocity_planet(2) + acceleration_vector_planet(2)*dt;
  velocity_star(1) = velocity_star(1) + acceleration_vector_star(1)*dt;
  velocity_star(2) = velocity_star(2) + acceleration_vector_star(2)*dt;
  %set position of planet to newly calculated position for next loop
  position_planet(1) = new_x_pos;
  position_planet(2) = new_y_pos;
  position_star(1) = new_x_pos_star;
  position_star(2) = new_y_pos_star;
endfor

figure (1)
scatter(positions_planet_x, positions_planet_y)
hold on
scatter(positions_star_x, positions_star_y)
xlabel("x/AU","FontSize",20)
ylabel("y/AU","FontSize",20)
title("Orbit plot","FontSize",20)
axis("equal")