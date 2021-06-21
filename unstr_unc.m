 clear all
% clc

%% Modello
%focus on G(s)
mod_robot
A=G_unc.NominalValue.A;
B=G_unc.NominalValue.B;
C=G_unc.NominalValue.C;
s=tf('s');
G=simplify(C*inv(s*eye(4)-A)*B);
% for i=1:4
%     for j=1:2
%         disp(['Zeri della G', num2str(i), num2str(j)])
%         zero(G(i, j))
%         disp(['Poli della G', num2str(i), num2str(j)])
%         pole(G(i, j))
%     end
% end

%%%%%Dato che la seconda colonna è uguale, Posso scrivere: G(s)=[g1(s) g1(s)]%   
%   Y=g1(s)U1 + g1(s)U2= g1(s)(U1 + U2)                                      %
%   Se prendo U=U1+U2, ottengo un sistema SIMO con G(s) 4x1                  %
%   Inoltre facendo l'SVD della G(s) 4x2, ottengo un modulo del VS ok        %
%   e un altro che è a -300 dB, quindi praticamente 0, proprio per il fatto  %   
%   che ha una colonna l.dipendente dalla prima.                             % 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Ricavo le incertezze

%%%%%%%%Dato che ho una matrice rettangolare, di fatto un vettore,%%%%%%%
%       non posso invertirla e quindi non posso usare la formula        %
%       |G-G_nom|*inv(Gnom) e ricavare sperimentalmente l'incertezza.   %
%       Tuttavia, se prendo W=diag(wi), posso fare questa formula       %
%       sulla singola gi1. Dopo la funzione lm(w) scalare sarà          %
%       l'upper bound del svmax(W).                                     %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

nom_unc=0.0022;
lb_unc=0.00176;
ub_unc=0.00264;
passo=0.0001;
omega=logspace(-3, 6, 200);

g1_nom=getfdt(G_unc(1, 1), nom_unc);
g2_nom=getfdt(G_unc(2, 1), nom_unc);
g3_nom=getfdt(G_unc(3, 1), nom_unc);
g4_nom=getfdt(G_unc(4, 1), nom_unc);

%%%Per ricavare l'upper bound ho usato wfit. In pratica richiami il
%%%programma e ti restituisce una Wm costruita fittando 20 punti che hai
%%%scelto tu a mano con il mouse. 

Wm1=(3.661e-06*s + 8.838)/(s + 373.7);
% for i=lb_unc:passo:ub_unc
%     g1_real=getfdt(G_unc(1, 1), i);
%     figure(1)
%     bodemag((g1_real-g1_nom)/g1_nom, 'c--', omega)
%     hold on
% end
% bodemag(Wm1, 'r', omega)
% %   3.661e-06 s + 8.838
% %   -------------------
% %        s + 373.7


Wm2=(6.145e-07*s + 7.321)/(s + 317.5);
% for i=lb_unc:passo:ub_unc
%     g2_real=getfdt(G_unc(2, 1), i);
%     figure(2)
%     bodemag((g2_real-g2_nom)/g2_nom, 'c--', omega)
%     hold on
% end
%  bodemag(Wm2, 'r', omega)
% %  6.145e-07 s + 7.321
% %   -------------------
% %        s + 317.5

Wm3=(1.98e-06*s + 8.221)/(s + 323.2);
% for i=lb_unc:passo:ub_unc
%     g3_real=getfdt(G_unc(3, 1), i);
%     figure(3)
%     bodemag((g3_real-g3_nom)/g3_nom, 'c--', omega)
%     hold on
% end
%  bodemag(Wm3, 'r', omega)
% %   1.98e-06 s + 8.221
% %   ------------------
% %       s + 323.2

Wm4=(2.269e-06*s + 7.246)/(s + 249.3);
% for i=lb_unc:passo:ub_unc
%     g4_real=getfdt(G_unc(4, 1), i);
%     figure(4)
%     bodemag((g4_real-g4_nom)/g4_nom, 'c--', omega)
%     hold on
% end
% bodemag(Wm4, 'r', omega)
% %   2.269e-06 s + 7.246
% %   -------------------
% %        s + 249.3


W=[Wm1 0 0 0; 0 Wm2 0 0; 0 0 Wm3 0; 0 0 0 Wm4];
lm=(1.425e-06*s + 12.76)/(s + 404.5);
% figure(5)
% sigma(W, 'c--', omega)
% hold on
% sigma(lm, 'r', omega)
% hold off
% % 1.425e-06 s + 12.76
% %   -------------------
% %        s + 404.5

%% Prestazioni
% performance weights
%---------------------
%    1
tol = 0.6*10.0^(-1); % 
nuWp = [0.4  1];     % 
dnWp = [5.0  tol];
gainWp = 0.95*10^(0); % 
Wp11 = gainWp*tf(nuWp,dnWp);
%---------------------
%    2
Wp22 = 0.93; %           
%---------------------
%    3
Wp33 = 0.15; % 
%---------------------
%    4
nuWp = [1.1 1]; 
dnWp = [1.0 1];
gainWp = 0.22*10^(0); % 
Wp44 = gainWp*tf(nuWp,dnWp);

%----------------------------
Wp = [Wp11 0    0   0   ;
      0   Wp22  0   0   ;
      0    0  Wp33  0   ;
      0    0    0  Wp44 ];
 
p=(0.9733*s + 0.3222)/(s + 0.01594);
% figure(6)
% sigma(Wp, 'c--')
% hold on
% sigma(p, 'r')
% hold off
% %   0.9733 s + 0.3222
% %   -----------------
% %      s + 0.01594