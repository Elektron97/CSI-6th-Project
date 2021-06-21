%%%Worst Case Perf%%
%          ________         _______
%         |        |       |       |
% ---|----|  Kltr  |-------| G_nom |------>|---->
%    |    |________|       |_______|       |
%    |                                     |
%    |_____________________________________|

looptransfer=loopsens(G_unc(:, 1), K_LTR);
omega=logspace(-3, 6, 200);
clp=looptransfer.Ti;

figure(1)
step(clp)

[maxgain,maxgainunc] = wcgain(clp);
clp_wc = usubs(clp,maxgainunc);
%
% worst case closed-loop singular values
clp_30 = usample(clp,30);
omega = logspace(-2,1,200);
figure(1)
sigma(clp_wc,'r.',clp_30,'b--',omega), grid
axis([10^(-1) 5*10^0 -5 10])
title('Singular value plot of the uncertain closed-loop system')
legend('Worst case','Random samples')