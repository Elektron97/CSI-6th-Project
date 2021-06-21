%%%%LTR SYNTHESIS%%%

%%%%%%Tuning dei parametri%%%%%%%
%Migliori valori ma richiesta   %
%di controllo non accettabile:  %
%H=10eye(4);    rho=1e-3;       %
%Gamma=B*B'     mu=0.01*eye(4); %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clear all
close all
clc
unstr_unc
%unstr2
%% H e rho che soddisfano le specifiche
%To do: Tuning rho e H
H=eye(4);
rho=0.1;
Phi=inv(s*eye(4)-A);
B=B(:, 1);
HPB=simplify(H*Phi*B);

% %bode di lm per la freq. di taglio
% figure(1)
% margin(lm)
% grid
% %rimane sempre sotto l'asse 0 dB

%Low Frequency
low_freq=simplify(p/(1-lm));
figure(2)
sigma((1/sqrt(rho))*HPB, 'c')
hold on
sigma(low_freq, 'r')
hold off
title('\sigma(1/sqrt(\rho)*H\PhiB) > p/(1-lm)')
legend('1/sqrt(\rho)*H\PhiB','p/(1-lm)')
grid

%High Frequency     Rispettate perchè non ho attraversamento 0dB
HB=H*B;
svds(HB/sqrt(rho),1);
%% LQR design
Q=H'*H;
R=rho;
[Kc,J,CLP] = lqr(G_unc.NominalValue(:, 1), Q, R);

%% Verifico se soddisfo i requisiti
%1/sqrt(rho))*HPB=KPB (low frequency)
KPB=Kc*Phi*B;
figure(3)
sigma(KPB)
hold on
sigma((1/sqrt(rho))*HPB)
title('1/sqrt(\rho))*H\PhiB=K\PhiB')
legend('KPB','1/sqrt(\rho))*H\PhiB')
grid
hold off

%sigma(I+inv(Tlq))>0.5
Tlq=KPB;
figure(4)
sigma(1+inv(Tlq), 'c')
grid 
title('\sigma(I+inv(T_{lq}))>0.5')
legend('\sigma(I+inv(T_{lq})')
hold on
yline(-6, 'r--')
hold off


%sigma(Tlq*inv(1+Tlq))<1/lm
figure(5)
sigma(1/lm)
hold on
sigma(Tlq*inv(1+Tlq))
title('KPB*inv(1+KPB)<1/lm')
legend('1/lm','T_{lq}*inv(1+T_{lq})')
grid
hold off

%% ltrsyn
Gamma =B*B';
mu=0.1*eye(4);
q  = [1 1e5 1e7 1e10]; 

[K_LTR,SVL,W1] = ltrsyn(G_unc.NominalValue(:, 1),Kc,Gamma,mu,q);

T_inp =K_LTR*G_unc.NominalValue(:, 1);

%% Verifica prestazioni
%verifico se sigma(K_LTR*G)=sigma(KPB)
figure(7)
sigma(T_inp,'r')
hold on
sigma(Tlq,'b')
grid 
title('\sigma(K_{LTR}*G)=\sigma(T_{lq})')
legend('T_{inp}','T_{lq}')
hold off

%verifico se sigma(I+inv(T_lq))>1/2
figure(8);
sigma(1 + inv(T_inp)) % >1/2 (-6 dB)
hold on
grid
title('\sigma(I+inv(T_{inp}))>1/2')
legend('I+inv(T_{inp})')
yline(-6, 'r--')
hold off

