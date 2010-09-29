function TwinDisksConstraintForces(uu,tfina)
SolveOrdinaryDifferentialEquations(uu,tfina)
% File  TwinDisksConstraintForces.m  created by Autolev 4.1 on Mon Sep 27 21:24:43 2010



function VAR = ReadUserInput(uu,tfina)
global   gamma m rad;
global   cahat1 cahat2 cahat3 cbhat1 cbhat2 cbhat3 e1 e2 e3 e4 posa1 posa2 posa3 posb1 posb2 posb3 q1 q2 q3 u;
global   l aforce1 aforce2 aforce3 aforcespeed1 aforcespeed2 aforcespeed3 bforce1 bforce2 bforce3 bforcespeed1 bforcespeed2 bforcespeed3 ke pe u3 cahat1p cahat2p cahat3p cbhat1p cbhat2p cbhat3p e1p e2p e3p e4p posa1p posa2p posa3p posb1p posb2p posb3p q1p q2p q3p up;
global   DEGtoRAD RADtoDEG z;
global   TINITIAL TFINAL INTEGSTP PRINTINT ABSERR RELERR;

%-------------------------------+--------------------------+-------------------+-----------------
% Quantity                      | Value                    | Units             | Description
%-------------------------------|--------------------------|-------------------|-----------------
gamma                           =  1;                      % UNITS               Constant
m                               =  2;                      % UNITS               Constant
rad                             =  .1;                     % UNITS               Constant

cahat1                          =  0;                      % UNITS               Initial Value
cahat2                          =  0;                      % UNITS               Initial Value
cahat3                          =  0;                      % UNITS               Initial Value
cbhat1                          = -0.1414214;              % UNITS               Initial Value
cbhat2                          =  0.1414213562373095;     % UNITS               Initial Value
cbhat3                          =  0;                      % UNITS               Initial Value
e1                              =  0.3826834323650898;     % UNITS               Initial Value
e2                              =  0;                      % UNITS               Initial Value
e3                              =  0;                      % UNITS               Initial Value
e4                              =  0.9238795325112867;     % UNITS               Initial Value
posa1                           =  0;                      % UNITS               Initial Value
posa2                           =  0.07071067811865475;    % UNITS               Initial Value
posa3                           =  0.07071067811865477;    % UNITS               Initial Value
posb1                           = -0.1414214;              % UNITS               Initial Value
posb2                           =  0.07071067811865475;    % UNITS               Initial Value
posb3                           =  0.07071067811865477;    % UNITS               Initial Value
q1                              =  0.0;                    % UNITS               Initial Value
q2                              =  0.0;                    % UNITS               Initial Value
q3                              =  0.0;                    % UNITS               Initial Value
u                               =  uu*5.041/3;                % UNITS               Initial Value

TINITIAL                        =  0.0;                    % UNITS               Initial Time
TFINAL                          =  tfina;                  % UNITS               Final Time
INTEGSTP                        =  0.01;                   % UNITS               Integration Step
PRINTINT                        =  1;                      % Positive Integer    Print-Integer
ABSERR                          =  1.0E-08;                %                     Absolute Error
RELERR                          =  1.0E-07 ;               %                     Relative Error
%-------------------------------+--------------------------+-------------------+-----------------

% Unit conversions
Pi       = 3.141592653589793;
DEGtoRAD = Pi/180.0;
RADtoDEG = 180.0/Pi;

% Reserve space and initialize matrices
z = zeros(171,1);

% Evaluate constants
aforcespeed1 = 0;
aforcespeed2 = 0;
aforcespeed3 = 0;
bforcespeed1 = 0;
bforcespeed2 = 0;
bforcespeed3 = 0;
z(1) = m*rad^2;
cahat3p = 0;
cbhat3p = 0;
l = 1.414213562373095*gamma*rad;
z(24) = l^2;

% Set the initial values of the states
VAR(1) = cahat1;
VAR(2) = cahat2;
VAR(3) = cahat3;
VAR(4) = cbhat1;
VAR(5) = cbhat2;
VAR(6) = cbhat3;
VAR(7) = e1;
VAR(8) = e2;
VAR(9) = e3;
VAR(10) = e4;
VAR(11) = posa1;
VAR(12) = posa2;
VAR(13) = posa3;
VAR(14) = posb1;
VAR(15) = posb2;
VAR(16) = posb3;
VAR(17) = q1;
VAR(18) = q2;
VAR(19) = q3;
VAR(20) = u;



