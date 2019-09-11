%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
ANALYZING BY THE FOLLOWING: 
Place the language model (language_model.1D in data example) in the same folder of the functional and structural nii files.
1. Write out coordinates file from AFNI files:
linux command: 3dmaskdump Clust_mask_000*+orig. > voxel.txt
voxel.txt is a temp file, each line contains infor. for each voxel involved
each line maintain the following format: 
x/y/z/clust_label
where x, y, z stands for the coordinates of each voxel;
clust_label=* means voxels belong to cluster *
clust_label=0 means voxels belong to no clusters 
2. Select the voxels only belong to a certain cluster * and rename
this cluster * to a new cluster number **
linux command: awk '($4==*){print $1, $2, $3, "**"}' voxel.txt > voxel_rename_clust_**.txt
3. Cat all the renamed cluster files into one. 
linux command: cat voxel_rename_clust* > voxel_rename_clust_summary.txt
>> cp voxel_rename_clust_summary.txt Brain_Maps/atlas_452/

4. OPTION: if some of the clusters need to be manually seperated, i.e.
clust need to seperated according to y axis
can use the following: 
>> awk '($4==*){print $1, $2, $3, "**"}' voxel.txt > voxel_rename_clust_temp.txt
>> awk '($2>y_cutoff){print $1, $2, $3, "*"}' voxel_rename_clust_temp.txt > voxel_rename_clust_**.txt
>> awk '($2<=y_cutoff){print $1, $2, $3, "*"}' voxel_rename_clust_temp.txt > voxel_rename_clust_**.txt
************************************************************************
Add GraphicalLasso package to the path and then paste extract_act_timeseries.sh in the folder and proceed as follows:

1. Extract activation map using the following 
AFNI command line: 3dAFNItoNIFTI -prefix act_map.nii letter.nii@1+orig

OR 	3dAFNItoNIFTI -prefix act_map_tlrc.nii letter.nii@1+tlrc

AFNI command line: 3dmaskdump act_map.nii'[2]' > voxels_stat.txt

OR 	3dmaskdump act_map_tlrc.nii'[2]' > voxel_stat.txt 

2. Now, construct individual node level network
Use 1) cal_J.m and then 2) NoN_construction_GC_one_lambda.m

3. Then, construct individual module level network
Use assign_weight.m

4. Now, construct the common network
Use 1) rename_universal_mod.m 2) universal_adjM.m and 3) find_common_links.m 
extra code to generate the full connectivity table, use generate_connectivity_num_links_table.m

5. calculate k shells of individual node-level network, grouped by modules

Use cal_individual_node_kcore.m




