% GINO DEL FERRARO - 2017, NYC -

% This code construct the NoN for the brain. 

% INPUT:
% - file NoN_nodes_mod.txt. Structure: NR / x / y / z / correlation / module
% - range of lambda: from highest to lowest value of the range used in Glasso 
% - name of the Jij with lambda max, usually J_1.0000.txt


% OUTPUT:
% It prints the 1) J matrix NoN, 2) J NoN figure, 3) matrix with Kin for each module,
% 4) matrix with kout respect pair of modules, 5) matrix with num of links between pair
% of modules, 6) average kin and average kout, 7) file to pass to CI code to
% compute CI score (NoN_for_CI.txt) , 8) Writes the edges and nodes file to use to plot 
% the network in Gephi (gephi_edges.txt and gephi_nodes.txt). 9) It cleans your house and makes you 
% a cappuccino :)

clear all; close all;

voxel = importdata('NoN_nodes_mod.txt'); 

size_mod = zeros(max(voxel(:,6))+1,2); % vector to store: label cluster / numb of nodes in cluster

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%    COUNT ELEMENTS IN EACH MODULE   %%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


% create an array which contains: label of cluster / numb of nodes in that
% cluster, i.e. size
voxel = sortrows(voxel,6);

mod = 1; % module 1, first module
for i = 1:length(voxel) % from 1 to max number of nodes in NoN
    if voxel(i,6) == mod
        size_mod(mod,1) = mod;
        size_mod(mod,2) = size_mod(mod,2) + 1;
    else
        mod = mod + 1;
        size_mod(mod,1) = mod;
        size_mod(mod,2) = size_mod(mod,2) + 1; 
    end
end

mod_ps = zeros(length(size_mod),1); % partial sum of the module sizes

tot = 0;
for i = 1:length(mod_ps)-1
    tot = tot + size_mod(i,2);
    mod_ps(i) = tot;
end

M = sum(size_mod(:,2)); % size of the final matrix J

% lambda_out is lambda* where all the modules start to connect
lambda_out =0.84;% need to change for each individual
J=importdata('J_0.8400.txt');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% COLOR MAP %%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


J(1:(length(J)+1):end) = 0; % set diagonal to zero

minCor = min(J(:));
maxCor = max(J(:));
if minCor <= 0
    delta = (maxCor+abs(minCor))/256;
    Zero_min = round(abs(minCor)/delta); % zero from the bottom on the colorbar
    Zero_max = round(maxCor/delta); % zero from the top of the colorbar
    step = 1; % space to be left for white color (times two)
    up = Zero_min - step;
    down = Zero_max - step;
    redColorMap = [linspace(0.3, 1,up); zeros(1,up); zeros(1,up)]'; % set red color map
   % greenColorMap = [ zeros(1,down); linspace(1, 0.3, down); zeros(1,down)]';  %set green color map
    
    greenColorMap = flipud(winter(down)); % above zero color map
   % redColorMap = gray(up); % below zero color map
    
    cmap = [redColorMap; white(2*step); greenColorMap]; % set full color map -> red / white / green
    
    
else
   % greenColorMap = [ zeros(1,256); linspace(1, 0., 256); zeros(1,256)]';  %set green color map
   cmap =  flipud(hot(256));
end



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%               FIGURE
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


 cd(outDIR)
 
 figure(1);
 figJ = imagesc(J);



%%%%%%%%  BLOCKS   %%%%%%%%
hold on
orig = 0;
edge = size_mod(1,2);

for i = 1:(length(size_mod)-1)
    
    h(i) = rectangle('position',[orig orig edge edge]);
    set(h(i),'EdgeColor',[0 0 0],'linewidth',2);
    orig = orig + size_mod(i,2);
    edge = size_mod(i+1,2);
    
end

hold on
orig = 0
edge = size_mod(1,2)

for i = 1:(length(size_mod)-1)
    
    h(i) = rectangle('position', [0 orig edge size(J,1)])
    set(h(i),'EdgeColor',[0 0 0],'linewidth',1);
    orig = orig + size_mod(i,2)
    edge = edge + size_mod(i+1,2)
    
end

hold on
orig = 0
edge = size_mod(1,2)

for i = 1:(length(size_mod)-1)
    
    h(i) = rectangle('position', [orig 0 size(J,1) edge])
    set(h(i),'EdgeColor',[0 0 0],'linewidth',1);
    orig = orig + size_mod(i,2)
    edge = edge + size_mod(i+1,2)
    
end


 colormap(cmap);  % set the colorscheme
 colorbar;
 title(name_title, 'FontSize', 15); % set title
 saveas(figJ,'J_NoN.png');
 
 dlmwrite('J_NoN.txt',J,'delimiter','\t');
 
 
 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% COUNT IN AND OUT LINKS
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    
in_link_mod = zeros(max(voxel(:,6)),2); % vector to store: label cluster / av in_degree of cluster
out_link_mod = zeros(max(voxel(:,6)),max(voxel(:,6))); % matrix to store: av out_degree between clustes
N = length(J);



% %% IN-LINKS %%%%%%%%%%%%%%%%%%%

in_link = 0;
out_link = 0;

