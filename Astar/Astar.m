clear all;
clc;

epsilon = 1;
vertex_file = ['input.txt'];
coords_file = ['coords.txt'];

OutfileID = fopen('output_costs.txt','w');
Outfile2ID = fopen('output_numiters.txt','w');


    
%_____________________________SCANNING INPUT FILE___________________________


fileID = fopen(vertex_file,'r');
coords_fileID = fopen(coords_file,'r');
C = textscan(fileID,'%d',3);     % C is a single array (box) which contains 3 integers 
num_nodes = C{1}(1);
start_node = C{1}(2);
end_node = C{1}(3);
D = textscan(fileID,'%d %d %f'); % scanning the rest of the file for edge weights
Origin = D{1};
Termination = D{2};
Weight = D{3};
temp = [D{1}'; D{2}' ;D{3}'];

G = digraph(Origin,Termination,Weight);


%_______________________SCANNING VERTEX COORDINATES___________________
E = textscan(coords_fileID,'%f %f');
X = E{1};
Y = E{2};

total_cost = [];
total_iters = [];

node_being_expanded = start_node;
ClosedList = start_node;
optimal_ctc = 0;                % cost to come to the start node is 0; optimal_ctc is associated with the closed list
OpenList = [];


% ____________Expanding node that was just moved to closedList____________

pathFound = false;
flag = true;
iter = 0;
pathy = [];
while flag == true
    iter = iter + 1;
    
% neighbour_indeces = find(Origin == node_being_expanded);
% node_being_expanded
% neighbour = Termination(neighbour_indeces);

neighbour = successors(G,node_being_expanded);

% pathy = [pathy neighbour'];
% if(mod(iter,10) == 0)
% p = plot(G,'XData',X,'YData',Y);
% highlight(p,pathy,'EdgeColor','r');
% end

                    
cost_to_neighbour = G.Edges.Weight(findedge(G,node_being_expanded,neighbour)) + optimal_ctc((find(ClosedList == node_being_expanded)));


%___________________________Processing each of the neighbours_________
for(i = 1:size(neighbour))   
    
    % if this neighbour is already in the closed list, do nothing;
    if ismember(neighbour(i),ClosedList)
        t = 2222222;
        
    % else if this neighbour is already in open list,
    elseif ismember(neighbour(i),OpenList)
        % compare existing cost_to_come with new value, associate it with min
        if cost_to_neighbour(i) < OpenListCosts(find(OpenList == neighbour(i)))     
            % update pred of vertex and cost
            OpenListCosts(find(OpenList == neighbour(i))) = cost_to_neighbour(i);
            OpenListPred(find(OpenList == neighbour(i))) = node_being_expanded;
        end
       
    % else if neighbour is not in open list
    else
        % add to open list
        OpenList = [OpenList neighbour(i)];
        % associate it with cost and pred;
        OpenListCosts(find(OpenList == neighbour(i))) = cost_to_neighbour(i);
        OpenListPred(find(OpenList == neighbour(i))) = node_being_expanded;
    end
end

        if isempty(OpenList)
            break;
        end
        
        
        %_____________________Finding the best option in Open List_________
        NodeWithMinCTC = [];
        EstimatedOptimalCost = Inf;
        x = size(OpenList);
        x(1);
        for i = 1:x(2)
            if (OpenListCosts(i)  + epsilon * sqrt( (X(OpenList(i)) - X(end_node)) .^2 + (Y(OpenList(i)) - Y(end_node)).^2 )) < EstimatedOptimalCost
            idx_NodeWithMinEstimatedCost = i;
            Cost_till_here = OpenListCosts(i);
            NodeWithMinCTC = OpenList(i);
            EstimatedOptimalCost = (OpenListCosts(i)  + epsilon * sqrt( (X(OpenList(i)) - X(end_node)) .^2 + (Y(OpenList(i)) - Y(end_node)).^2 ));
            end
        end
        
%         if isempty(NodeWithMinCTC) 
%             break;
%         end

        %_____Moving best option to Closed List, subsequently expanding___
        %_____Making sure to remove best option from Open List____________
        
        ClosedList = [ClosedList NodeWithMinCTC];
        
        optimal_ctc(find(ClosedList == NodeWithMinCTC)) = Cost_till_here;
        ClosedListPred(find(ClosedList == NodeWithMinCTC)) = OpenListPred(idx_NodeWithMinEstimatedCost);
        node_being_expanded = NodeWithMinCTC;
        
        index_to_remove = find(OpenList == NodeWithMinCTC);
        OpenList(index_to_remove) = [];
        OpenListCosts(index_to_remove) = [];
        OpenListPred(index_to_remove) = [];
        
        if NodeWithMinCTC == end_node
            flag = false;
            pathFound = true;
        end

        iter;
        optimal_ctc;
end

if pathFound
temp = end_node;
path = [];
while temp ~= start_node
idx = find(ClosedList == temp);
temp = ClosedListPred(idx);
path = [path temp];
end
total_cost = [total_cost optimal_ctc(find(ClosedList == end_node))];

else
total_cost = [total_cost Inf];
end

total_iters = [total_iters iter];


% 
 path = [fliplr(path) end_node];
 p = plot(G,'XData',X,'YData',Y);
 highlight(p,path,'EdgeColor','r')
 saveas(p,'path_visualization.jpg');


%______________________Writing to output file_____________________________
fprintf(OutfileID,'%2.6f ',total_cost);
fprintf(Outfile2ID,'%d ',total_iters);
fprintf(OutfileID,'\n');
fprintf(Outfile2ID,'\n');




