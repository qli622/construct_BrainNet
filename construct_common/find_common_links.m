% Qiongge Li - 2017, NYC -

% This code is to find the common modular level network persistent beyond
% inter-subjective variability

% NOTICE: 1) Use this after rename_universal_mod.m 2) function used: adj2edge() 
% INPUT:
% - connectivity matrix M(contains modular connection density) universal
% template


% OUTPUT:
% - common network connectivity matrix M_all, universal template
% - common network connectivity matrix with weight M_avg, universal
% template

%% load individual network and binarize all the matrices
clear all; close all;

M1=importdata('M1.mat');% from subject 1, Mij, i and j are from universal template
M2=importdata('M2.mat');% from subject 2
M3=importdata('M3.mat');% from subject 3
M4=importdata('M4.mat');% from subject 4
M5=importdata('M5.mat');% from subject 5


% create copies
M1_temp=M1;
M2_temp=M2;
M3_temp=M3;
M4_temp=M4;
M5_temp=M5;

% binarize all the matrices. 
M1_temp(find(M1_temp))=1;
M2_temp(find(M2_temp))=1;
M3_temp(find(M3_temp))=1;
M4_temp(find(M4_temp))=1;
M5_temp(find(M5_temp))=1;


%% calculate the common links which appears in all/some of the subjects
M_all=M1_temp + M2_temp + M3_temp + M4_temp + M5_temp;
M_all(M_all<5)=0;% if this link appears 5 out of 5 subjects, accept

M_all=M1_temp + M2_temp + M3_temp + M4_temp + M5_temp;
M_all(M_all<4)=0;% if this link appears 4 out of 5 subjects, accept
%% cal. the common network's weights - average from all the subjects w link activate
[ind_row,ind_col]=find(M_all);
n=10; % num of activated areas in universal template
M_avg=zeros(n);

for i=1:length(ind_row)
   M_avg(ind_row(i),ind_col(i))=(M1(ind_row(i),ind_col(i))+...
       +M2(ind_row(i),ind_col(i))+...
       M3(ind_row(i),ind_col(i))+M4(ind_row(i),ind_col(i))+ ...
        M5(ind_row(i),ind_col(i)))/M_all(ind_row(i),ind_col(i));
end
% NOTE: should divid by the real frequency (how many subjs have
% this links actually appeared)

dlmwrite('average_link_weights_compre_final_map.txt',M_avg, '\t');
M_avg_edge_list=adj2edge(M_avg);
dlmwrite('average_link_weights_compre_final_map_edgelist.txt',M_avg_edge_list, '\t');

%% cal. individual modular network's link weight - universal template
M_edge_list=adj2edge(M5);
dlmwrite('control_5_link_weights_edgelist.txt',M_edge_list, '\t');
% format: mod_i / mod_j / modular_weight(mod_i, mod_j)

