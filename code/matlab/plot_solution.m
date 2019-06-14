function [] = plot_solution(coord, optTour, route)
% Author: 
%     Stefan Eggenschwiler, May 2019.
% Description:
%     Parses an opt_tour file describing the optimal solution for a TSP
%     and produces a matrix for plotting.
% Input: 
%     coord, matrix with labels and node coordinations.
%     optTour, matrix with coordinates of the optimal solution.
%     route, array with labels of the solution route.
% Output:
%     none, generates plot

    route = str2double(route);

    solTour = [];
    for i = 1:length(route)
        solTour = [solTour, coord(:, route(i))];
    end
    
    plot(coord(2,:),coord(3,:),'o', 'DisplayName', 'Nodes')
    text(coord(2,:),coord(3,:),string(coord(1,:)),'VerticalAlignment','top','HorizontalAlignment','left')
    hold on
    plot(optTour(2,:),optTour(3,:),'-', 'DisplayName', 'Optimal Solution')
    plot(solTour(2,:),solTour(3,:),'-', 'DisplayName', 'Computed Solution')
    legend
    hold off
end