%===========================================================================
function OpenOutputFilesAndWriteHeadings
FileIdentifier = fopen('TwinDisksConstraintForces.1', 'wt');   if( FileIdentifier == -1 ) error('Error: unable to open file TwinDisksConstraintForces.1'); end
fprintf( 1,             '%%       t             ke             pe            ke+pe     dot(v_bhat_n>, dot(v_bhat_n>,       e1             e2             e3             e4              u           cahat1         cahat2         cahat3         cbhat1         cbhat2         cbhat3     dot(w_diska_n> dot(w_diska_n> dot(w_diska_n>       q1             q2             q3           aforce1        aforce2        aforce3        bforce1        bforce2        bforce3\n' );
fprintf( 1,             '%%    (UNITS)        (UNITS)        (UNITS)        (UNITS)        (UNITS)        (UNITS)        (UNITS)        (UNITS)        (UNITS)        (UNITS)        (UNITS)        (UNITS)        (UNITS)        (UNITS)        (UNITS)        (UNITS)        (UNITS)        (UNITS)        (UNITS)        (UNITS)        (UNITS)        (UNITS)        (UNITS)        (UNITS)        (UNITS)        (UNITS)        (UNITS)        (UNITS)        (UNITS)\n\n' );
fprintf(FileIdentifier, '%% FILE: TwinDisksConstraintForces.1\n%%\n' );
fprintf(FileIdentifier, '%%       t             ke             pe            ke+pe     dot(v_bhat_n>, dot(v_bhat_n>,       e1             e2             e3             e4              u           cahat1         cahat2         cahat3         cbhat1         cbhat2         cbhat3     dot(w_diska_n> dot(w_diska_n> dot(w_diska_n>       q1             q2             q3           aforce1        aforce2        aforce3        bforce1        bforce2        bforce3\n' );
fprintf(FileIdentifier, '%%    (UNITS)        (UNITS)        (UNITS)        (UNITS)        (UNITS)        (UNITS)        (UNITS)        (UNITS)        (UNITS)        (UNITS)        (UNITS)        (UNITS)        (UNITS)        (UNITS)        (UNITS)        (UNITS)        (UNITS)        (UNITS)        (UNITS)        (UNITS)        (UNITS)        (UNITS)        (UNITS)        (UNITS)        (UNITS)        (UNITS)        (UNITS)        (UNITS)        (UNITS)\n\n' );



%===========================================================================
% Main driver loop for numerical integration of differential equations
%===========================================================================
function SolveOrdinaryDifferentialEquations(uu,tfina)
global   gamma m rad;
global   cahat1 cahat2 cahat3 cbhat1 cbhat2 cbhat3 e1 e2 e3 e4 posa1 posa2 posa3 posb1 posb2 posb3 q1 q2 q3 u;
global   l aforce1 aforce2 aforce3 aforcespeed1 aforcespeed2 aforcespeed3 bforce1 bforce2 bforce3 bforcespeed1 bforcespeed2 bforcespeed3 ke pe u3 cahat1p cahat2p cahat3p cbhat1p cbhat2p cbhat3p e1p e2p e3p e4p posa1p posa2p posa3p posb1p posb2p posb3p q1p q2p q3p up;
global   DEGtoRAD RADtoDEG z;
global   TINITIAL TFINAL INTEGSTP PRINTINT ABSERR RELERR;

OpenOutputFilesAndWriteHeadings
VAR = ReadUserInput(uu,tfina);
OdeMatlabOptions = odeset( 'RelTol',RELERR, 'AbsTol',ABSERR, 'MaxStep',INTEGSTP );
T = TINITIAL;
PrintCounter = 0;
mdlDerivatives(T,VAR,0);
while 1,
  if( TFINAL>=TINITIAL & T+0.01*INTEGSTP>=TFINAL ) PrintCounter = -1; end
  if( TFINAL<=TINITIAL & T+0.01*INTEGSTP<=TFINAL ) PrintCounter = -1; end
  if( PrintCounter <= 0.01 ),
     mdlOutputs(T,VAR,0);
     if( PrintCounter == -1 ) break; end
     PrintCounter = PRINTINT;
  end
  [TimeOdeArray,VarOdeArray] = ode45( @mdlDerivatives, [T T+INTEGSTP], VAR, OdeMatlabOptions, 0 );
  TimeAtEndOfArray = TimeOdeArray( length(TimeOdeArray) );
  if( abs(TimeAtEndOfArray - (T+INTEGSTP) ) >= abs(0.001*INTEGSTP) ) warning('numerical integration failed'); break;  end
  T = TimeAtEndOfArray;
  VAR = VarOdeArray( length(TimeOdeArray), : );
  PrintCounter = PrintCounter - 1;
