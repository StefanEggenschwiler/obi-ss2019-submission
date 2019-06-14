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
    %[optTour] = import_opt_tour(file, coord);
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
%[route] = algo_stats(c, M, @increasing_loop, 'inc_loop', coord);
%plot_solution(coord, optTour, route);
