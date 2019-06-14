% Standard PSO for TSP
function [best_position, best_fit] = TSP_SPSO(CreatePopFcn, FitnessFcn, UpdatePosition, ...
                                        nVars, nPopSize, nIters)
    %% Initialization
    c2 = 1.0;   %1.2;                   % PSO parameter C1 
    c1 = 1.0;   %1.0;%0.4-0.7;%0.12;    % PSO parameter C2 
    w = 0.9;    %0.9;                   % pso momentum or inertia  
    fitness = inf * ones(nPopSize, nIters);
    %-----------------------------%
    %    initialize the parameter %
    %-----------------------------%
    R1 = rand(nPopSize, nVars);
    R2 = rand(nPopSize, nVars);
    current_fitness = inf*ones(nPopSize, 1);
    %------------------------------------------------%
    % Initializing swarm and velocities and position %
    %------------------------------------------------%
    current_position = CreatePopFcn(nPopSize, nVars);
    velocity = zeros(nPopSize, nVars);
    local_best_position = current_position;
    %-------------------------------------------%
    %     Evaluate initial population           %           
    %-------------------------------------------%
    for i = 1:nPopSize
        current_fitness(i) = FitnessFcn(current_position(i, :));
    end
    local_best_fitness  = current_fitness ;
    [global_best_fitness,g] = min(local_best_fitness) ;
    for i = 1:nPopSize
        globl_best_position(i, :) = local_best_position(g, :);
    end
    
   %-------------------%
   %  VELOCITY UPDATE  %
   %-------------------%
    velocity = w *velocity + c1*(R1.*(local_best_position-current_position)) + c2*(R2.*(globl_best_position-current_position));
   %------------------%
   %   SWARMUPDATE    %
   %------------------%
    current_position = UpdatePosition(current_position + velocity);
   %------------------------%
   %  evaluate anew swarm   %
   %------------------------%
    %% Main Loop
    iter = 0 ;        % Iterations?ounter
    while  ( iter < nIters )
        iter = iter + 1;
        for i = 1:nPopSize
            current_fitness(i) = FitnessFcn(current_position(i, :));
        end
        for i = 1 : nPopSize
            if current_fitness(i) < local_best_fitness(i)
               local_best_fitness(i) = current_fitness(i);  
               local_best_position(i, :) = current_position(i, :);
            end   
        end
        [current_global_best_fitness,g] = min(local_best_fitness);
        if current_global_best_fitness < global_best_fitness
           global_best_fitness = current_global_best_fitness;
            for i=1:nPopSize
                globl_best_position(i, :) = local_best_position(g, :);
            end
        end
        velocity = w *velocity + c1*(R1.*(local_best_position-current_position)) + c2*(R2.*(globl_best_position-current_position));
         
        current_position = UpdatePosition(current_position + velocity);
        fitness(:, iter) = current_fitness;
        sprintf('The value of interation iter %3.0f ', iter );
    end % end of while loop its mean the end of all step that the birds move it 
    xx=fitness(:, nIters);
    [best_fit, I] = min(xx);
    best_position = current_position(I, :);
end