end
mdlTerminate(T,VAR,0);
% data = load('TwinDisksConstraintForces.1');
% figure(1),plot(data(:,1),data(:,24),data(:,1),data(:,25),data(:,1),data(:,26),data(:,1),data(:,27),data(:,1),data(:,28),data(:,1),data(:,29))
% legend('a1','a2','a3','b1','b2','b3')
% figure(2),plot(data(:,1),data(:,18))
% figure(3),plot(data(:,1),data(:,2))



%===========================================================================
% mdlDerivatives: Calculates and returns the derivatives of the continuous states
%===========================================================================
function sys = mdlDerivatives(T,VAR,u)
global   gamma m rad;
global   cahat1 cahat2 cahat3 cbhat1 cbhat2 cbhat3 e1 e2 e3 e4 posa1 posa2 posa3 posb1 posb2 posb3 q1 q2 q3 u;
global   l aforce1 aforce2 aforce3 aforcespeed1 aforcespeed2 aforcespeed3 bforce1 bforce2 bforce3 bforcespeed1 bforcespeed2 bforcespeed3 ke pe u3 cahat1p cahat2p cahat3p cbhat1p cbhat2p cbhat3p e1p e2p e3p e4p posa1p posa2p posa3p posb1p posb2p posb3p q1p q2p q3p up;
global   DEGtoRAD RADtoDEG z;
global   TINITIAL TFINAL INTEGSTP PRINTINT ABSERR RELERR;

