function coarse_grain( raw_map,sampleratex,sampleratey,sampleratez )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
% 
x=raw_map(:,1);
y=raw_map(:,2);
z=raw_map(:,3);
r=raw_map(:,4);
[row_num, ~]=size(raw_map);


fid=fopen('sampled_map.txt','w');

formatSpec='%d %d %d %f\n';
for row_index=1:row_num
   if x(row_index)~=0 && y(row_index)~=0 && z(row_index)~=0
     if mod(x(row_index),sampleratex)==0 && mod(y(row_index),sampleratey)==0 && ...
            mod(z(row_index),sampleratez)==0
       fprintf(fid,formatSpec,x(row_index),y(row_index),z(row_index),r(row_index));
     end
   end
    
end
fclose(fid);


end

