% Qiongge Li - 2017, NYC -

% This code generate the connectivity table for all module pairs 
% Copy give summary about mean and stdev of LinkOfInterest
% across individual subjects. 
% NOTICE: 1) Use this after find_common_links.m
% INPUT:
% - file healthy_sub_#_intermodular_num_links_universal.txt
% - file newkey.mat is module universal template
% OUTPUT:
% - full_T: 1st and 2nd cols is module i and module j, col. 3-col. 22 are
% the connectivity for subj. 1-20
% - all_links is the shortened version of full_T, only contains the links of
% our interest. 

clear all; close all;

%% load in the intermodular link weights (universal template label) for each individual
L_1=importdata('healthy_sub_1_intermodular_num_links_universal.txt');
L_2=importdata('healthy_sub_2_intermodular_num_links_universal.txt');
L_3=importdata('healthy_sub_4_intermodular_num_links_universal.txt');
L_4=importdata('healthy_sub_6_intermodular_num_links_universal.txt');
L_5=importdata('healthy_sub_8_intermodular_num_links_universal.txt');
L_6=importdata('healthy_sub_9_intermodular_num_links_universal.txt');
L_7=importdata('healthy_sub_10_intermodular_num_links_universal.txt');
L_8=importdata('healthy_sub_11_intermodular_num_links_universal.txt');
L_9=importdata('healthy_sub_12_intermodular_num_links_universal.txt');

L_10=importdata('control_3_letter_english_intermodular_num_links_universal.txt');
L_11=importdata('control_6_letter_english_intermodular_num_links_universal.txt');
L_12=importdata('control_10_letter_english_intermodular_num_links_universal.txt');
L_13=importdata('control_13_letter_english_intermodular_num_links_universal.txt');
L_14=importdata('control_16_letter_english_intermodular_num_links_universal.txt');
L_15=importdata('control_17_letter_english_intermodular_num_links_universal.txt');
L_16=importdata('control_18_letter_english_intermodular_num_links_universal.txt');
L_17=importdata('control_5_letter_spanish_intermodular_num_links_universal.txt');
L_18=importdata('control_7_letter_spanish_intermodular_num_links_universal.txt');
L_19=importdata('control_8_letter_spanish_intermodular_num_links_universal.txt');
L_20=importdata('control_9_letter_spanish_intermodular_num_links_universal.txt');

L_cat=vertcat(L_1, L_2, L_3, L_4, L_5, L_6, L_7, L_8, L_9, L_10, L_11, L_12,...
  L_13, L_14,L_15, L_16, L_17, L_18, L_19, L_20);
unique_pair=unique(L_cat(:,1:2),'rows');

% Notice: swap the link indicies if the first module label is bigger than the seond one.
% Otherwise, error will happen

L1=L_1;
for row=1:length(L1)
    if L_1(row,1)> L_1(row,2)
        L1(row,1)= L_1(row,2);
        L1(row,2)= L_1(row,1);
    end
end

L2=L_2;
for row=1:length(L2)
    if L_2(row,1)> L_2(row,2)
        L2(row,1)= L_2(row,2);
        L2(row,2)= L_2(row,1);
    end
end


L3=L_3;
for row=1:length(L3)
    if L_3(row,1)> L_3(row,2)
        L3(row,1)= L_3(row,2);
        L3(row,2)= L_3(row,1);
    end
end


L4=L_4;
for row=1:length(L4)
    if L_4(row,1)> L_4(row,2)
        L4(row,1)= L_4(row,2);
        L4(row,2)= L_4(row,1);
    end
end


L5=L_5;
for row=1:length(L5)
    if L_5(row,1)> L_5(row,2)
        L5(row,1)= L_5(row,2);
        L5(row,2)= L_5(row,1);
    end
end


L6=L_6;
for row=1:length(L6)
    if L_6(row,1)> L_6(row,2)
        L6(row,1)= L_6(row,2);
        L6(row,2)= L_6(row,1);
    end
end

L7=L_7;
for row=1:length(L7)
    if L_7(row,1)> L_7(row,2)
        L7(row,1)= L_7(row,2);
        L7(row,2)= L_7(row,1);
    end
end

L8=L_8;
for row=1:length(L8)
    if L_8(row,1)> L_8(row,2)
        L8(row,1)= L_8(row,2);
        L8(row,2)= L_8(row,1);
    end
end


L9=L_9;
for row=1:length(L9)
    if L_9(row,1)> L_9(row,2)
        L9(row,1)= L_9(row,2);
        L9(row,2)= L_9(row,1);
    end
end

