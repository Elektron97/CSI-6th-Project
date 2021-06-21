%%%%Test matrice di peso LTR%%%
close all
omega=logspace(-5, 6, 200);
% open-loop connection with the weighting functions
% 2 dof controller
%         
G_unc=G_unc(:, 1);
systemnames    = ' G_unc Wp';
inputvar       = '[ ref{4}; control{1} ]';
outputvar      = '[ Wp; ref; -G_unc]';
input_to_G_unc = '[ control ]';
input_to_Wp    = '[ ref(1:4)-G_unc(1:4)]';  
sys_ic         = sysic;

% closed-loop system
clp_ic = lft(sys_ic, K_LTR);
clp_g = ufrd(clp_ic,omega);


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

% nominal performance
figure(2)
sv = sigma(clp_ic.Nominal,omega);
sys = frd(sv(1,:),omega);
semilogx(sys,'r-')
grid
xlabel('Frequency (rad/sec)')
title('Nominal performance')


% robust performance
opt = robopt('Display','on');
[perfmarg,perfmargunc,report,info] = robustperf(clp_g,opt);
report
figure(3)
semilogx(info.MussvBnds(1,1),'r-',info.MussvBnds(1,2),'b--')
grid
xlabel('Frequency (rad/sec)')
ylabel('mu')
title('Robust performance')
legend('\mu-upper bound','\mu-lower bound')