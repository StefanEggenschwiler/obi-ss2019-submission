function [] = algo_stats_analysis(graph, f, algo, varargin)
    % Author:
    %     Stefan Eggenschwiler, June 2019.
    % Description:
    %     Executes the algorithm f 100 times in a parallel for-loop and
    %     saves the results in separate files. The output format is as
    %     followed:
    %     <algorithm>:<tspInstance>:<execNo>:<distance>:<execDurationInSec>
    %     e.g.
    %     f_inc_loop:burma14:1:3509:0.0031496
    % Input:
    %     graph: Struct, Containing name of TSP, no. of nodes
    %     coordinates and distance matrix for all nodes.
    %     f: Function handle, algorithm to implement.
    %     t: String, name of algorithm.
    % Output:
    %     None.
	
    % Checking varargin structure
    if (length(varargin) == 1)
        varargin = varargin{:};
    end
    iter = 100;
    if strcmp(algo, "aco")
        parfor i = 1:1:iter
            fileID = fopen(strcat('../../data/',graph.name, algo, num2str(50), '-' , num2str(i), '.part'), 'w');
            [p, d, t, a] = f(graph, 50);
            fprintf(fileID, '%s-%s:%s:%s:%s:%s\n', algo, num2str(a), graph.name, num2str(i), num2str(d), num2str(t));
            fclose(fileID);
        end
        parfor i = 1:1:iter
            fileID = fopen(strcat('../../data/aco100', graph.name, algo, num2str(100), '-' , num2str(i), '.part'), 'w');
            [p, d, t, a] = f(graph, 100);
            fprintf(fileID, '%s-%s:%s:%s:%s:%s\n', algo, num2str(a), graph.name, num2str(i), num2str(d), num2str(t));
            fclose(fileID);
        end
        parfor i = 1:1:iter
            fileID = fopen(strcat('../../data/', graph.name, algo, num2str(150), '-' , num2str(i), '.part'), 'w');
            [p, d, t, a] = f(graph, 150);
            fprintf(fileID, '%s-%s:%s:%s:%s:%s\n', algo, num2str(a), graph.name, num2str(i), num2str(d), num2str(t));
            fclose(fileID);
        end
        parfor i = 1:1:iter
            fileID = fopen(strcat('../../data/', graph.name, algo, num2str(200), '-' , num2str(i), '.part'), 'w');
            [p, d, t, a] = f(graph, 200);
            fprintf(fileID, '%s-%s:%s:%s:%s:%s\n', algo, num2str(a), graph.name, num2str(i), num2str(d), num2str(t));
            fclose(fileID);
        end
    elseif strcmp(algo, "pso")
        parfor i = 1:1:iter
            fileID = fopen(strcat('../../data/pso2.0/',graph.name, algo, '-', varargin, num2str(50), '-' , num2str(i), '.part'), 'w');
            [p, d, t, a] = f(graph, 50, varargin);
            fprintf(fileID, '%s-%s-%s:%s:%s:%s:%s\n', algo, varargin, num2str(a), graph.name, num2str(i), num2str(d), num2str(t));
            fclose(fileID);
        end
        parfor i = 1:1:iter
            fileID = fopen(strcat('../../data/pso2.0/', graph.name, algo, '-', varargin, num2str(100), '-' , num2str(i), '.part'), 'w');
            [p, d, t, a] = f(graph, 100, varargin);
            fprintf(fileID, '%s-%s-%s:%s:%s:%s:%s\n', algo, varargin, num2str(a), graph.name, num2str(i), num2str(d), num2str(t));
            fclose(fileID);
        end
        parfor i = 1:1:iter
            fileID = fopen(strcat('../../data/', graph.name, algo, '-', varargin, num2str(150), '-' , num2str(i), '.part'), 'w');
            [p, d, t, a] = f(graph, 150, varargin);
            fprintf(fileID, '%s-%s-%s:%s:%s:%s:%s\n', algo, varargin, num2str(a), graph.name, num2str(i), num2str(d), num2str(t));
            fclose(fileID);
        end
        parfor i = 1:1:iter
            fileID = fopen(strcat('../../data/', graph.name, algo, '-', varargin, num2str(200), '-' , num2str(i), '.part'), 'w');
            [p, d, t, a] = f(graph, 200, varargin);
            fprintf(fileID, '%s-%s-%s:%s:%s:%s:%s\n', algo, varargin, num2str(a), graph.name, num2str(i), num2str(d), num2str(t));
            fclose(fileID);
        end
    else
        parfor i = 1:1:iter
            fileID = fopen(strcat('../../data/', graph.name, algo, num2str(i), '.part'), 'w');
            [p, d, t] = f(graph.edges);
            fprintf(fileID, '%s:%s:%s:%s:%s\n', algo, graph.name, num2str(i), num2str(d), num2str(t));
            fclose(fileID);
        end
    end
end