% Update variables after integration step
cahat1 = VAR(1);
cahat2 = VAR(2);
cahat3 = VAR(3);
cbhat1 = VAR(4);
cbhat2 = VAR(5);
cbhat3 = VAR(6);
e1 = VAR(7);
e2 = VAR(8);
e3 = VAR(9);
e4 = VAR(10);
posa1 = VAR(11);
posa2 = VAR(12);
posa3 = VAR(13);
posb1 = VAR(14);
posb2 = VAR(15);
posb3 = VAR(16);
q1 = VAR(17);
q2 = VAR(18);
q3 = VAR(19);
u = VAR(20);
z(8) = 2*e1*e3 - 2*e2*e4;
z(9) = 2*e1*e4 + 2*e2*e3;
z(17) = 1 - z(9)^2;
z(18) = z(17)^0.5;
z(19) = z(9)/z(18);
z(21) = rad*z(19);
z(10) = 1 - 2*e1^2 - 2*e2^2;
z(11) = 1 - z(10)^2;
z(12) = z(11)^0.5;
z(14) = 1/z(12);
z(16) = rad*z(14);
z(20) = 1/z(18);
z(22) = rad*z(20);
z(23) = z(16) - z(22);
z(13) = z(10)/z(12);
z(15) = rad*z(13);
z(25) = z(24) + z(15)^2 + z(21)^2 + z(23)^2 + 2*z(9)*z(21)*z(23) - 2*l*z(8)*z(23) - 2*z(10)*z(15)*z(23);
z(26) = z(25)^0.5;
z(28) = z(23)/z(26);
z(27) = z(15)/z(26);
z(33) = z(10)*z(28) - z(27);
z(42) = z(21)*z(33);
z(29) = l/z(26);
z(31) = z(8)*z(28) - z(29);
z(39) = z(15)*z(31);
z(30) = z(21)/z(26);
z(32) = z(30) + z(9)*z(28);
z(38) = z(15)*z(32);
z(43) = z(21)*z(31);
z(46) = m*(z(8)*z(42)+z(9)*z(39)-z(8)*z(38)-z(10)*z(43));
z(51) = z(32)*u;
z(52) = z(33)*u;
z(75) = z(1)*z(52);
z(74) = z(1)*z(51);
z(84) = 0.5*z(51)*z(75) - 0.25*z(52)*z(74);
z(87) = 0.25*z(51)*z(75) - 0.5*z(52)*z(74);
z(50) = z(31)*u;
z(73) = z(1)*z(50);
z(83) = 0.25*z(52)*z(73) - 0.5*z(50)*z(75);
z(82) = 0.25*z(50)*z(74) - 0.25*z(51)*z(73);
z(85) = 0.5*z(50)*z(74) - 0.25*z(51)*z(73);
z(34) = e2*z(33) + e4*z(31) - e3*z(32);
z(35) = e3*z(31) + e4*z(32) - e1*z(33);
z(54) = (e1*z(34)+e2*z(35))*u;
z(55) = z(10)*z(54)/z(11)^0.5;
z(60) = (z(10)*z(55)+z(12)*z(54))/z(12)^2;
z(56) = rad*z(55)/z(12)^2;
z(37) = e1*z(31) + e2*z(32) + e3*z(33);
z(36) = e1*z(32) + e4*z(33) - e2*z(31);
z(57) = (e1*z(37)-e2*z(36)-e3*z(35)-e4*z(34))*u;
z(58) = z(9)*z(57)/z(17)^0.5;
z(59) = rad*z(58)/z(18)^2;
z(53) = (e1*z(36)+e2*z(37)+e3*z(34)-e4*z(35))*u;
z(61) = (z(9)*z(58)+z(18)*z(57))/z(18)^2;
z(62) = 4*z(15)*z(23)*z(54) + 4*rad*z(10)*z(23)*z(60) + 2*l*z(8)*(2*z(56)-z(59)) + 2*z(10)*z(15)*(2*z(56)-z(59)) - 4*rad*z(15)*z(60) - 2*l*z(23)*z(53) - 2*rad*z(21)*z(61) - 2*z(21)*z(23)*z(57) - 2*rad*z(9)*z(23)*z(61) - 2*z(23)*(2*z(56)-z(59)) - 2*z(9)*z(21)*(2*z(56)-z(59));
z(64) = l*z(62)/(z(25)^0.5*z(26)^2);
z(63) = (z(23)*z(62)/z(25)^0.5+2*z(26)*(2*z(56)-z(59)))/z(26)^2;
z(65) = 0.5*z(64) + z(28)*z(53) - 0.5*z(8)*z(63);
z(66) = u*z(65);
z(77) = z(1)*z(66);
z(67) = (2*rad*z(26)*z(61)+z(21)*z(62)/z(25)^0.5)/z(26)^2;
z(68) = -0.5*z(67) - z(28)*z(57) - 0.5*z(9)*z(63);
z(69) = u*z(68);
z(79) = z(1)*z(69);
z(70) = (4*rad*z(26)*z(60)+z(15)*z(62)/z(25)^0.5)/z(26)^2;
z(71) = 0.5*z(70) - 2*z(28)*z(54) - 0.5*z(10)*z(63);
z(72) = u*z(71);
z(81) = z(1)*z(72);
z(94) = z(15)*z(65) - 2*rad*z(31)*z(60);
z(95) = u*z(94);
z(88) = aforcespeed1 - z(38)*u;
z(108) = z(95) + z(52)*z(88) - aforcespeed3*z(50);
z(5) = 2*e1*e2 + 2*e3*e4;
z(6) = 1 - 2*e1^2 - 2*e3^2;
z(7) = 2*e2*e3 - 2*e1*e4;
z(40) = z(16)*(z(5)*z(31)+z(6)*z(32)+z(7)*z(33));
z(96) = (e3*z(37)-e1*z(35)-e2*z(34)-e4*z(36))*u;
z(97) = (e1*z(34)+e3*z(36))*u;
z(98) = (e1*z(37)+e2*z(36)+e3*z(35)-e4*z(34))*u;
z(99) = -2*(z(5)*z(31)+z(6)*z(32)+z(7)*z(33))*z(56) - z(16)*(z(31)*z(96)+2*z(32)*z(97)-z(5)*z(65)-z(6)*z(68)-z(7)*z(71)-z(33)*z(98));
z(100) = u*z(99);
z(2) = 1 - 2*e2^2 - 2*e3^2;
z(3) = 2*e1*e2 - 2*e3*e4;
z(4) = 2*e1*e3 + 2*e2*e4;
z(41) = z(16)*(z(2)*z(31)+z(3)*z(32)+z(4)*z(33));
z(102) = (e1*z(35)+e2*z(34)+e3*z(37)-e4*z(36))*u;
z(101) = (e2*z(35)+e3*z(36))*u;
z(103) = (e2*z(37)-e1*z(36)-e3*z(34)-e4*z(35))*u;
z(104) = z(16)*(z(2)*z(65)+z(3)*z(68)+z(4)*z(71)+z(32)*z(102)-2*z(31)*z(101)-z(33)*z(103)) - 2*(z(2)*z(31)+z(3)*z(32)+z(4)*z(33))*z(56);
z(105) = u*z(104);
z(92) = z(15)*z(68) - 2*rad*z(32)*z(60);
z(93) = u*z(92);
z(89) = aforcespeed2 + z(39)*u;
z(106) = aforcespeed3*z(51) - z(93) - z(52)*z(89);
z(107) = z(50)*z(89) - z(51)*z(88);
z(113) = z(21)*z(71) - rad*z(33)*z(61);
z(114) = u*z(113);
z(110) = bforcespeed2 - z(43)*u;
z(121) = z(114) + bforcespeed3*z(52) + z(51)*z(110);
z(44) = z(22)*(z(5)*z(31)+z(6)*z(32)+z(7)*z(33));
z(117) = -(z(5)*z(31)+z(6)*z(32)+z(7)*z(33))*z(59) - z(22)*(z(31)*z(96)+2*z(32)*z(97)-z(5)*z(65)-z(6)*z(68)-z(7)*z(71)-z(33)*z(98));
z(118) = u*z(117);
z(45) = z(22)*(z(2)*z(31)+z(3)*z(32)+z(4)*z(33));
z(119) = z(22)*(z(2)*z(65)+z(3)*z(68)+z(4)*z(71)+z(32)*z(102)-2*z(31)*z(101)-z(33)*z(103)) - (z(2)*z(31)+z(3)*z(32)+z(4)*z(33))*z(59);
z(120) = u*z(119);
z(115) = z(21)*z(65) - rad*z(31)*z(61);
z(116) = u*z(115);
z(109) = bforcespeed1 + z(42)*u;
z(122) = -z(116) - bforcespeed3*z(50) - z(51)*z(109);
z(123) = z(50)*z(110) - z(52)*z(109);
z(86) = 0.25*z(50)*z(75) - 0.25*z(52)*z(73);
z(125) = z(31)*z(84) + z(31)*z(87) + z(32)*z(83) + z(33)*z(82) + z(33)*z(85) + 0.5*z(31)*z(77) + 0.75*z(32)*z(79) + 0.75*z(33)*z(81) + m*(z(39)*z(108)+z(40)*z(100)+z(41)*z(105)+z(2)*z(40)*z(106)+z(3)*z(39)*z(100)+z(3)*z(40)*z(108)+z(4)*z(40)*z(107)+z(5)*z(38)*z(105)-z(38)*z(106)-z(2)*z(38)*z(100)-z(5)*z(41)*z(106)-z(6)*z(39)*z(105)-z(6)*z(41)*z(108)-z(7)*z(41)*z(107)) + m*(z(42)*z(121)+z(44)*z(118)+z(45)*z(120)+z(2)*z(42)*z(118)+z(2)*z(44)*z(121)+z(4)*z(44)*z(122)+z(6)*z(45)*z(123)+z(7)*z(43)*z(120)-z(43)*z(122)-z(3)*z(44)*z(123)-z(4)*z(43)*z(118)-z(5)*z(42)*z(120)-z(5)*z(45)*z(121)-z(7)*z(45)*z(122)) - z(32)*z(86);
z(138) = -9.810000000000001*z(46) - z(125);
z(76) = z(1)*z(31);
z(78) = z(1)*z(32);
z(80) = z(1)*z(33);
z(124) = 0.5*z(31)*z(76) + 0.75*z(32)*z(78) + 0.75*z(33)*z(80) + m*(z(38)^2+z(39)^2+z(40)^2+z(41)^2+2*z(3)*z(39)*z(40)+2*z(5)*z(38)*z(41)-2*z(2)*z(38)*z(40)-2*z(6)*z(39)*z(41)) - m*(2*z(4)*z(43)*z(44)+2*z(5)*z(42)*z(45)-z(42)^2-z(43)^2-z(44)^2-z(45)^2-2*z(2)*z(42)*z(44)-2*z(7)*z(43)*z(45));
z(171) = z(138)/z(124);
up = z(171);
e1p = 0.5*z(34)*u;
e2p = 0.5*z(35)*u;
e3p = 0.5*z(36)*u;
e4p = -0.5*z(37)*u;
posa1p = z(4)*aforcespeed3 + z(40)*u + z(3)*(aforcespeed2+z(39)*u) + z(2)*(aforcespeed1-z(38)*u);
posa2p = z(7)*aforcespeed3 + z(6)*(aforcespeed2+z(39)*u) + z(5)*(aforcespeed1-z(38)*u) - z(41)*u;
posa3p = z(10)*aforcespeed3 + z(9)*(aforcespeed2+z(39)*u) + z(8)*(aforcespeed1-z(38)*u);
posb1p = z(44)*u + z(2)*(bforcespeed1+z(42)*u) + z(4)*(bforcespeed2-z(43)*u) - z(3)*bforcespeed3;
posb2p = z(5)*(bforcespeed1+z(42)*u) + z(7)*(bforcespeed2-z(43)*u) - z(6)*bforcespeed3 - z(45)*u;
posb3p = z(8)*(bforcespeed1+z(42)*u) + z(10)*(bforcespeed2-z(43)*u) - z(9)*bforcespeed3;
u3 = z(33)*u;
cahat1p = z(4)*aforcespeed3 + z(40)*u + z(7)*z(16)*(u3-z(33)*u) + z(3)*(aforcespeed2+z(39)*u-z(15)*z(31)*u) - z(5)*z(16)*z(31)*u - z(6)*z(16)*z(32)*u - z(2)*(z(38)*u-aforcespeed1-z(15)*z(32)*u);
cahat2p = z(7)*aforcespeed3 + z(2)*z(16)*z(31)*u + z(3)*z(16)*z(32)*u + z(6)*(aforcespeed2+z(39)*u-z(15)*z(31)*u) - z(41)*u - z(4)*z(16)*(u3-z(33)*u) - z(5)*(z(38)*u-aforcespeed1-z(15)*z(32)*u);
cbhat1p = z(2)*(bforcespeed1+z(42)*u-z(21)*z(33)*u) + (z(44)-z(5)*z(22)*z(31)-z(7)*z(22)*z(33))*u - z(3)*bforcespeed3 - z(4)*(z(43)*u-bforcespeed2-z(21)*z(31)*u);
cbhat2p = z(5)*(bforcespeed1+z(42)*u-z(21)*z(33)*u) - z(6)*bforcespeed3 - z(7)*(z(43)*u-bforcespeed2-z(21)*z(31)*u) - (z(45)-z(2)*z(22)*z(31)-z(4)*z(22)*z(33))*u;
q1p = z(31)*u;
q2p = z(32)*u;
q3p = z(33)*u;

