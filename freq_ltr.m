%%%Risposta in frequenza LTR%%%

%          ________         _______
%         |        |       |       |
% ---|----|  Kltr  |-------| G_nom |------>|---->
%    |    |________|       |_______|       |
%    |                                     |
%    |_____________________________________|

% Kltr=tf(K_LTR);                                           
% G_nom=tf(G_unc.NominalValue(:, 1));
%clp=feedback(Kltr*G_nom, 1);

%Chiusura ad anello:
looptransfer=loopsens(G_unc(:, 1), K_LTR);

%Risposta in frequenza ad anello chiuso
omega=logspace(-3, 6, 100);
clp=looptransfer.Ti;
figure(1)
bodemag(clp, 'c--', omega)
grid
hold on
bodemag(clp.NominalValue, 'r', omega)
title('Closed loop freq. response')
legend('Random unc.', 'Nominal')
hold off

% %Output Sensitivity
% out_sens=looptransfer.So;
% figure(2)
% sigma(out_sens, 'c', omega)
% hold on
% grid 
% sigma(inv(Wp(1,1)), 'r--', omega)
% title('Output Sensitivity and Inverse performance')
% legend('Output Sensitivity', 'inv(Wp)')
% hold off
