clear all; close all;
K = 4; % users
N = 12; % number of antennas
nbrOfMonteCarloRealizations = 2; % assuming it influences size

% K-by-N-by-nMCR
Hk = (randn(K,N,nbrOfMonteCarloRealizations)+1i*randn(K,N,nbrOfMonteCarloRealizations))/sqrt(2);

Hall = functionHk(K,N,nbrOfMonteCarloRealizations);

%{
r4 = openfig("N_4_Random.fig");
r12 = openfig("N_12_Random.fig");
p4 = openfig("N_4_DelayReflect.fig");
p12 = openfig("N_12_DelayReflect.fig");
%}


openfig('N_4_Random.fig','reuse'); % open figure
ax1 = gca; % get handle to axes of figure
openfig('N_12_Random.fig','reuse');
ax2 = gca;
openfig('N_4_DelayReflect.fig','reuse'); % open figure
ax3 = gca; % get handle to axes of figure
openfig('N_12_DelayReflect.fig','reuse');
ax4 = gca;
%close all;

figure(5);
tcl=tiledlayout(2,2);
ax1.Parent=tcl;
ax1.Layout.Tile=1;
ax2.Parent=tcl;
ax2.Layout.Tile=2;
ax3.Parent=tcl;
ax3.Layout.Tile=3;
ax4.Parent=tcl;
ax4.Layout.Tile=4;
ax1.Title = title("N=4, Random Channel");
ax2.Title = title("N=12, Random Channel");
ax3.Title = title("N=4, Path Loss,Delay");
ax4.Title = title("N=12, Path Loss,Delay");