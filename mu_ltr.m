%%%%Mu analysis LTR%%%
%          ________         _______
%         |        |       |       |
% ---|----|  Kltr  |-------| G_nom |------>|---->
%    |    |________|       |_______|       |
%    |                                     |
%    |_____________________________________|

looptransfer=loopsens(G_unc(:, 1), K_LTR);
omega=logspace(-3, 6, 200);
clp=looptransfer.Ti;
clp_g=ufrd(clp, omega);

%% Codice dal libro
% robust stability analysis
opt = robopt('Display','on');
[stabmarg,destabu,report,info] = robuststab(clp_g,opt);
report
figure(1)
semilogx(info.MussvBnds(1,1),'r-',info.MussvBnds(1,2),'b--')
grid
title('Robust stability')
xlabel('Frequency (rad/sec)')
ylabel('mu')
legend('\mu-upper bound','\mu-lower bound')


% robust performance
opt = robopt('Display','on');
[perfmarg,perfmargunc,report,info] = robustperf(clp_g,opt);
report
figure(2)
semilogx(info.MussvBnds(1,1),'r-',info.MussvBnds(1,2),'b--')
grid
xlabel('Frequency (rad/sec)')
ylabel('mu')
title('Robust performance')
legend('\mu-upper bound','\mu-lower bound')