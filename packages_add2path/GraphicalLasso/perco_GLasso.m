function [ thetaList,sizeLC ] = perco_GLasso( pop, lambdaList )
% This function is to utilize Glasso algorithm to infer diff Jij under diff
% penalty parameter lambda. 
% INPUT: pop -timeseries list for each node. lambdaList -A series of lambda
% values. 
% OUTPUT: thetaList - Jij adjcency matrix under each penalty parameter
% sizeLC - num of nodes contains largest connected component(or Giant Component)
% Neccesary Matlab Package to add into path: networkComponents.m
% this package can be found in the following link: 
% https://www.mathworks.com/matlabcentral/fileexchange/42040-find-network-components


% TIPs on running this code: Since this code is computational comsuming,
% suggest to run a coarse curve with large step size in lambdaList such as 
% 0.1 for lambda  ∈ [0,1], and estimate where the jump would be. Then, 
% switch to a smaller step size such as 0.001 for a short range lambdaList
% i.e. lambda ∈ [0.8,1]. 
tot=length(lambdaList);
[~, thetaList] = GraphicalLassoPath(pop, lambdaList);
sizeLC=zeros(1,tot);
for ind=1:tot
    Jij=thetaList(:,:,ind);
    [r,c]=size(Jij);
    for i=1:r
        for j=1:c
            if abs(Jij(i,j))<10^(-4) % ignore links with Jij value < 10^(-4)
               Jij(i,j)=0;
            end
        end
    end
    [~,sizes,~] = networkComponents(Jij);
    %networkComponents.m is utilized: ...
    % this auto-detect the communities within the network
    sizeLC(ind)=sizes(1); %size of the largest connected component ...
    % (or num of nodes contains in the Giant Component)
end

end

