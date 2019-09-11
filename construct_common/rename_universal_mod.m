% Qiongge Li - 2017, NYC -

% This code is to name the modules in each subject in the original order
% and from it, create collective modules in all subjects - universal module
% template

% NOTICE: 1) Use this after rename_universal_mod.m 2) function used: adj2edge() 
% INPUT:
% - connectivity matrix Mtemp.mat(contains modular connection density)
%   original module order
% - manually input the module name (i.e. BA_L stands for Broca's Area Left)
%   with original module order at oldkey#_A, each subject have diff numbers
%   of modules


% OUTPUT:
% - print the original module order for each subject, row # is the original module label
%   orig_module_order_control_#.txt
% - print the universal module order for all subjects, row # is the universal module label
%   new_module_order_universal.txt universal template
%% control 1 --total num clusters: 7
clear all; close all; 
inDIR_mod = '~/control_1';
cd(inDIR_mod); % move to module file folder
Mtemp=importdata('Mtemp.mat');
old_el=adj2edge(Mtemp);
oldind=(linspace(1,7,7))';% number of activated clusters for healthy subj#
oldkey1_A={'BA_L', 'MFG_L','PREMOTOR_L','PREMOTOR_L_2','SUPRAMG_L','SMA','PREMOTOR_R'};
oldmap = containers.Map(oldkey1_A,oldind);


filePh = fopen('orig_module_order_control_1.txt','w');
fprintf(filePh,'%s\n',oldkey1_A{:});
fclose(filePh);
%% control 2 --total num clusters: 8
clear all; close all;
inDIR_mod = '~/control_2';
cd(inDIR_mod); % move to module file folder
Mtemp=importdata('Mtemp.mat');
old_el=adj2edge(Mtemp);
oldind=(linspace(1,8,8))';% number of activated clusters for healthy subj#
oldkey2_A={'PREMOTOR_L','MFG_L','BA_L','WA_L', 'SUPRAMG_L','SMA','MFG_R','SUPRAMG_R'};
oldmap = containers.Map(oldkey2_A,oldind);
newkey=load('newkey.mat');

filePh = fopen('orig_module_order_control_2.txt','w');
fprintf(filePh,'%s\n',oldkey2_A{:});
fclose(filePh);

%% control 3 --total num clusters: 4
clear all; close all; 
inDIR_mod = '~/control_3';
cd(inDIR_mod); % move to module file folder
Mtemp=importdata('Mtemp.mat');
old_el=adj2edge(Mtemp);
oldind=(linspace(1,4,4))';% number of activated clusters for healthy subj#
oldkey3_A={'BA_L','PREMOTOR_L','SMA','WA_R'};
oldmap = containers.Map(oldkey3_A,oldind);
newkey=load('newkey.mat');

filePh = fopen('orig_module_order_control_3.txt','w');
fprintf(filePh,'%s\n',oldkey3_A{:});
fclose(filePh);

%% control 4 --total num clusters: 7
clear all; close all; 
inDIR_mod = '~/control_4';
cd(inDIR_mod); % move to module file folder
Mtemp=importdata('Mtemp.mat');
old_el=adj2edge(Mtemp);
oldind=(linspace(1,7,7))';% number of activated clusters for healthy subj#
oldkey4_A={'BA_L', 'PREMOTOR_L','PREMOTOR_L_2', 'WA_L','SUPRAMG_L','ANGULAR_L','SMA'};
oldmap = containers.Map(oldkey4_A,oldind);
newkey=load('newkey.mat');

filePh = fopen('orig_module_order_control_4.txt','w');
fprintf(filePh,'%s\n',oldkey4_A{:});
fclose(filePh);


%% control 5 --total num clusters: 4
clear all; close all; 
inDIR_mod = '~/control_5';
cd(inDIR_mod); % move to module file folder
Mtemp=importdata('Mtemp.mat');
old_el=adj2edge(Mtemp);
oldind=(linspace(1,4,4))';% number of activated clusters for healthy subj#
oldkey5_A={'BA_L', 'PREMOTOR_L','SMA','WA_R'};
oldmap = containers.Map(oldkey5_A,oldind);
newkey=load('newkey.mat');

filePh = fopen('orig_module_order_control_5.txt','w');
fprintf(filePh,'%s\n',oldkey5_A{:});
fclose(filePh);


%% New (universal) template for all 5 subjects
catkey=cat(2, oldkey1_A, oldkey2_A, oldkey3_A,...
    oldkey4_A, oldkey5_A);
newkey=unique(catkey);
save newkey.mat newkey;% new (universal) template saved
newind=(linspace(1,length(newkey),length(newkey)));
% total number of clusters across all subjects
newmap = containers.Map(newkey,newind);

filePh = fopen('new_module_order_universal.txt','w');
fprintf(filePh,'%s\n',newkey{:});
fclose(filePh);

