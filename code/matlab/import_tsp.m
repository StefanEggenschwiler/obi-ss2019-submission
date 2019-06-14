function [name, edge_weight_type, coord] = import_tsp(file)
    % Author: 
    %     Stefan Eggenschwiler, May 2019.
    % Description:
    %     Parses an XML file describing a TSP and produces a matrix M which 
    %     represents the distance information for the
    %     travelling salesman problem.
    % Input: 
    %     file, location of the .tsp file.
    % Output:
    %     coord: Matrix with coordinates of the TSP nodes.
    fid = fopen(strcat('problems/tsp/',file, '.tsp'));
    tline = fgetl(fid);
    pointer = false;
    
    name = '';
    edge_weight_type = '';
    coord = [];

    while ~strcmp(tline, 'EOF')
        if (pointer)
            coord = [coord, str2double(split(tline, ' '))];
        end
        if (contains(tline, 'NAME'))
            C = strsplit(tline, ': ');
            name = string(C(2));
        end
        if (strcmp(tline, 'NODE_COORD_SECTION'))
            pointer = true;
        end
        if (contains(tline, 'EDGE_WEIGHT_TYPE:'))
            C = strsplit(tline, ': ');
            edge_weight_type = string(C(2)); 
        end
        tline = fgetl(fid);
    end
end