% Update derivative array prior to integration step
VARp(1) = cahat1p;
VARp(2) = cahat2p;
VARp(3) = cahat3p;
VARp(4) = cbhat1p;
VARp(5) = cbhat2p;
VARp(6) = cbhat3p;
VARp(7) = e1p;
VARp(8) = e2p;
VARp(9) = e3p;
VARp(10) = e4p;
VARp(11) = posa1p;
VARp(12) = posa2p;
VARp(13) = posa3p;
VARp(14) = posb1p;
VARp(15) = posb2p;
VARp(16) = posb3p;
VARp(17) = q1p;
VARp(18) = q2p;
VARp(19) = q3p;
VARp(20) = up;

sys = VARp';



%===========================================================================
% mdlOutputs: Calculates and return the outputs
%===========================================================================
function Output = mdlOutputs(T,VAR,u)
global   gamma m rad;
global   cahat1 cahat2 cahat3 cbhat1 cbhat2 cbhat3 e1 e2 e3 e4 posa1 posa2 posa3 posb1 posb2 posb3 q1 q2 q3 u;
global   l aforce1 aforce2 aforce3 aforcespeed1 aforcespeed2 aforcespeed3 bforce1 bforce2 bforce3 bforcespeed1 bforcespeed2 bforcespeed3 ke pe u3 cahat1p cahat2p cahat3p cbhat1p cbhat2p cbhat3p e1p e2p e3p e4p posa1p posa2p posa3p posb1p posb2p posb3p q1p q2p q3p up;
global   DEGtoRAD RADtoDEG z;
global   TINITIAL TFINAL INTEGSTP PRINTINT ABSERR RELERR;

