clear all
clc
close all

mod_robot
A=G_unc.NominalValue.A;
B=G_unc.NominalValue.B;
C=G_unc.NominalValue.C;
s=tf('s');

nom_unc1=0.0022;
lb_unc1=0.00176;
ub_unc1=0.00264;
nom_unc2=0.0001;
lb_unc2=1.36e-20;
ub_unc2=0.0002;
passo1=0.0001;
passo2=0.5*passo1;
omega=logspace(-3, 6, 200);

g1_nom=getfdt2(G_unc(1, 1), nom_unc1, nom_unc2);
g2_nom=getfdt2(G_unc(2, 1), nom_unc1, nom_unc2);
g3_nom=getfdt2(G_unc(3, 1), nom_unc1, nom_unc2);
g4_nom=getfdt2(G_unc(4, 1), nom_unc1, nom_unc2);

%%%Per ricavare l'upper bound ho usato wfit. In pratica richiami il
%%%programma e ti restituisce una Wm costruita fittando 20 punti che hai
%%%scelto tu a mano con il mouse. 

Wm1=(3.661e-06*s + 8.838)/(s + 373.7);
% for i=lb_unc1:passo1:ub_unc1
%     for j=lb_unc2:passo2:ub_unc2 
%         g1_real=getfdt2(G_unc(1, 1), i, j);
%         figure(1)
%         bodemag((g1_real-g1_nom)/g1_nom, 'c--', omega)
%         hold on
%     end
% end
% bodemag(Wm1, 'r', omega)
% %  2.8215e-06 s + 19.57
% %   -------------------
% %        s + 653.8

Wm2=(1.423e-05*s + 11.94)/(s + 10.43);
% for i=lb_unc1:passo1:ub_unc1
%     for j=lb_unc2:passo2:ub_unc2 
%         g2_real=getfdt2(G_unc(2, 1), i, j);
%         figure(2)
%         bodemag((g2_real-g2_nom)/g2_nom, 'c--', omega)
%         hold on
%     end
% end
% bodemag(Wm2, 'r', omega)
% %   1.423e-05 s + 11.94
% %   -------------------
% %        s + 10.43

Wm3=(1.98e-06*s + 8.221)/(s + 323.2);
% for i=lb_unc1:passo1:ub_unc1
%     for j=lb_unc2:passo2:ub_unc2 
%         g3_real=getfdt2(G_unc(3, 1), i, j);
%         figure(3)
%         bodemag((g3_real-g3_nom)/g3_nom, 'c--', omega)
%         hold on
%     end
% end
% bodemag(Wm3, 'r', omega)

Wm4=1.5*(5.829e-05*s + 4.965)/(s + 5.734);
% for i=lb_unc1:passo1:ub_unc1
%     for j=lb_unc2:passo2:ub_unc2 
%         g4_real=getfdt2(G_unc(4, 1), i, j);
%         figure(4)
%         bodemag((g4_real-g4_nom)/g4_nom, 'c--', omega)
%         hold on
%     end
% end
% bodemag(Wm4, 'r', omega)
% % 1.5*(5.829e-05 s + 4.965)
% %   -------------------
% %        s + 5.734

W=[Wm1 0 0 0; 0 Wm2 0 0; 0 0 Wm3 0; 0 0 0 Wm4];
lm=(0.0001225*s + 28.65)/(s + 15.96);
% figure(5)
% sigma(W, 'c--', omega)
% hold on
% sigma(lm, 'r', omega)
% hold off
% %   0.0001225 s + 28.65
% %   -------------------
% %        s + 15.96

p=(0.9733*s + 0.3222)/(s + 0.01594);