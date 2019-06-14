# Comparison of Nature-Inspired and Graph Algorithms Solving Travelling Salesman Problems
Optimization for Business Improvement (SS 2019)

This is the repository of the prototype artefacts developed to conduct the analysis and its generated data. This research was conducted as part of the module "Optimization for Business Improvement" for the Business Information Systems master degree program at the [University of Applied Science Northwestern Switzerland](https://www.fhnw.ch/en/degree-programmes/business/msc-bis).

## Getting Started

The artefacts were developed using the latest version of MATLAB and several add-ons listed under [this](#prerequisits) section.

## Manual

The artefacts sole purpose is to solve multiple tsp problems with several different algorithms and output metrics of each solving round as a line of text in a text file. All files aggregated produce the data set which can then being used to conduct an analysis and compare the performance of the different algorithms.

[analysis.m](https://github.com/StefanEggenschwiler/TLBO-GameClient/blob/master/groupwork/submission/code/matlab/analysis.m) is the main script which executed the artefact. We will now go step by step 

```Matlab
% Author:
%     Stefan Eggenschwiler, May 2019.
% 
% Description: 
%     Displays the performance of various algorithms to find a path for the
%     travelling salesman problem, usind problems from tsplib library.
%     The fiels array is a array of strings corresponding to the .tsp files
%     stored in the /problems/tsp folder. 

files = ["berlin52", "burma14", "ch130", "ch150", "eil51", "eil76", "eil101", "gr96", "gr202", "gr666", "kroA100", "kroC100", "kroD100", "lin105", "pr76", "rd100", "st70", "tsp225", "ulysses16", "ulysses22", "pr1002", "pr2392"];

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

## Prerequisits

* [MATLAB R2019 Update 1](https://ch.mathworks.com/products/matlab.html) - MATLAB is a multi-paradigm numerical computing environment and proprietary programming language developed by MathWorks.

  * [Parallel Computing Toolbox](https://ch.mathworks.com/products/parallel-computing.html) - Perform parallel computations on multicore computers, GPUs, and clusters.

  * [Simulink](https://ch.mathworks.com/products/simulink.html) - Model-Based Design: From Concept to Code.

  * [Optimization Toolbox](https://ch.mathworks.com/products/optimization.html) - Solve linear, quadratic, integer, and nonlinear optimization problems.

  * [Statistics and Machine Learning Toolbox](https://ch.mathworks.com/products/statistics.html) - Analyze and model data using statistics and machine learning.

  * [xml2struct ext.](https://ch.mathworks.com/matlabcentral/fileexchange/58700-xml2struct-with-bug-fix-and-added-features) - An improved version of xml2struct that converts xml documents into MATLAB structures.
  
## Analysis Conducted With
[AMD Ryzen 7 1700 - 16x3.7GHz](https://www.amd.com/en/products/cpu/amd-ryzen-7-1700)
[16GB Dual Channel DDR4 RAM @2400MHz](https://www.gskill.com/en/product/f4-2400c16d-16gfx)

## Authors

* **[Stefan Eggenschwiler](mailto:stefan.eggenschwiler@students.fhnw.ch)**
* **[Maja Spahic-Bogdanovic](mailto:maja.spahic@students.fhnw.ch)**

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details