% Evaluate output quantities
ke = 0.375*z(1)*z(33)^2*u^2 + 0.25*z(1)*(z(31)^2+1.5*z(32)^2)*u^2 + 0.5*m*(aforcespeed3^2+z(40)^2*u^2+z(41)^2*u^2+(aforcespeed2+z(39)*u)^2+2*z(4)*z(40)*aforcespeed3*u+(aforcespeed1-z(38)*u)^2+2*z(3)*z(40)*u*(aforcespeed2+z(39)*u)+2*z(2)*z(40)*u*(aforcespeed1-z(38)*u)-2*z(7)*z(41)*aforcespeed3*u-2*z(6)*z(41)*u*(aforcespeed2+z(39)*u)-2*z(5)*z(41)*u*(aforcespeed1-z(38)*u)) + 0.5*m*(bforcespeed3^2+z(44)^2*u^2+z(45)^2*u^2+(bforcespeed1+z(42)*u)^2+2*z(6)*z(45)*bforcespeed3*u+(bforcespeed2-z(43)*u)^2+2*z(2)*z(44)*u*(bforcespeed1+z(42)*u)+2*z(4)*z(44)*u*(bforcespeed2-z(43)*u)-2*z(3)*z(44)*bforcespeed3*u-2*z(5)*z(45)*u*(bforcespeed1+z(42)*u)-2*z(7)*z(45)*u*(bforcespeed2-z(43)*u));
pe = 9.810000000000001*m*(posa3+posb3);
z(147) = z(5)*z(9) - z(6)*z(8);
z(49) = m*z(10);
z(131) = m*(z(107)+z(4)*z(100)-z(7)*z(105));
z(141) = -9.810000000000001*z(49) - z(131);
z(149) = z(6)*z(10) - z(7)*z(9);
z(47) = m*z(8);
z(127) = m*(z(106)+z(2)*z(100)-z(5)*z(105));
z(139) = -9.810000000000001*z(47) - z(127);
z(152) = z(5)*z(10) - z(7)*z(8);
z(48) = m*z(9);
z(129) = m*(z(108)+z(3)*z(100)-z(6)*z(105));
z(140) = -9.810000000000001*z(48) - z(129);
z(145) = z(2)*z(6) - z(3)*z(5);
z(146) = z(2)*z(9) - z(3)*z(8);
z(148) = z(4)*z(147) + z(10)*z(145) - z(7)*z(146);
z(156) = (z(147)*z(141)+z(149)*z(139)-z(152)*z(140))/z(148);
z(128) = m*(z(39)+z(3)*z(40)-z(6)*z(41));
z(126) = m*(z(2)*z(40)-z(38)-z(5)*z(41));
z(130) = m*(z(4)*z(40)-z(7)*z(41));
z(155) = (z(128)*z(152)-z(126)*z(149)-z(130)*z(147))/z(148);
aforce1 = -z(156) - z(155)*up;
z(150) = z(3)*z(10) - z(4)*z(9);
z(153) = z(2)*z(10) - z(4)*z(8);
z(158) = (z(146)*z(141)+z(150)*z(139)-z(153)*z(140))/z(148);
z(157) = (z(128)*z(153)-z(126)*z(150)-z(130)*z(146))/z(148);
aforce2 = z(158) + z(157)*up;
z(151) = z(3)*z(7) - z(4)*z(6);
z(154) = z(2)*z(7) - z(4)*z(5);
z(160) = (z(145)*z(141)+z(151)*z(139)-z(154)*z(140))/z(148);
z(159) = (z(128)*z(154)-z(126)*z(151)-z(130)*z(145))/z(148);
aforce3 = -z(160) - z(159)*up;
z(132) = m*(z(42)+z(2)*z(44)-z(5)*z(45));
z(134) = m*(z(4)*z(44)-z(43)-z(7)*z(45));
z(162) = z(6)*z(8) - z(5)*z(9);
z(136) = m*(z(3)*z(44)-z(6)*z(45));
z(161) = z(6)*z(153) - z(3)*z(152) - z(9)*z(154);
z(165) = (z(132)*z(149)-z(134)*z(162)-z(136)*z(152))/z(161);
z(133) = m*(z(121)+z(2)*z(118)-z(5)*z(120));
z(142) = -9.810000000000001*z(47) - z(133);
z(137) = m*(z(3)*z(118)-z(123)-z(6)*z(120));
z(144) = 9.810000000000001*z(48) + z(137);
z(135) = m*(z(122)+z(4)*z(118)-z(7)*z(120));
z(143) = -9.810000000000001*z(49) - z(135);
z(166) = (z(149)*z(142)+z(152)*z(144)-z(162)*z(143))/z(161);
bforce1 = z(165)*up - z(166);
z(163) = z(3)*z(8) - z(2)*z(9);
z(168) = (z(150)*z(142)+z(153)*z(144)-z(163)*z(143))/z(161);
z(167) = (z(132)*z(150)-z(134)*z(163)-z(136)*z(153))/z(161);
bforce2 = z(168) - z(167)*up;
z(164) = z(3)*z(5) - z(2)*z(6);
z(169) = (z(132)*z(151)-z(134)*z(164)-z(136)*z(154))/z(161);
z(170) = (z(151)*z(142)+z(154)*z(144)-z(164)*z(143))/z(161);
bforce3 = z(169)*up - z(170);

