%downloaded Matlab website
function el=adj2edge(adj)
n=length(adj); % number of nodes
% edges=find(adj>0); % indices of all edges
edges=find(triu(adj~=0));
el=[];
for e=1:length(edges)
[i,j]=ind2sub([n,n],edges(e)); % node indices of edge e  
el=[el; i j adj(i,j)];
el=sortrows(el,1);
end
