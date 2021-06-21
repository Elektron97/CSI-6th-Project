%focus on G(s)

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

z1=-241.6405;
z2=8.4931;
z3=7.4312;
z4=-8.4931;
z5=-6.5393;
z6=0;
z7=-0.0706;

p1=-2.4164*1e+02;
p2=0.0743*1e+02;
p3=-0.0654*1e+02;
p4=0;

g11=((s-z1)*(s-z2)*(s-z3)*(s+z2)*(s-z5))/((s-p1)^2*(s-p2)^2*(s-p3)^2*s);
g12=g11;
g21=((s-z1)*(s-z3)*(s-z5)*(s-z7))/((s-p1)^2*(s-p2)^2*(s-p3)^2);
g22=g21;
g31=((s-z1)*(s-z2)*(s-z3)*(s+z2)*(s-z5))/((s-p1)^2*(s-p2)^2*(s-p3)^2);
g32=g31;
g41=g21*s;
g42=g41;

Gric=[g11; g21; g31; g41]
