function [graph]  = createGraph(name, edge_weight_type, coord)
    % Author:
    %     Stefan Eggenschwiler, June 2019
    % Description:
    %     Calculate the distance matrix according to the specifications of
    %     the TSPLIB found in:
    %     https://wwwproxy.iwr.uni-heidelberg.de/groups/comopt/software/TSPLIB95/TSPFAQ.html
    % Input:
    %     coord: Matrix, coordination matrix of all cities.
    % Output:
    %     graph: Struct, Containing name of TSP, no. of nodes
    %     coordinates and distance matrix for all nodes.
    
    x = coord(2, :);
    y = coord(3, :);
    
    graph.n = length(x);
    graph.name = name;

    for i = 1 : graph.n
        graph.node(i).x = x(i);
        graph.node(i).y = y(i);
    end

    graph.edges = zeros(graph.n, graph.n );
    
    switch edge_weight_type
        case 'EUC_2D'
            graph = createEuc2dGraph(graph);
        case 'GEO'
            graph = createGeoGraph(graph);
    end
end

function [graph]  = createEuc2dGraph(graph)
    % Author:
    %     Stefan Eggenschwiler, June 2019
    % Description:
    %     Calculate the euclidean distance between two 2-dimensional points. 
    % Input:
    %     graph: Struct, Containing name of TSP, no. of nodes and
    %     coordinates of nodes on a 2-dimensional plane.
    % Output:
    %     graph: Struct, Containing name of TSP, no. of nodes
    %     coordinates and distance matrix for all nodes.
    
    for i = 1 : graph.n
        for j = 1: graph.n
            x1 = graph.node(i).x ;
            x2 = graph.node(j).x;
            y1 = graph.node(i).y;
            y2 = graph.node(j).y;
            
            graph.edges(i,j) = sqrt((x2-x1)^2+(y2-y1)^2);
        end
    end
end

function [graph]  = createGeoGraph(graph)
    % Author:
    %     Stefan Eggenschwiler, June 2019
    % Description:
    %     Calculates the distance matrix according to the specifications of
    %     TSPLIB found in:
    %     https://wwwproxy.iwr.uni-heidelberg.de/groups/comopt/software/TSPLIB95/TSPFAQ.html
    % Input:
    %     graph: Struct, Containing name of TSP, no. of nodes and
    %     coordinates of nodes as GPS coordinates (latitude and longitude).
    % Output:
    %     graph: Struct, Containing name of TSP, no. of nodes
    %     coordinates and distance matrix for all nodes.
    
    RRR = 6378.388;

    for i = 1 : graph.n
        for j = 1: graph.n
            if (i == j)
                continue
            end
            x1 = graph.node(i).x;
            x2 = graph.node(j).x;
            y1 = graph.node(i).y;
            y2 = graph.node(j).y;
            
            PI = 3.141592;

            deg = fix(x1); 
            min = x1 - deg; 
            radX1 = PI * (deg + 5.0 * min / 3.0) / 180.0;
            
            deg = fix(x2); 
            min = x2 - deg; 
            radX2 = PI * (deg + 5.0 * min / 3.0) / 180.0;
            
            deg = fix(y1); 
            min = y1 - deg; 
            radY1 = PI * (deg + 5.0 * min / 3.0) / 180.0;
            
            deg = fix(y2); 
            min = y2 - deg; 
            radY2 = PI * (deg + 5.0 * min / 3.0) / 180.0;
            
            q1 = cos(radY1 - radY2);
            q2 = cos(radX1 - radX2);
            q3 = cos(radX1 + radX2);
            graph.edges(i,j) = fix(RRR * acos(0.5 * ((1.0+q1)*q2 - (1.0-q1)*q3)) + 1.0);
        end
    end
end