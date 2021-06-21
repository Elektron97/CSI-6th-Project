function G=getfdt2(G_unc, unc1, unc2)
us=usubs(G_unc, 'fm', unc1, 'fw', unc2);
A=us.A;
B=us.B;
C=us.C;
s=tf('s');
G=simplify(C*inv(s*eye(4)-A)*B);
end