L10=L_10;
for row=1:length(L10)
    if L_10(row,1)> L_10(row,2)
        L10(row,1)= L_10(row,2);
        L10(row,2)= L_10(row,1);
    end
end

L11=L_11;
for row=1:length(L11)
    if L_11(row,1)> L_11(row,2)
        L11(row,1)= L_11(row,2);
        L11(row,2)= L_11(row,1);
    end
end

L12=L_12;
for row=1:length(L12)
    if L_12(row,1)> L_12(row,2)
        L12(row,1)= L_12(row,2);
        L12(row,2)= L_12(row,1);
    end
end


L13=L_13;
for row=1:length(L13)
    if L_13(row,1)> L_13(row,2)
        L13(row,1)= L_13(row,2);
        L13(row,2)= L_13(row,1);
    end
end


L14=L_14;
for row=1:length(L14)
    if L_14(row,1)> L_14(row,2)
        L14(row,1)= L_14(row,2);
        L14(row,2)= L_14(row,1);
    end
end


L15=L_15;
for row=1:length(L15)
    if L_15(row,1)> L_15(row,2)
        L15(row,1)= L_15(row,2);
        L15(row,2)= L_15(row,1);
    end
end


L16=L_16;
for row=1:length(L16)
    if L_16(row,1)> L_16(row,2)
        L16(row,1)= L_16(row,2);
        L16(row,2)= L_16(row,1);
    end
end

L17=L_17;
for row=1:length(L17)
    if L_17(row,1)> L_17(row,2)
        L17(row,1)= L_17(row,2);
        L17(row,2)= L_17(row,1);
    end
end

L18=L_18;
for row=1:length(L18)
    if L_18(row,1)> L_18(row,2)
        L18(row,1)= L_18(row,2);
        L18(row,2)= L_18(row,1);
    end
end


L19=L_19;
for row=1:length(L19)
    if L_19(row,1)> L_19(row,2)
        L19(row,1)= L_19(row,2);
        L19(row,2)= L_19(row,1);
    end
end

L20=L_20;
for row=1:length(L20)
    if L_20(row,1)> L_20(row,2)
        L20(row,1)= L_20(row,2);
        L20(row,2)= L_20(row,1);
    end
end
subjN=20;% num. of subjects: CHANGE THIS FOR DIFF ANALYSIS

L_sum=zeros(length(unique_pair),subjN+2);
L_sum(:,1:2)=unique_pair;

[~,ia,ib]=intersect(L_sum(:,1:2),L1(:,1:2), 'rows');
L_sum(ia,2+1)=L1(ib,3);% CHANGE THIS COL TO 2+1

[~,ia,ib]=intersect(L_sum(:,1:2),L2(:,1:2), 'rows');
L_sum(ia,2+2)=L2(ib,3);% CHANGE THIS COL TO 2+2

[~,ia,ib]=intersect(L_sum(:,1:2),L3(:,1:2), 'rows');
L_sum(ia,2+3)=L3(ib,3);

[~,ia,ib]=intersect(L_sum(:,1:2),L4(:,1:2), 'rows');
L_sum(ia,2+4)=L4(ib,3);

[~,ia,ib]=intersect(L_sum(:,1:2),L5(:,1:2), 'rows');
L_sum(ia,2+5)=L5(ib,3);

[~,ia,ib]=intersect(L_sum(:,1:2),L6(:,1:2), 'rows');
L_sum(ia,2+6)=L6(ib,3);

[~,ia,ib]=intersect(L_sum(:,1:2),L7(:,1:2), 'rows');
L_sum(ia,2+7)=L7(ib,3);

[~,ia,ib]=intersect(L_sum(:,1:2),L8(:,1:2), 'rows');
L_sum(ia,2+8)=L8(ib,3);

[~,ia,ib]=intersect(L_sum(:,1:2),L9(:,1:2), 'rows');
L_sum(ia,2+9)=L9(ib,3);


[~,ia,ib]=intersect(L_sum(:,1:2),L10(:,1:2), 'rows');
L_sum(ia,2+10)=L10(ib,3);

[~,ia,ib]=intersect(L_sum(:,1:2),L11(:,1:2), 'rows');
L_sum(ia,2+11)=L11(ib,3);

[~,ia,ib]=intersect(L_sum(:,1:2),L12(:,1:2), 'rows');
L_sum(ia,2+12)=L12(ib,3);

[~,ia,ib]=intersect(L_sum(:,1:2),L13(:,1:2), 'rows');
L_sum(ia,2+13)=L13(ib,3);


[~,ia,ib]=intersect(L_sum(:,1:2),L14(:,1:2), 'rows');
L_sum(ia,2+14)=L14(ib,3);

