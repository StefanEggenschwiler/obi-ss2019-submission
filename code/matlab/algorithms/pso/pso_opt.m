function [p, d, t, a] = pso_opt(graph, particles, pso)

    %   PSO_OPT Summary of this function goes here
    %   Detailed explanation goes here
    
    %% Problem Definition
    CostFunction=@(tour) TourLength(tour,graph);
    nVars=graph.n;
    
    %% PSO
    % for reproducibility
    rng(1,'twister');
    % parameters
    nPopSize = particles;
    nIters = 400;
    tic
    switch pso
        case 'spso'
            [best_position, best_fitness] = TSP_SPSO(@CreatePop, CostFunction, @UpdatePop, ...
                                            nVars, nPopSize, nIters);
        case 'apso'
            [best_position, best_fitness] = TSP_APSO(@CreatePop, CostFunction, @UpdatePop, ...
                                            nVars, nPopSize, nIters);
        case 'qpso'
            [best_position, best_fitness] = TSP_QPSO(@CreatePop, CostFunction, @UpdatePop, ...
                                                nVars, nPopSize, nIters);
    end
    t = toc;
    p = best_position;
    d = best_fitness;
    a = nPopSize;
end

function xPop = CreatePop(nPop, nVar)
    xPop = zeros(nPop, nVar);
    for i=1:nPop
        xPop(i, :) = randperm(nVar);
    end
end

function newPop = UpdatePop(orgPop)
    nPop = size(orgPop, 1);
    nVar = size(orgPop, 2);
    newPop = zeros(nPop, nVar);
    
    for i=1:nPop
       [~, ~, newPop(i, :)] = unique( orgPop(i, :) );
    end
end