Output(1)=T;  Output(2)=ke;  Output(3)=pe;  Output(4)=ke+pe;  Output(5)=((l*z(2)+z(4)*z(15)-z(3)*z(21))*bforcespeed1*z(5)+(z(6)*z(21)-l*z(5)-z(7)*z(15))*bforcespeed1*z(2)+(l*z(2)+z(4)*z(15)-z(3)*z(21))*bforcespeed2*z(7)+(z(6)*z(21)-l*z(5)-z(7)*z(15))*bforcespeed2*z(4)-(l*z(2)+z(4)*z(15)-z(3)*z(21))*bforcespeed3*z(6)-(z(6)*z(21)-l*z(5)-z(7)*z(15))*bforcespeed3*z(3));  Output(6)=(bforcespeed1*z(8)+bforcespeed2*z(10)-bforcespeed3*z(9));  Output(7)=e1;  Output(8)=e2;  Output(9)=e3;  Output(10)=e4;  Output(11)=u;  Output(12)=cahat1;  Output(13)=cahat2;  Output(14)=cahat3;  Output(15)=cbhat1;  Output(16)=cbhat2;  Output(17)=cbhat3;  Output(18)=(z(31)*u);  Output(19)=(z(32)*u);  Output(20)=(z(33)*u);  Output(21)=q1;  Output(22)=q2;  Output(23)=q3;  Output(24)=aforce1;  Output(25)=aforce2;  Output(26)=aforce3;  Output(27)=bforce1;  Output(28)=bforce2;  Output(29)=bforce3;
FileIdentifier = fopen('all');
% WriteOutput( 1,                 Output(1:29) );
WriteOutput( FileIdentifier(1), Output(1:29) );