[~,ia,ib]=intersect(L_sum(:,1:2),L15(:,1:2), 'rows');
L_sum(ia,2+15)=L15(ib,3);

[~,ia,ib]=intersect(L_sum(:,1:2),L16(:,1:2), 'rows');
L_sum(ia,2+16)=L16(ib,3);

[~,ia,ib]=intersect(L_sum(:,1:2),L17(:,1:2), 'rows');
L_sum(ia,2+17)=L17(ib,3);

[~,ia,ib]=intersect(L_sum(:,1:2),L18(:,1:2), 'rows');
L_sum(ia,2+18)=L18(ib,3);

[~,ia,ib]=intersect(L_sum(:,1:2),L19(:,1:2), 'rows');
L_sum(ia,2+19)=L19(ib,3);


[~,ia,ib]=intersect(L_sum(:,1:2),L20(:,1:2), 'rows');
L_sum(ia,2+20)=L20(ib,3);
%% normalize each link by it's largest value in each individual
L_sum_norm=zeros(length(L_sum),20);
for i=1:20
    L_sum_norm(:,i)=L_sum(:,i+2)/max(L_sum(:,i+2));
end
L_list=L_sum_norm(:);
L_list_nonzero=L_list(L_list~=0,:);
dlmwrite('all_link_nums_list_nonzero.txt',L_list_nonzero);
%% find the labels of the each areas, generate the table: full_T
% - the first 2 cols. are the connected module pairs
% - the 3-22 cols. are 20 subjects

A_cell = cellstr(num2str(L_sum(:,1)));
B_cell = cellstr(num2str(L_sum(:,2)));

T = array2table(L_sum(:,3:end),...
    'VariableNames',{'Subj1', 'Subj2',...
    'Subj3', 'Subj4','Subj5', 'Subj6','Subj7', 'Subj8','Subj9',...
    'Subj10','Subj11', 'Subj12',...
    'Subj13', 'Subj14','Subj15', 'Subj16','Subj17', 'Subj18','Subj19','Subj20'});


newkey=load('newkey.mat');% load all the areas ever shown in all individual network
ticketMap = containers.Map(...
    {' 1', ' 2', ' 3', ' 4',' 5', ' 6', ' 7', ' 8',' 9', '10', '11', '12','13',...
    '14', '15', '16','17', '18', '19','20','21','22'}, ...
    newkey.newkey);


col1=values(ticketMap, A_cell(:,1));
col2=values(ticketMap, B_cell(:,1));
T1=cell2table(col1);% 1st module
T2=cell2table(col2);% 2nd module
full_T=[T1, T2, T];% cat the tables together


%% for links of interest (the ones in common network)
% (associated with modules of Interest(that are in the common network), i.e. module - 13, 16, 19, 21, 22)
% all_links is the shortened version of full_T, only contains the links of
% our interest. 

AOI1=values(ticketMap, {'13'});
AOI2=values(ticketMap, {'16'});
AOI3=values(ticketMap, {'19'});
AOI4=values(ticketMap, {'21'});
AOI5=values(ticketMap, {'22'});

u1 = full_T(strcmp(full_T.col1, AOI1), :);
v1 = u1(strcmp(u1.col2, AOI2), :);
w1 = u1(strcmp(u1.col2, AOI3),:);
x1 = u1(strcmp(u1.col2, AOI4),:);
y1 = u1(strcmp(u1.col2, AOI5),:);

link1=[v1;w1;x1;y1];

 
AOI1=values(ticketMap, {'16'});
AOI2=values(ticketMap, {'19'});
AOI3=values(ticketMap, {'21'});
AOI4=values(ticketMap, {'22'});

u1 = full_T(strcmp(full_T.col1, AOI1), :);
v1 = u1(strcmp(u1.col2, AOI2), :);
w1 = u1(strcmp(u1.col2, AOI3),:);
x1 = u1(strcmp(u1.col2, AOI4),:);

link2=[v1;w1;x1];
 
AOI1=values(ticketMap, {'19'});
AOI2=values(ticketMap, {'21'});
AOI3=values(ticketMap, {'22'});


u1 = full_T(strcmp(full_T.col1, AOI1), :);
v1 = u1(strcmp(u1.col2, AOI2), :);
w1 = u1(strcmp(u1.col2, AOI3),:);


link3=[v1;w1];

AOI1=values(ticketMap, {'21'});
AOI2=values(ticketMap, {'22'});

u1 = full_T(strcmp(full_T.col1, AOI1), :);
v1 = u1(strcmp(u1.col2, AOI2), :);


link4=v1;

all_links=[link1;link2;link3;link4];

