%% PAR�METRES GENERALS DONATS
%Thrusts
F=25000; %N

%Velocitat
v0 = 600/3.6; %[m/s] 600

%C�mara combusti�
T.t4=1700;
h=43e6; 

%Condicions ambientals
T0=245;
P0=60000;
rho0=1.225;
Rgas=287;
a0=sqrt(rho0*Rgas*T0);
%     %atmosisa
%     height = 9500; %[m]
%     [T0, a0, P0, rho0] = atmosisa(height);

gam.cold=1.4;
gam.hot=1.4;

CP.hot=1005;
CP.cold=1005;

gc = 1;
%In engineering, gc is a unit conversion factor used to convert mass to force or vice versa

%Par�metres del motor real
PI.d=0.96;
ETA.f=0.98; %Suposici�
ETA.cH=0.98;
PI.b=0.94;
ETA.b=0.99;
ETA.tH=0.87;
ETA.tL=0.87;
PI.n=0.98;
ETA.mec=0.99;

%Calculations
M0 = v0/a0;
T.t0 = T0*(1+(gam.cold-1)/2*M0^2);
P.t0=P0*(1+(gam.cold-1)/2*M0^2)^(gam.cold/(gam.cold-1));
TAU.lamb = T.t4/T0; 
%---------------------
TAU.gam=T.t4/T0; %OJO, �s igual a TAU.lamb?
%---------------------
TAU.r = T.t0/T0;
PI.r=pi2tau(TAU.r,gam.cold);