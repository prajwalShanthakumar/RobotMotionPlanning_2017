clear all;
clc;

%_____________________________SCANNING FILE___________________________
fileID = fopen('input.txt','r');
C = textscan(fileID,'%d',3)     % C is a single array (box) which contains 3 integers 
num_nodes = C{1}(1);
start_node = C{1}(2);
end_node = C{1}(3);
D = textscan(fileID,'%d %d %f') % scanning the rest of the file for edge weights
Origin = D{1};
Termination = D{2};
Weight = D{3};


%________________________CREATING EDGE_MATRIX__________________________
edge_matrix = inf(num_nodes,num_nodes);
for i = 1:num_nodes
    edge_matrix(i,i) = 0;       % if origin and destination are the same, weight is 0
end
for i = 1:size(Origin)
    edge_matrix(Origin(i),Termination(i)) = Weight(i);
end


%________________________INITIALIZING COST_TO_GO_MATRIX AND BEST_NEIGHBOUR_MATRIX____________
cost_to_go_matrix = inf(num_nodes,num_nodes);
cost_to_go_matrix(end_node,num_nodes) = 0;
best_neighbour = inf(1,num_nodes);
best_neighbour(end_node) = 0;

%scan = textscan(fileID, '%s', 'Delimiter','\n');

% num_nodes = 4;
% start_node = 1;
% end_node = 3;
% edge_matrix = [0,10000,100,inf; inf,0,inf,1; inf,inf,0,100; inf,inf,inf,0];
%cost_to_go_matrix = inf(num_nodes,num_nodes);
%cost_to_go_matrix(end_node,num_nodes) = 0;
% best_neighbour = inf(1,num_nodes);
% best_neighbour(end_node) = 0;

for column_loop = (num_nodes-1):-1:1
    for each_entry_in_column_loop = 1:num_nodes
        costs = inf(1,num_nodes);
        for each_entry_in_column_to_the_right = 1:num_nodes
            costs(each_entry_in_column_to_the_right) = edge_matrix(each_entry_in_column_loop, each_entry_in_column_to_the_right) + cost_to_go_matrix(each_entry_in_column_to_the_right,column_loop+1);
        end 
    [new_cost,new_neighbour] = min(costs);
    cost_to_go_matrix(each_entry_in_column_loop,column_loop) = new_cost;
    if(new_cost < cost_to_go_matrix(each_entry_in_column_loop,column_loop+1))
        %cost_to_go_matrix(each_entry_in_column_loop,column_loop) = new_cost;
        best_neighbour(each_entry_in_column_loop) = new_neighbour;
        
    end
    %if(best_neighbour_candidate ~= each_entry_in_column_loop)
        %best_neighbour(each_entry_in_column_loop) = best_neighbour_candidate;
    %end
    end    
end
index = start_node;
i = 1;

while(index ~= end_node)
path(i) = index;             % add index to your path
index = best_neighbour(index); % find the best neighbour of current index;
i = i + 1;
end

path
optimal_values = cost_to_go_matrix(:,1)

OutfileID = fopen('output.txt','w');
fprintf(OutfileID,'%d ',path);
fprintf(OutfileID,'\n');
fprintf(OutfileID,'%f ',optimal_values);
fclose('all');

cost_to_go_matrix(100:110,100:110);