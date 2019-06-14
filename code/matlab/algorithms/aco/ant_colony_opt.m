function [p, d, t, a] = ant_colony_opt(graph, ants, varargin)
    % Author:
    %     Clint Wong, December 2016.
    % Description:
    %     Initialise with route 1, 2, ..., n, 1.
    %     Replace 2 edges at random and accept the new cycle if it is shorter.
    %     Terminate when the current distance is not lowered by tol for 1000
    %     consecutive trials. 
    % Input:
    %     coord: Matrix, coordination matrix of all cities.
    %     ants: Integer, number of ants used in the execution of the
    %     algorithm.
    % Output:
    %     p: Array, row vector of permutation of the order of cities to visit.
    %     d: Float, total distance travelled in a round trip.
    %     t: Float, execution time for algorithm.
    %     a: Integer, number of ants used in the execution of the
    %     algorithm.
    %% Problem preparation     
    maxIter = 100;
    antNo = ants;

    tau0 = 10 * 1 / (graph.n * mean(graph.edges(:)));  % Initial pheromones concentration

    tau = tau0 * ones(graph.n, graph.n); % Pheromones matrix 
    eta = 1./ graph.edges;  % desirability of each edge 

    rho = 0.5; % Evaporation rate 
    alpha = 1;  % Pheromone exponential parameters 
    beta = 1;  % Desirability exponetial paramter

    
    %% Main loop of ACO 
    bestFitness = inf;
    bestTour = [];
    tic
    for t = 1 : maxIter
        % Create Ants 
        colony = [];
        colony = createColony(graph, colony, antNo, tau, eta, alpha, beta);


        % Calculate the fitness values of all ants 
        for i = 1 : antNo 
            colony.ant(i).fitness = fitnessFunction(colony.ant(i).tour, graph);
        end

        % Find the best ant (queen)
        allAntsFitness = [colony.ant(:).fitness];
        [minVal, minIndex] = min(allAntsFitness);
        if minVal < bestFitness 
            bestFitness = colony.ant(minIndex).fitness;
            bestTour = colony.ant(minIndex).tour;
        end

        colony.queen.tour = bestTour;
        colony.queen.fitness = bestFitness;

        % Update pheromones matrix 
        tau = updatePheromones(tau , colony);  

        % Evaporation 
        tau  = ( 1 - rho ) .* tau;
    end
    
    a = antNo;
    p = "";
    d = colony.queen.fitness;
    t = toc;
end