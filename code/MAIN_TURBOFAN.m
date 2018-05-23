clc; clear; close all;
%% TURBOFAN PARAMETRIC CALCULATION
%{
20/05/2018
%}
%% INPUT - carregar par�metres generals
%Add to path functions folder
addpath('./functions')
% Define input data files
NAME_INPUT_DATA = 'DATA' ; %Fitxer amb dades generals donades
% Load data files
eval(NAME_INPUT_DATA); %Carregar el codi
%% PRE-PROCESSING - Find design optimum parameters PI.f, PI.c, alpha
[ PI, alpha ] = opt_parameters( M0, a0, gam, gc, PI, TAU );
fprintf('The optimum values are: \n pi_f = %.2f\n pi_c = %.2f\n alpha = %.2f\n',...
    PI.f, PI.c,alpha);
% Selector seccions
isMixer = false; % si est� en true col�loca el mixer
isAftBurner = false; % si esta en true calcula l'after burner
isTurboProp = true; % si esta en true col�loca un turboprop
%% PROCESSING - Main code
%Calcul de les etapes del jet:
[T,P,TAU] = Difusor( T,P,TAU,PI );
if isTurboProp
    %exercici 33 - es va seg�int pas a pas
    [PI,P,TAU,T] = CompressorTP( PI,P,gam,T,TAU,ETA);
    [P,f] = CambraCombustioTP( PI,P,CP,TAU,gam,ETA,h,T0,T );
    [T,TAU,PI,P] = TurbinaAltaTP( T,CP,ETA,f,gam,TAU,P,PI);
    [T,TAU,PI,P ] = TurbinaBaixaTP(T,alpha,CP,f,ETA,gam,P,PI,TAU, T0);
    [ T,P,M9 ] = ToveraTP( P0,T,PI,gam,P,TAU );
    [C] = TurboProp(P,PI,gam,ETA,T,TAU, T0, M0 );
    
else
    [P,TAU,T] = Fan( P,PI,gam,ETA,T,TAU );
    [PI,P,TAU,T] = Compressor( PI,P,gam,T,TAU,ETA);
    [P,f] = CambraCombustio( PI,P,CP,TAU,gam,ETA,h,T0 );
    [T,TAU,PI,P] = TurbinaAlta( T,CP,ETA,f,gam,TAU,P,PI);
    [T,TAU,PI,P ] = TurbinaBaixa(T,alpha,CP,f,ETA,gam,P,PI,TAU);
end
%%
%Punts d'entrada a mixer: 1.3 i 5. Punt a la sortida del mixer: 6
if isMixer
    %COMPUTE THE MIXER
    %[ T,P,M6,gam,CP] = mixer(T,P,CP,gam,R,alpha,f);
    [ T, P, M6A, gam, CP] = mixer2(T,P, CP,gam,R, alpha,f, T0, PI, TAU);
    TAU.b=tau2pi(PI.b,gam.mixer);
    TAU.n=tau2pi(PI.n,gam.mixer);
    [ T,P,M9 ] = ToveraPrimari( P0,T,PI,gam,P,TAU,isMixer);
    Fadim = Fadimensional( f,M9,M9,alpha,T,P,gam,isMixer,T0,M0,P0);
else
    P.t6=P.t5;
    T.t6=T.t5;
    TAU.b=tau2pi(PI.b,gam.hot);
    TAU.n=tau2pi(PI.n,gam.hot);
    if ~isTurboProp
        P.t16=P.t13;
        T.t16=T.t13;
        [ T,P,M9 ] = ToveraPrimari( P0,T,PI,gam,P,TAU,isMixer);
        [ T,P,M19] = Toverasecundari( T,PI,P,P0,gam,TAU );
        Fadim = Fadimensional( f,M9,M19,alpha,T,P,gam,isMixer,T0,M0,P0);
    end
    
    %Afegir afterburner
    if isAftBurner
        [ P,f_AB, fab, Fadim_prim_AB, T] = AfterBurner( PI,P,CP,TAU,gam,ETA,h,T0,R, T,f, M9, M0, P0);
        f = f + f_AB;
        %Empenta adimensional total
        Fadim_AB = Fadimensional( f,M9,M19,alpha,T,P,gam,isMixer,T0,M0,P0);
    end
end

if isTurboProp
else
    [ m0,mf,msec ] = Fluxosmasics( f,Fadim,F,a0,alpha);
    %Calcul Arees:
    M5=1;
    m5=m0+mf;
    A.e5 = Area(M5,gam.hot,P.t5,T.t5,R.hot,m5);
end






