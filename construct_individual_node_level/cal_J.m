
% Qiongge Li - 2017, NYC -

% This code is Step 1 of the analysis pipeline
% to extract time series from act_map and calculate Jij for diff lambda

% NOTICE: 1) Use this after identifying all the clusters.
% 2) function used: perco_GLasso()
% 3) use linux command [] together of matlab codes.
% INPUT:
% - all_clusters.txt contains concatenated activated voxels from all
% clusters/modules. Structure: x / y / z / module_label 
%

% OUTPUT:
% - print NoN_nodes_mod.txt, Structure: nodeID/x/y/z/act_map correlation/module_label 

% - print act_time_series.txt, line # = nodeID as above, each line is a time series
%   for a node

% - obtain percolation plot and allow selection of lambda*
% - obtain J(lambda*) matrix and J_lambda*.txt

%% extract time series from activated voxels
raw_map=importdata('voxel_stat.txt');
clust_sum=importdata('all_clusters.txt');
[~, ia, ib]=intersect(raw_map(:,1:3), clust_sum(:,1:3),'rows');
clust_map_bf_sort=[raw_map(ia,:),clust_sum(ib,4)];
clust_map_final=sortrows(clust_map_bf_sort,5);
dlmwrite('voxel_corr.txt',clust_map_final,'delimiter','\t');
% [Linux terminal: >> nl voxel_corr.txt > NoN_temp.txt]

NoN=importdata('NoN_temp.txt');
modules=unique(NoN(:,6));
voxels=cell(max(modules),1);

for mod_ind=1:max(modules)
    mod_voxels=NoN(NoN(:,6)==mod_ind,2:4);
    [ sorted_voxels ] = sort_voxels( mod_voxels );
    voxels{mod_ind,:}=sorted_voxels;
end
new_order_voxels=cell2mat(voxels);

new_order_ind=zeros(length(NoN),1);
for i=1:length(new_order_voxels)
    new_order_ind(i,1)=find(NoN(:,2)==new_order_voxels(i,1) & NoN(:,3)==new_order_voxels(i,2)...
        & NoN(:,4)==new_order_voxels(i,3));
end
new_order_NoN=NoN(new_order_ind,:);

dlmwrite('NoN_nodes_mod_new_order_temp.txt',new_order_NoN(:,2:end),'delimiter','\t');

% [Linux terminal: 
% >> nl NoN_nodes_mod_new_order_temp.txt > NoN_nodes_mod_temp.txt
% >> chmod +x extract_act_timeseries.sh
% >> ./extract_act_timeseries.sh NoN_nodes_mod_temp.txt letter.nii act_time_series_temp.txt
% >> awk '($1<=1000){print NR}' act_time_series_temp.txt > outside_brain_lines.txt]

outside_brain_lines=importdata('outside_brain_lines.txt');% delete outside brain areas
NoN_old=importdata('NoN_nodes_mod_temp.txt');
NoN_new=NoN_old;
NoN_new(outside_brain_lines,:)=[];
dlmwrite('NoN_nodes_mod_temp2.txt',NoN_new(:,2:end),'delimiter','\t');
% [Linux terminal: 
% >> nl NoN_nodes_mod_temp2.txt > NoN_nodes_mod.txt]

act_ts_old=importdata('act_time_series_temp.txt');% delete outside brain time series
act_ts_new=act_ts_old;
act_ts_new(outside_brain_lines,:)=[];
dlmwrite('act_time_series.txt',act_ts_new,'delimiter','\t');

%% plot cij percolation and select the lambda
ts=importdata('act_time_series.txt');
ts_T = transpose(ts);
[~,c]=size(ts_T);
Cij_orig = corr(ts_T); % cal. correlation matrix
Cij = Cij_orig;


lambdaList=0.80:0.01:1;
sizeLC=zeros(length(lambdaList),1);
for lambda_ind=1:length(lambdaList)
    lambda=lambdaList(lambda_ind);
 for i=1:length(Cij)
      for j=1:length(Cij)
          if abs(Cij(i,j)) < lambdaList(1,lambda_ind)% threshold Cij
                Cij(i,j) = 0;
                
          end
      end
 end
 [~,sizes,~] = networkComponents(Cij);
 sizeLC(lambda_ind,1)=sizes(1);

 dlmwrite(strcat('C_',num2str(lambda,'%0.4f'),'.txt'),Cij);

end

figure, 
fig=plot(lambdaList, sizeLC/c,'LineWidth',4 );

xlabel('$\lambda$', 'FontSize',35,'Interpreter','latex')
ylabel('$G$','FontSize', 35,'Interpreter','latex')
grid on; 
grid minor;

saveas(fig,'perco_cij.png')

%% calculate Jij by using glasso
pop=ts';
[r,c]=size(pop);
lambdaList=0.85:0.01:0.90;% only run a small range of lambda
[ thetaList,sizeLC ] = perco_GLasso( pop, lambdaList );
figure,
fig=plot(lambdaList, sizeLC/c,'LineWidth',4 );

xlabel('$\lambda$','FontSize',35,'Interpreter','latex')
ylabel('$G$','FontSize', 35,'Interpreter','latex' )
grid on; 
grid minor;

%% write out the Jij matrix for selected lambda
for ind=1:length(lambdaList)
    lambda=lambdaList(ind);
dlmwrite(strcat('J_',num2str(lambda,'%0.4f'),'.txt'),thetaList(:,:,ind));
end
