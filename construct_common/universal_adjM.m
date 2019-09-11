% Qiongge Li - 2017, NYC -

% This code is change each individual network's module indicies from old to new and create new adj
% Matrix (large)

% NOTICE: 1) Use this right after rename_universal_mod.m and before
% find_common_links.m
% INPUT:
% - connectivity matrix Mtemp.mat(contains modular connection density)
%   original module order
% - orig_module_order_control_#.txt
% - universal template - newkey
% - intermodular_link_weights.txt


% OUTPUT:
% - print the original module order for each subject, row # is the original module label
% - save Mtemp_large
clear all; close all;
inDIR_mod = '/control_#/';
cd(inDIR_mod);

newkey={'ANGULAR_L','BA_L','AUDITORY_L','MFG_L','IOA_L','CAUDATE_L','SUPRAMG_L','PREMOTOR_L',...
   'PREMOTOR_L_2','ANGULAR_L','PREMOTOR_R','SUPRAMG_R','CAUDATE_R','IOA_R','MFG_R',...
   'WA_R','BA_R'};
newind=(linspace(1,length(newkey),length(newkey)));% total number of clusters for all healthy subj#
newmap = containers.Map(newkey,newind);

Mtemp=importdata('Mtemp.mat');% adj Matrix with original mod indx
old_el=adj2edge(Mtemp);
oldind=(linspace(1,length(Mtemp),length(Mtemp)))';
data=importdata('orig_module_order_control_#.txt');% change this each time
oldkey=data';% change this each time
oldmap = containers.Map(oldkey,oldind);


modified_el=old_el;

for j=1:length(oldkey)
    row_num=(find(modified_el(:,1)==oldmap(oldkey{j})));
    modified_el(row_num,1)=newmap(oldkey{j})+1000;
end
  
for j=1:length(oldkey)
    row_num=(find(modified_el(:,2)==oldmap(oldkey{j})));
    modified_el(row_num,2)=newmap(oldkey{j})+1000;
end

modified_el=[modified_el(:,1)-1000,modified_el(:,2)-1000, modified_el(:,3)];

new_el=modified_el;

networksize=17;% change this to the size of the new matrix 
Mtemp_large=edge2adj(new_el,networksize);

%% Assign weights again
oldWeightList=importdata('intermodular_link_weights.txt');
newWeightList=oldWeightList; 
for line_num=1:length(newWeightList)
    newWeightList(line_num,1)=newmap(oldkey{newWeightList(line_num,1)});
    newWeightList(line_num,2)=newmap(oldkey{newWeightList(line_num,2)}); 
end
newWeightList2=newWeightList;
dlmwrite('new_intermodular_link_weights.txt',newWeightList2, '\t');
%% save the large adj matrix
save M.mat Mtemp_large % adj Matrix with new universal mod indx

