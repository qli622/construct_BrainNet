% Qiongge Li - 2017, NYC -

% This code is to calculate kcore on the individual node-level network
% Notice: 1) Use this code after obtaining all the individual node-level
% networks (or J_NoN.txt file) and obtaining the universal template

% INPUT:
% - file NoN_nodes_mod.txt. Structure: NR / x / y / z / correlation / module
% - file J_NoN.txt is J matrix after fixing lambda, in other words, it is
% the J matrix to build the network
% - file orig_module_order_control_#.txt for original module indx
% - data newkey.mat contains universal module indx


% OUTPUT:
% - control_#_individual_ks_by_mod.txt contains 4 columns:
%   kshell# / normalized kshell# / old_module_indx / universal_module_indx
% - control_#_old2new_template.txt contains the translation
%   from the old module indx to new (or universal) module indx
% Note: 1) the line number of the file indicate the individual node ID
% 2) the normalized kshell# = kshell# /(maximum_kshell# for the individual)
% so kshell# can range from 0-1. The purpose of this scaling is to compare results across
% subjects within the group.
clear all; close all;

NoN=importdata('NoN_nodes_mod.txt');
mod=unique(NoN(:,6));
mod_num=length(mod);
Jmatrix=importdata('J_NoN.txt');
el=adj2edge(Jmatrix);% transform it to edgelist

%% calculate k core number for all the nodes in the network
data=el;
net=data(:,1:2);
ks=kshell(net);

dlmwrite('control_#_individual_kshell.txt',ks,'delimiter','\t');%CHAGE THIS FOR EACH INDIVIDUAL
%% normalized k shell # by each individual
ks_norm=ks/max(ks(:));
ks_mod=[ks ks_norm NoN(:,6) zeros(length(ks_norm(:,1)),1)];
%% translate local module number to universal module label
label_data=importdata('orig_module_order_control_#.txt');%CHAGE THIS!
oldkey=label_data';% change this each time
oldind=(linspace(1,mod_num,mod_num))';
oldmap = containers.Map(oldkey,oldind);

load('newkey.mat');% load universal template

newind=(linspace(1,length(newkey),length(newkey)));% total number of clusters for all healthy subj#
newmap = containers.Map(newkey,newind);

translate=[oldind,zeros(length(oldind),1)];
for i=1:length(oldind)
    s1=oldkey{i};
    s2=newkey;
    tf = strcmp(s1,s2);
    universal_ind=find(tf==1);
    translate(i,2)=universal_ind;%translate: template from old mod ind to new mod ind
end
dlmwrite('control_#_old2new_template.txt',translate,'delimiter','\t');%CHAGE THIS!


for i=1:length(translate(:,1))
    ks_mod(ks_mod(:,3)==translate(i,1),4)=translate(i,2);
end
dlmwrite('control_#_individual_ks_by_mod.txt',ks_mod,'delimiter','\t');%CHAGE THIS!



