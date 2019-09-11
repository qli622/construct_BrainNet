% Qiongge Li - 2017, NYC -

% This code assigns weights to the inter-modular links(individual modular level network) 
% Notice: 1) Use this code after running NoN_construction_GC_one_lambda.m
% 2)The module label order is original instead of universal.

% INPUT:
% - file NoN_nodes_mod.txt. Structure: NR / x / y / z / correlation / module
% - file matrix_outlinks.txt is matrix which element Mij is num of outlinks between
% module pair i and j



% OUTPUT:
% It saves the matrix Mtemp which element Mtemp(i,j), which is also
% printed as file:intermodular_link_weights.txt 
% contains the intermodular-link weights between module i an module j.

clear all; close all;
M_links=importdata('matrix_outlinks.txt');
NoN=importdata('NoN_nodes_mod.txt');%count number of nodes in each module
n=length(M_links);
mod_size=zeros(n,1);
fileID=fopen('intermodular_link_weights.txt','w');
formatspec='%d %d %f\n';

for i=1:n
    mod_size(i,1)=length(NoN(NoN(:,6)==i));
end

mod_link_weights=zeros(n);
for i=1:n
    for j=(i+1):n
        mod_link_weights(i,j)=M_links(i,j)/(mod_size(i,1)+mod_size(j,1));
        % weights=number of links/sum of module i'size and module j's size
    end
end


Mtemp=mod_link_weights+mod_link_weights';

save Mtemp.mat Mtemp
 



        
