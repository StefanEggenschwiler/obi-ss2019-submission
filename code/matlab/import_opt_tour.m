function [optTour] = import_opt_tour(file, coord)
% Author: 
%     Stefan Eggenschwiler, May 2019.
% Description:
%     Parses an opt_tour file describing the optimal solution for a TSP
%     and produces a matrix for plotting.
% Input: 
%     file, location of the .opt.tour file.
%     coord, matrix with labels and node coordinations.
% Output:
%     coord: Matrix with coordinates of the TSP nodes.

    fid = fopen(strcat('problems/opt.tour/',file, '.opt.tour'));
    tline = fgetl(fid);
    pointer = false;
    
    optLabels = [];
    
    while ~strcmp(tline, '-1')
        if (pointer)
            optLabels = [optLabels, str2double(tline)];
        end
        if (strcmp(tline, 'TOUR_SECTION'))
            pointer = true;
        end
        tline = fgetl(fid);
    end
    
    optTour = [];
    
    for i = 1:length(optLabels)
        optTour = [optTour, coord(:, optLabels(i))];
    end
end