imin = 1;
imax = size_mod(1,2); % size of first cluster
tot_links = 0;
for mod = 1:max(voxel(:,6)) % from 1 to the max numb of cluster 
    
    in_link_mod(mod,1) = mod;
    for i = imin:imax % within a given block - rows
        
        for j  = imin:imax      % within a given block - columns
            tot_links = tot_links + 1;
            if J(i,j) ~= 0         % if there is a link
                in_link = in_link + 1; % increment the numb of tot inlink
                in_link_mod(mod,2) = in_link_mod(mod,2) + 1;  % increment the numb of inlink in that module
                
            end
        end
    end
    in_link_mod(mod,2) = in_link_mod(mod,2)/size_mod(mod,2)/2; % average degree of cluster 
    imin = imax + 1;    % shift to next block
    imax = imax + size_mod(mod + 1,2);  % shift to next block
end

av_degree_in = in_link/N/2; % average degree inlinks

in_link_mod = in_link_mod';
in_link_mod = [in_link_mod ; repmat(lambda_out,[1,size(in_link_mod,2)])];
in_link_mod = in_link_mod';
 
dlmwrite('matrix_k_in.txt',in_link_mod,'delimiter','\t','precision','%.4f'); % print value of the kin for each module: module / kin / freezing lambda 


% % %% OUTLINKS %%%%%%%%%%%%%%%%%%%%%%%

% rows
imin_b = 1;         % beginning of second module/block

% columns
jmin = 1;
jmax = size_mod(1,2); % end of first block

x = 1;  % x and y are the indexes for the matrix which contains the av degree of outlinks 
y = 2;  % between different blocks

tot_out_link = 0; % number of total outlinks

for x = 1:(max(voxel(:,6)) - 1)
    
    imin_b = imin_b + size_mod(x,2); % beginning of non diagonal module/block
    imin = imin_b;
    imax = imin + size_mod(x+1,2) - 1;
    
    
    for y = (x+1): max(voxel(:,6))
        
        
        for i = imin:imax
            for j = jmin:jmax
                
                if J(i,j) ~= 0         % if there is a link
                    out_link_mod(x,y) = out_link_mod(x,y) + 1; 
                    tot_out_link = tot_out_link + 1;
                end
                
            end
        end
        
        imin = imin + size_mod(y,2); % beginning of next module/block
        imax = imax + size_mod(y+1,2); % end of next module/block
    end
       
       jmin = jmin + size_mod(x,2);
       jmax = jmax + size_mod(x+1,2);
    
end

% % % % % % %
% NORMALIZE the matrix which contains the outlink by the number of nodes in
% each cluster
% % % % % % % 


% Part triangolar above of the matrix -- Module X with Module Y av. degree
% outlinks
for x = 1:length(out_link_mod)
    for y = (x+1):length(out_link_mod)
        OUT(x,y) = out_link_mod(x,y)/size_mod(x,2);
    end
end

% Part triangolar below of the matrix -- Module Y with Module X av. degree
% outlinks



for y = 1:length(out_link_mod)
    for x = (y+1):length(out_link_mod)
        out_link_mod(x,y) = out_link_mod(y,x);
        OUT(x,y) = out_link_mod(x,y)/size_mod(x,2);
    end
end

% Print the matrix and normalized matrix on the output display 
out_link_mod
dlmwrite('matrix_outlinks.txt',out_link_mod,'delimiter','\t'); % print number of outlinks for each module

OUT 
dlmwrite('matrix_k_out.txt',OUT,'delimiter','\t','precision','%.4f'); % print matrix with k out normalized by the n elem in each module


av_deg_out = tot_out_link/N/2;

fileID = fopen('tot_av_kin_kout.txt','w');
fprintf(fileID,'# kin    kout   lambda_out\n');
fprintf(fileID,'%0.4f  %0.4f  %0.4f\n',av_degree_in,av_deg_out,lambda_out);



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% LIST OF NODES FOR CI
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


list_nodes = []; % node i /  node j / type link / module i / module j/ 
row1 = [];
row2 = [];

for i =1:N
    for j = 1:N
        if J(i,j) ~= 0
            if voxel(i,6) == voxel(j,6) % same module, i.e. in-links
                row1 = [row1; voxel(i,1), voxel(j,1), 1, voxel(i,6), voxel(j,6)];  % node i, node j, 1, mod i, mod j
            elseif voxel(i,6) ~= voxel(j,6) % different modules, i.e. out-links
                row2 = [row2; voxel(i,1), voxel(j,1), 2, voxel(i,6), voxel(j,6)]; % node i, node j, 2, mod i, mod j
            end
        
        end
    end
end

list_nodes = [row1; row2]; % list of node above all together; node i, node j, 1 or 2, mod i, mod j

cd(outCI);
dlmwrite('NoN_for_CI.txt',list_nodes,'delimiter','\t');







%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%           GEPHI NETWORK
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


% %%% EDGES %%%%%%%%

cd(outDIR_gephi);

fileID = fopen('gephi_edges.txt','w');
fprintf(fileID,'Source Target Type Attribute\n');

for i = 1:length(list_nodes)
    fprintf(fileID,'%d %d Undirected %d\n',list_nodes(i,1),list_nodes(i,2),list_nodes(i,3)); % node i/  node j / Undirected / type link /
end
fclose(fileID);



% %%% NODES %%%%%%%%

fileID = fopen('gephi_nodes.txt','w');
fprintf(fileID,'Id Node Attribute\n');

for i = 1:N
     fprintf(fileID,'%d %d %d\n',voxel(i,1), voxel(i,1), voxel(i,6)); % node i/  node i / module i
end





