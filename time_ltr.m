%%%Transient Response%%
%          ________         _______
%         |        |       |       |
% ---|----|  Kltr  |-------| G_nom |------>|---->
%    |    |________|       |_______|       |
%    |                                     |
%    |_____________________________________|
close all
looptransfer=loopsens(G_unc(:, 1), K_LTR);
clp_ic=looptransfer.Ti;

figure(1)
step(gridureal(clp_ic, 50), 'c--')
hold on
grid
step(clp_ic.NominalValue, 'r')
legend('50 samples unc', 'Nominal Response')
hold off