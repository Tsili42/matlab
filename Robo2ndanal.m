clear all
clc

syms q1 q2 q3 l0 l1 l2
%% 1st exercise
% A01 = [cos(q1) -sin(q1) 0 0; sin(q1) cos(q1) 0 0; 0 0 1 l1; 0 0 0 1];
% A01 = simplify(A01 * [1 0 0 0; 0 0 -1 0; 0 1 0 0; 0 0 0 1]);
% 
% A12 = simplify([cos(q2) -sin(q2) 0 0; sin(q2) cos(q2) 0 0; 0 0 1 0; 0 0 0 1] * [1 0 0 0; 0 0 1 0; 0 -1 0 0; 0 0 0 1]);
% 
% A23 = simplify([cos(q3) -sin(q3) 0 0; sin(q3) cos(q3) 0 0; 0 0 1 l2; 0 0 0 1]);
% 
% A02 = simplify(A01*A12);
% 
% A03 = simplify(A01*A12*A23);
% 
% b0 = [0; 0; 1];
% b1 = A01([1:3],[1:3])*b0;
% b2 = A02([1:3],[1:3])*b0;
% 
% r0 = A03([1:3], 4);
% r1 = r0 - A01([1:3], 4);
% r2 = r0 - A02([1:3], 4);
% 
% JL1 = cross(b0, r0);
% JA1 = b0;
% JL2 = cross(b1, r1);
% JA2 = b1;
% JL3 = cross(b2, r2);
% JA3 = b2;
% 
% Jacobian = simplify([JL1 JL2 JL3; JA1 JA2 JA3]);
% firstans = simplify(det(Jacobian([4:6], [1:3])));

%% 2nd exercise
A0to1 = [1 0 0 l1; 0 cos(q1) -sin(q1) l0; 0 sin(q1) cos(q1) 0; 0 0 0 1];
A1to2 = [cos(q2) 0 sin(q2) 0; 0 1 0 0; -sin(q2) 0 cos(q2) 0; 0 0 0 1];
A2to3 = [1 0 0 l2; 0 cos(q3) -sin(q3) 0; 0 sin(q3) cos(q3) 0; 0 0 0 1];

T = simplify(A0to1*A1to2*A2to3);

A0to2 = simplify(A0to1*A1to2);

b0 = [1; 0; 0];
b1 = A0to1([1:3],[1:3])*[0; 1; 0];
b2 = A0to2([1:3],[1:3])*b0;

r0 = T([1:3], 4);
r1 = r0 - A0to1([1:3], 4);
r2 = r0 - A0to2([1:3], 4);

JL1 = cross(b0, r0);
JA1 = b0;
JL2 = cross(b1, r1);
JA2 = b1;
JL3 = cross(b2, r2);
JA3 = b2;

Jacobian = simplify([JL1 JL2 JL3; JA1 JA2 JA3])

singOfLinearVel = simplify(det(Jacobian([1:3], [1:3])));
singOfAngVel = simplify(det(Jacobian([4:6], [1:3])));