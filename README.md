# Comparison of Nature-Inspired and Graph Algorithms Solving Travelling Salesman Problems
Optimization for Business Improvement (SS 2019)

This is the repository of the prototype artefacts developed to conduct the analysis and its generated data. This research was conducted as part of the module "Optimization for Business Improvement" for the Business Information Systems master degree program at the [University of Applied Science Northwestern Switzerland](https://www.fhnw.ch/en/degree-programmes/business/msc-bis).

## Getting Started

The artefacts were developed using the latest version of MATLAB and several add-ons. A full list of prerequisits can be in [this](#prerequisits) section.

## Description

The artefacts sole purpose is to solve multiple tsp problems with several different algorithms and output metrics of each solving round as a line of text in a text file. All files aggregated produce the data set which can then being used to conduct an analysis and compare the performance of the different algorithms.

[analysis.m](https://github.com/StefanEggenschwiler/obi-ss2019-submission/blob/master/code/matlab/analysis.m) is the main script which executed the artefact:
```Matlab
files = ["berlin52", "burma14", "ch130", "ch150", "eil51", "eil76", "eil101", "gr96", "gr202", "gr666", ...];

for file = files
    [name, edge_weight_type, coord] = import_tsp(file);
    [graph] = createGraph(name, edge_weight_type, coord);
    fprintf('# Performance validation for TSP: %s\n', name)
    algo_stats_analysis(graph, @increasing_loop, 'inc_loop');
    algo_stats_analysis(graph, @forcefully_increasing_loop, 'f_inc_loop');
    algo_stats_analysis(graph, @twoopt, 'two_opt');
    algo_stats_analysis(graph, @optimal_greedy_TSP, 'opt_greedy');
    algo_stats_analysis(graph, @pso_opt, 'pso', 'apso');
    algo_stats_analysis(graph, @pso_opt, 'pso', 'qpso');
    algo_stats_analysis(graph, @pso_opt, 'pso', 'spso');
    algo_stats_analysis(graph, @ant_colony_opt, 'aco');
end
cmd1 = strcat('type ..\..\data\*.part > ..\..\data\', 'pr2392_aco100', '.csv');
cmd2 = strcat('del ..\..\data\*.part');

system(cmd1);
system(cmd2);

fprintf('\nFinished!\n')
```
Its function is pretty simple:
1. A string array of file names represents the .tsp problems that should be solved. A for-loop loops over the array, parses the file using the [import_tsp](https://github.com/StefanEggenschwiler/obi-ss2019-submission/blob/master/code/matlab/import_tsp.m) function which retrieves the name of the TSP instance, the edge weight type (either 2D euclidean or geographical are supported) and a matrix containing the x and y coordinates of each node. All available TSP problems are stored [here](https://github.com/StefanEggenschwiler/obi-ss2019-submission/blob/master/code/matlab/problems/tsp/).
2. In a next step, this information is used as input for the [createGraph](https://github.com/StefanEggenschwiler/obi-ss2019-submission/blob/master/code/matlab/createGraph.m) function. This function computes the distance matrix used during the solving process. Additionally, it generates a MATLAB structure containing all relevant data for the solver:
    * Name of the tsp instance
    * Number of nodes
    * Coordinate matrix with x and y coordinates of all nodes
    * Distance matrix with distance from each node to each node
3. For each algorithm, one [algo_stats_analysis](https://github.com/StefanEggenschwiler/obi-ss2019-submission/blob/master/code/matlab/algo_stats_analysis.m) function is executed with the following parameters:
    * The graph generated in the previous step
    * The algorithm function to be executed
    * The name of the algorithm (used in the log file generation)
    * additionally for the PSO algorithm, which one of the three implementations of the PSO algorithm should be used
4. After the for-loop has been executed, two MS DOS commands are executed.
    1. cmd1 aggregates all .part files generated during the solving process into [one .csv file](https://github.com/StefanEggenschwiler/obi-ss2019-submission/blob/master/data/data02.csv).
    2. cmd2 deletes all .part files.
    
**The implementation of the algorithms can be found [here](https://github.com/StefanEggenschwiler/obi-ss2019-submission/blob/master/code/matlab/algorithms/).**

As described previously, [algo_stats_analysis](https://github.com/StefanEggenschwiler/obi-ss2019-submission/blob/master/code/matlab/algo_stats_analysis.m) is the main function used to solve the tsp instance:
```Matlab
function [] = algo_stats_analysis(graph, f, algo, varargin)
    ...
    iter = 100;
    ...
        parfor i = 1:1:iter
            fileID = fopen(strcat('../../data/', graph.name, algo, num2str(i), '.part'), 'w');
            [p, d, t] = f(graph.edges);
            fprintf(fileID, '%s:%s:%s:%s:%s\n', algo, graph.name, num2str(i), num2str(d), num2str(t));
            fclose(fileID);
        end
    ...
end
```
The function is used to generate the data set used during the analysis part of our research. It simply takes the graph construct previously generated in [analysis.m](https://github.com/StefanEggenschwiler/obi-ss2019-submission/blob/master/code/matlab/analysis.m#L15), the solver function and the name of the algorithm. It then uses [parfor-loops](https://ch.mathworks.com/help/parallel-computing/parfor.html) which is part of MATLABs [Parallel Computing Toolbox](https://ch.mathworks.com/products/parallel-computing.html) to concurrently solve the tsp instance 100 times using the provided solver function. Thanks to our utilised [hardware platform](#analysis-conducted-with), we were able to solve up to 16 tsp instances at once, therefore greatly reducing the overall computation time. During each computation cycle, a .part file is generated and the results of the solver is saved in this file. The results are stored in separate files in order to bypass potential file corruption issues that could occur during concurrent I/O operations (file writing). The following information is stored per .part file:
* **algorithm**:**tspInstance**:**executionNo**:**calculatedDistance**:**executionDurationInSec**
    1. *algorithm*, name of the used algorithm
    2. *tspInstance*, name of the solved tsp instance
    3. *executionNo*, number of the execution cycle (variable i, 1-100)
    4. *calculatedDistance*, distance of the shortest path as calculated by the algorithm, as floating-point number
    5. *executionDurationInSec*, time duration between start and end of the solving process in seconds, as floating-point number
* e.g. opt_greedy:ch150:22:7078.4447:0.24991

## Prerequisits

* [MATLAB R2019 Update 1](https://ch.mathworks.com/products/matlab.html) - MATLAB is a multi-paradigm numerical computing environment and proprietary programming language developed by MathWorks.

  * [Parallel Computing Toolbox](https://ch.mathworks.com/products/parallel-computing.html) - Perform parallel computations on multicore computers, GPUs, and clusters.

  * [Simulink](https://ch.mathworks.com/products/simulink.html) - Model-Based Design: From Concept to Code.

  * [Optimization Toolbox](https://ch.mathworks.com/products/optimization.html) - Solve linear, quadratic, integer, and nonlinear optimization problems.

  * [Statistics and Machine Learning Toolbox](https://ch.mathworks.com/products/statistics.html) - Analyze and model data using statistics and machine learning.

  * [xml2struct ext.](https://ch.mathworks.com/matlabcentral/fileexchange/58700-xml2struct-with-bug-fix-and-added-features) - An improved version of xml2struct that converts xml documents into MATLAB structures.
  
## Analysis Conducted With
* [AMD Ryzen 7 1700 - 16x3.7GHz](https://www.amd.com/en/products/cpu/amd-ryzen-7-1700)
* [16GB Dual Channel DDR4 RAM @2400MHz](https://www.gskill.com/en/product/f4-2400c16d-16gfx)

## Authors

* **[Stefan Eggenschwiler](mailto:stefan.eggenschwiler@students.fhnw.ch)**
* **[Maja Spahic-Bogdanovic](mailto:maja.spahic@students.fhnw.ch)**

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details

