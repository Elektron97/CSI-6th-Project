%%%%%Controllore in cascata%%%%

looptransfer=loopsens(G_unc(:, 1), K_LTR);
omega=logspace(-3, 6, 200);
clp=looptransfer.Ti;

k=10;
T=0.01;


C=k*(1+(1/(T*s)));
clp2=feedback(C*clp, 1);
clp_g=ufrd(clp2, omega);
figure(2)
step(clp2)
grid
disp(['K=', num2str(k), ' T=', num2str(T)])

%% Mu analysis
% robust stability analysis
opt = robopt('Display','on');
[stabmarg,destabu,report,info] = robuststab(clp_g,opt);
report
figure(3)
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
figure(4)
semilogx(info.MussvBnds(1,1),'r-',info.MussvBnds(1,2),'b--')
grid
xlabel('Frequency (rad/sec)')
ylabel('mu')
title('Robust performance')
legend('\mu-upper bound','\mu-lower bound')

