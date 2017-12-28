syms l0 h1 l1 q1 l2 q2 q3 l3 py pz
A = [1 0 0 0; 0 1 0 0; 0 0 1 l0+l1; 0 0 0 1];
B = [1 0 0 0; 0 1 0 h1; 0 0 1 0; 0 0 0 1];
C = [1 0 0 0; 0 cos(q1) -sin(q1) 0; 0 sin(q1) cos(q1) 0; 0 0 0 1];
A01 = A*B*C

A12 = [1 0 0 0; 0 1 0 0; 0 0 1 l2+q2; 0 0 0 1]

E = [1 0 0 0; 0 cos(q3) -sin(q3) 0; 0 sin(q3) cos(q3) 0; 0 0 0 1];
F = [1 0 0 0; 0 1 0 0; 0 0 1 l3; 0 0 0 1];
A23 = E*F

T = simplify(A01*A12*A23)
T(:, 4) = [0; py; pz; 1]
INV1 = simplify(inv(A01))
L1 = simplify(INV1*T)
A13 = simplify(A12*A23)

