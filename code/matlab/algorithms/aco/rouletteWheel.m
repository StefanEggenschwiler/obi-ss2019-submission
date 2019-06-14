function [nextNode] = rouletteWheel(P)
    % Roulette wheel to choose one edge based on P values 
    c = cumsum(P);
    r = rand();
    nextNode = find(r <= c);
    nextNode = nextNode(1);
end