%===========================================================================
function WriteOutput( fileIdentifier, Output )
numberOfOutputQuantities = length( Output );
if numberOfOutputQuantities > 0,
  for i=1:numberOfOutputQuantities,
    fprintf( fileIdentifier, ' %- 14.6E', Output(i) );
  end
  fprintf( fileIdentifier, '\n' );
end



%===========================================================================
% mdlTerminate: Perform end of simulation tasks and set sys=[]
%===========================================================================
function sys = mdlTerminate(T,VAR,u)
FileIdentifier = fopen('all');
fclose( FileIdentifier(1) );
fprintf( 1, '\n Output is in the file TwinDisksConstraintForces.1\n' );
fprintf( 1, '\n To load and plot columns 1 and 2 with a solid line and columns 1 and 3 with a dashed line, enter:\n' );
fprintf( 1, '    someName = load( ''TwinDisksConstraintForces.1'' );\n' );
fprintf( 1, '    plot( someName(:,1), someName(:,2), ''-'', someName(:,1), someName(:,3), ''--'' )\n\n' );
sys = [];



%===========================================================================
% Sfunction: System/Simulink function from standard template
%===========================================================================
function [sys,x0,str,ts] = Sfunction(t,x,u,flag)
switch flag,
  case 0,  [sys,x0,str,ts] = mdlInitializeSizes;    % Initialization of sys, initial state x0, state ordering string str, and sample times ts
  case 1,  sys = mdlDerivatives(t,x,u);             % Calculate the derivatives of continuous states and store them in sys
  case 2,  sys = mdlUpdate(t,x,u);                  % Update discrete states x(n+1) in sys
  case 3,  sys = mdlOutputs(t,x,u);                 % Calculate outputs in sys
  case 4,  sys = mdlGetTimeOfNextVarHit(t,x,u);     % Return next sample time for variable-step in sys
  case 9,  sys = mdlTerminate(t,x,u);               % Perform end of simulation tasks and set sys=[]
  otherwise error(['Unhandled flag = ',num2str(flag)]);
end



%===========================================================================
% mdlInitializeSizes: Return the sizes, initial state VAR, and sample times ts
%===========================================================================
function [sys,VAR,stateOrderingStrings,timeSampling] = mdlInitializeSizes
sizes = simsizes;             % Call simsizes to create a sizes structure
sizes.NumContStates  = 20;    % sys(1) is the number of continuous states
sizes.NumDiscStates  = 0;     % sys(2) is the number of discrete states
sizes.NumOutputs     = 29;    % sys(3) is the number of outputs
sizes.NumInputs      = 0;     % sys(4) is the number of inputs
sizes.DirFeedthrough = 1;     % sys(6) is 1, and allows for the output to be a function of the input
sizes.NumSampleTimes = 1;     % sys(7) is the number of samples times (the number of rows in ts)
sys = simsizes(sizes);        % Convert it to a sizes array
stateOrderingStrings = [];
timeSampling         = [0 0]; % m-by-2 matrix containing the sample times
OpenOutputFilesAndWriteHeadings
VAR = ReadUserInput
