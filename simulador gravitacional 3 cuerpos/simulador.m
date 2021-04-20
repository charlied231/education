clc
clear
close all
%% Caso de un sistema de 2 planetas "gemelos" y un planeta osilando linealmente entre ellos
%% Párametros constantes
Gm = 6.67*10^-11;           % Constante de Gravitación Universal en Nm2/s2
G = Gm *(1*10^-12);         % Gravedad en N(millones de km)2/s2
UA = 1.496*10^8;            % Unidades astronomicas en km
M1 = 2*10^30;               % Masa del planeta 1
m2 = 2*10^30;               % Masa del planeta 2
m3 = 2*10^12;                % Masa del planeta 3
r1 = 0.8;                   % Radio del planeta 1 (millones de km)
r2 = 0.8;                   % Radio del planeta 2 (millones de km)
r3 = 0.01;                  % Radio del planeta 3 (millones de km)

%% Declaración de variables iniciales
h = 0.0001;           % Salto del ciclo
t = (0:h:10);         % Intervalo de tiempo (Cada t = 1 año terrestre) (Normal 11.8)
T = 200;              % Intervalo para graficar

%% Condiciones iniciales del objeto 1
    % Inicializamos vectores para el objeto 1, tanto de posición como velocidad
x1 = [500];                   % (valores en millones de km)
y1 = [0];                    
z1 = [0];                    
vx1 = [0];                   
vy1 = [0];                   
vz1 = [200];                   

%% Condiciones iniciales del objeto 2
    % Hacemos lo mismo para el objeto 2, valores iniciales de velocidad y posición
x2 = [-500];                   % (valores en millones de km)
y2 = [0];                
z2 = [0];                  
vx2 = [0];                  
vy2 = [200];                  
vz2 = [0];                   

%% Condiciones iniciales del objeto 3
    % Inicializamos vectores para el objeto 3.
x3 = [0];              % (valores en millones de km)   
y3 = [0];                 
z3 = [0];               
vx3 = [0];               
vy3 = [00];               
vz3 = [0];                

% Inicalizamos los vectores que almacenaran la fuerza de cada cuerpo
fx1 = [];
fy1 = [];
fz1 = [];
fx2 = [];
fy2 = [];
fz2 = [];
fx3 = [];
fy3 = [];
fz3 = [];

