dp.m uses dynamic programming to find the shortest path from a start vertex to a goal vertex in a graph.

The input to the algorithm is a file called input.txt. This file has a the following format:

- The first line gives the total number of vertices, n, in the graph.
- The second line gives the starting vertex index (indices go from 1 to n).
- The third line gives the goal vertex index (indices go from 1 to n).
- Starting from the fourth line, the edges in the graph are specified in the form of an edge list. 
Each line specifies one edge: i j wij which indicates that there is a (directed) edge from i to j with a cost of wij. 



The output of the algorithm is a file called output.txt. This file has the following format:

- The first line lists the vertices on the shortest path from the start to the goal vertex.
- The second line lists the optimal cost to reach each of the n vertices in the graph from the start vertex.



Acknowledgement:
The above problem is a part of homework 1 of the Robot Motion Planning course (ECE 5984) at Virginia Tech.
