%%%%%%%function: getfdt()%%%%

function G=getfdt(G_unc, unc)
us=usubs(G_unc, 'fm', unc);
A=us.NominalValue.A;
B=us.NominalValue.B;
C=us.NominalValue.C;
s=tf('s');
G=simplify(C*inv(s*eye(4)-A)*B);
end