%% Método de Leapfrog
for i = 1:length(t)

    R21(i)=((x2(i)-x1(i))^2 + (y2(i)-y1(i))^2 + (z2(i)-z1(i))^2)^(3/2); % Distancia entre el objeto 1 y el 2
    R31(i)=((x3(i)-x1(i))^2 + (y3(i)-y1(i))^2 + (z3(i)-z1(i))^2)^(3/2); % Distancia entre el objeto 1 y el 3
    R32(i)=((x3(i)-x2(i))^2 + (y3(i)-y2(i))^2 + (z3(i)-z2(i))^2)^(3/2); % Distancia entre el objeto 2 y el 3
     % (Se eleva a las 3/2 para usarlo en la función de fuerza gravitatoria)
                                                                                                                            
    % Empezamos el metodo de verlet velocity con las velocidades en n + 1/2
    % En cada renglon sacamos la fuerza ya en la componente de cada
    % dirección y la dividimos entre las masas para tener aceleración
    
    F1x=-(G * m2 * (x1(i)-x2(i))) / R21(i)+ (-(G * m3 * (x1(i)-x3(i))) / R31(i));
    F1y=-(G * m2 * (y1(i)-y2(i))) / R21(i)+ (-(G * m3 * (y1(i)-y3(i))) / R31(i));
    F1z=-(G * m2 * (z1(i)-z2(i))) / R21(i)+ (-(G * m3 * (z1(i)-z3(i))) / R31(i));
    
    F2x=-(G * M1 * (x2(i)-x1(i))) / R21(i) + (-(G * m3 * (x2(i)-x3(i))) / R32(i));
    F2y=-(G * M1 * (y2(i)-y1(i))) / R21(i) + (-(G * m3 * (y2(i)-y3(i))) / R32(i));
    F2z=-(G * M1 * (z2(i)-z1(i))) / R21(i) + (-(G * m3 * (z2(i)-z3(i))) / R32(i));
    
    F3x=-(G * M1 * (x3(i)-x1(i))) / R31(i) + (-(G * m2 * (x3(i)-x2(i))) / R32(i));
    F3y=-(G * M1 * (y3(i)-y1(i))) / R31(i) + (-(G * m2 * (y3(i)-y2(i))) / R32(i));
    F3z=-(G * M1 * (z3(i)-z1(i))) / R31(i) + (-(G * m2 * (z3(i)-z2(i))) / R32(i));
    
    vx1i1_2 = (vx1(i)+(1/2)*F1x*h);
    vy1i1_2 = (vy1(i)+(1/2)*F1y*h);
    vz1i1_2 = (vz1(i)+(1/2)*F1z*h);
   
    vx2i1_2 = (vx2(i)+(1/2)*F2x*h);
    vy2i1_2 = (vy2(i)+(1/2)*F2y*h);
    vz2i1_2 = (vz2(i)+(1/2)*F2z*h);
   
    vx3i1_2 = (vx3(i)+(1/2)*F3x*h);
    vy3i1_2 = (vy3(i)+(1/2)*F3y*h);
    vz3i1_2 = (vz3(i)+(1/2)*F3z*h);
   
    % Aqui se obtiene la posición con la posición anterior sumado a 
    % el intervalo de tiempo multiplicado con la velocidad de n + 1/2
    
    x1(i+1) = x1(i) + vx1i1_2*h;
    y1(i+1) = y1(i) + vy1i1_2*h;
    z1(i+1) = z1(i) + vz1i1_2*h;
    
    x2(i+1) = x2(i) + vx2i1_2*h;
    y2(i+1) = y2(i) + vy2i1_2*h;
    z2(i+1) = z2(i) + vz2i1_2*h;
    
    x3(i+1) = x3(i) + vx3i1_2*h;
    y3(i+1) = y3(i) + vy3i1_2*h;
    z3(i+1) = z3(i) + vz3i1_2*h;

    % Calculamos la nueva distancia ya que sera necesaria para calcular la
    % velocidad del siguiente instante
    
    R21=((x2(i+1)-x1(i+1))^2 + (y2(i+1)-y1(i+1))^2 + (z2(i+1)-z1(i+1))^2)^(3/2); 
    R31=((x3(i+1)-x1(i+1))^2 + (y3(i+1)-y1(i+1))^2 + (z3(i+1)-z1(i+1))^2)^(3/2); 
    R32=((x3(i+1)-x2(i+1))^2 + (y3(i+1)-y2(i+1))^2 + (z3(i+1)-z2(i+1))^2)^(3/2);
    
    vx1(i+1) = vx1i1_2 + (1/2)*F1x*h;
    vy1(i+1) = vy1i1_2 + (1/2)*F1y*h;
    vz1(i+1) = vz1i1_2 + (1/2)*F1z*h;

    vx2(i+1) = vx2i1_2 + (1/2)*F2x*h;
    vy2(i+1) = vy2i1_2 + (1/2)*F2y*h;
    vz2(i+1) = vz2i1_2 + (1/2)*F2z*h;

    vx3(i+1) = vx3i1_2 + (1/2)*F3x*h;
    vy3(i+1) = vy3i1_2 + (1/2)*F3y*h;
    vz3(i+1) = vz3i1_2 + (1/2)*F3z*h;
end
    
%% Graficación de las trayectorias
% Establecemos las caracteristicas que usaremos en la grafica.
hold on 
axis equal
grid on
xlabel("X (millones de km)")
ylabel("Y (millones de km)")
zlabel("Z (millones de km)")
title("Trayectoria de orbita lineal con oscilación")
set(gca,'Color','#1D201F')
ax = gca;
ax.GridColor = '#FFFFFF';

% Graficamos la posición en cada instante con colores que representan a los
% cuerpos celestes
head1 = plot3(x1(1),y1(1),z1(1),'ro','MarkerSize', 6, 'markerfacecolor', '#FF6B6B'); 
head2 = plot3(x2(1),y2(1),z2(1),'ro','MarkerSize', 6, 'markerfacecolor', '#4ECDC4'); 
head3 = plot3(x3(1),y3(1),z3(1),'ro','MarkerSize', 2, 'markerfacecolor', '#F7FFF7'); 

% Aqui se grafican las trayectorias que recorre cada objeto
curve1 = animatedline('Color','#FFFFFF','LineWidth',1,'MaximumNumPoints',1100); 
curve2 = animatedline('Color','#FFFFFF','LineWidth',1,'MaximumNumPoints',1100);
curve3 = animatedline('Color','#FFFFFF','LineWidth',1,'MaximumNumPoints',1100);
hold on;

for i=1:T:length(z1)
    delete(head1);   
    delete(head2);
    delete(head3);   
    addpoints(curve1,x1(i),y1(i),z1(i));
    head1 = scatter3(x1(i),y1(i),z1(i),36,'filled','MarkerFaceColor','#FF6B6B');
    addpoints(curve2,x2(i),y2(i),z2(i));
    head2 = scatter3(x2(i),y2(i),z2(i),36,'filled','MarkerFaceColor','#4ECDC4');
    addpoints(curve3,x3(i),y3(i),z3(i));
    head3 = scatter3(x3(i),y3(i),z3(i),12,'filled','MarkerFaceColor','#F7FFF7');
    drawnow
    
end
hold off

