clear all;

%% Forward kinematics
syms q1 q2 q3 q4 l1 l2 l3

Rotz1 = [cos(degtorad(q1)) -sin(degtorad(q1)) 0 0; sin(degtorad(q1)) cos(degtorad(q1)) 0 0; 0 0 1 0; 0 0 0 1];
Traz1 = [1 0 0 0; 0 1 0 0; 0 0 1 l1; 0 0 0 1];
Trax1 = [1 0 0 l2; 0 1 0 0 ; 0 0 1 0; 0 0 0 1];
Rotx1 = eye(4);
A0to1 = Rotz1*Traz1*Trax1*Rotx1;

Rotz2 = [cos(degtorad(q2)) -sin(degtorad(q2)) 0 0; sin(degtorad(q2)) cos(degtorad(q2)) 0 0; 0 0 1 0; 0 0 0 1];
Traz2 = eye(4);
Trax2 = [1 0 0 l3; 0 1 0 0; 0 0 1 0; 0 0 0 1];
Rotx2 = [1 0 0 0; 0 -1 0 0; 0 0 -1 0; 0 0 0 1];
A1to2 = Rotz2*Traz2*Trax2*Rotx2;

Rotz3 = [cos(degtorad(q3)) -sin(degtorad(q3)) 0 0; sin(degtorad(q3)) cos(degtorad(q3)) 0 0; 0 0 1 0; 0 0 0 1];
Traz3 = eye(4);
Trax3 = eye(4);
Rotx3 = eye(4);
A2to3 = Rotz3*Traz3*Trax3*Rotx3;

Rotz4 = eye(4);
Traz4 = [1 0 0 0; 0 1 0 0; 0 0 1 q4; 0 0 0 1];
Trax4 = eye(4);
Rotx4 = eye(4);
A3to4 = Rotz4*Traz4*Trax4*Rotx4;

%Forward kinematics model
T = simplify(A0to1*A1to2*A2to3*A3to4);

%% Forward differential kinematics

%Construct Jacobian matrix from each joint's contibution (see@lectureNotes:kinematics2-pg.8)
A0to2 = simplify(A0to1*A1to2);
A0to3 = simplify(A0to2*A2to3);

b0 = [0; 0; 1];
b1 = A0to1([1:3],[1:3])*b0;
b2 = A0to2([1:3],[1:3])*b0;
b3 = A0to3([1:3],[1:3])*b0;

r0 = T([1:3], 4);
r1 = r0 - A0to1([1:3], 4);
r2 = r0 - A0to2([1:3], 4);
r3 = r0 - A0to3([1:3], 4);

JL1 = cross(b0, r0);
JA1 = b0;
JL2 = cross(b1, r1);
JA2 = b1;
JL3 = cross(b2, r2);
JA3 = b2;
JL4 = b3;
JA4 = zeros(3,1);

Jacobian = simplify([JL1 JL2 JL3 JL4; JA1 JA2 JA3 JA4]); %calculate Jacobian
Jacobian([4,5],:) = [] %remove zero rows
simplify(det(Jacobian))