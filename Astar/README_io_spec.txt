Astar.m contains the implementation of A* to find the path from a start vertex to a goal vertex in a graph.

Note: By changing epsilon in line 4 of Astar.m, the algorithm can be converted to Dijkstra or weighted A*
0 - Dijkstra
1 - A*
>1 - Weighted A*
Default: 1(A*)

The input to the algorithm is contained in two files: input.txt and coords.txt.

input.txt has the following format:
- The first line gives the total number of vertices, n, in the graph.
- The second line gives the starting vertex index (indices go from 1 to n).
- The third line gives the goal vertex index (indices go from 1 to n).
- Starting from the fourth line, the edges in the graph are specified in the form of an edge list. 
Each line specifies one edge: i j wij which indicates that there is a (directed) edge from i to j with a cost of wij. 

coords.txt lists the x and y coordinates of the vertices starting with vertex numbered 1 on the first line.
i.e. it specifies the actual coordinates of all the vertices present in input.txt.


The output of the algorithm is 3 files: output_costs.txt, output_numiters.txt and path_visualization.jpg
output_costs.txt outputs a number that is equal to the cost of the path found;
output_numiters.txt outputs the number of iterations taken to find the path;
path_visualization.jpg contains the visualization of the path from start to goal.




Acknowledgement:
The above problem is a part of homework 2 of the Robot Motion Planning course (ECE 5984) at Virginia Tech.
