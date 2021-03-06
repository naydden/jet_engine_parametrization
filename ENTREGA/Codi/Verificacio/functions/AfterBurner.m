function [ P,f_AB, fab, Fadim_AB, T] = AfterBurner( PI,P,CP,TAU,gam,ETA,h,T0,R, T,f, M9, M0, P0)
%Pg 455 pdf elements of gass turbines
%data from Exercici43
%% Exercici 43 apartat b
T.t9 = T.t7; %T.t7 es definida a 2400K
P.t9 = PI.n*P.t6; %A pressi� constant

T.s9 = T.t9/(1+(gam.AB-1)/2*M9^2);
TAU.AB = T.t7/T0;
fab = CP.AB*T0/h*1/ETA.AB*(TAU.AB-TAU.t*TAU.lamb);
%f=(CP.hot*TAU.gam-CP.cold*TAU.r*TAU.d*TAU.cH*TAU.f)/((ETA.b*h/T0)-CP.hot*TAU.gam);

P.t9_9 = (1+(gam.AB-1)/2*M9^2)^(gam.AB/(gam.AB-1));
P.s9 = P.t9/(1+(gam.AB-1)/2*M9^2)^(gam.AB/(gam.AB-1));

% Fadim_AB = (1+f+fab)*M9*sqrt(T.s9/T0)-M0;

%% BOOK pg 455 + suposicions ex 43
%compute main parameter
R.AB = (gam.AB - 1)/gam.AB*CP.AB;
TAU.lambAB = CP.AB*T.t7/(CP.cold*T0);
%fuel fraction afterburner definded on pg 453. f_AB = m_fAB/m0
f_AB = (1+f)*(TAU.lambAB-TAU.lamb*TAU.t)/(ETA.AB*h/(CP.cold*T0)-TAU.lambAB);
%Nom�s flux principal amb After Burner falta afegir secundari
Fadim_AB = (1+f+f_AB)*M9-M0+(1+f+f_AB)*(R.AB*T.s9/T0/(R.cold*M9)*(1-P0/P.t9*P.t9_9)/gam.cold);





end

