% APSO for TSP
function [best_position, best_fit, flocalbest] = TSP_APSO(...
                    CreatePopFcn, FitnessFcn, UpdatePosition, ...
                                        nVars, nPopSize, nIters)

    alpha=0.8;  % alpha=[0,1]????????
    beta=0.9;   % ????(0->1)=(slow->fast);
    gamma=0.99; % alpha????

    para=[nPopSize nVars nIters alpha beta gamma];

    [best_position, best_fit, flocalbest]=pso_mincon(CreatePopFcn, FitnessFcn, UpdatePosition, para);

end


%%  APSO Solver
function [gbest,fbest,flocalbest]=pso_mincon(fCreatePop, fFitting, fUpdatePop, para)

    nPopSize=para(1);
    nVars=para(2);
    nIters=para(3);
    alpha=para(4);
    beta=para(5);
    gamma=para(6);

    best=fCreatePop(nPopSize, nVars);

    fbest=inf;
    flocalbest = inf*ones(nPopSize, nIters);
    
    for t=1:nIters
        
        for i=1:nPopSize
            fval=fFitting(best(i, :));
            flocalbest(i, t) = fval;

            if fval<=fbest, 
                gbest=best(i,:);
                fbest=fval;
            end
        end

        alpha=newPara(alpha,gamma);

        best=pso_move(best,gbest,alpha,beta);  
        best=fUpdatePop(best);
    end
end


function ns=pso_move(best,gbest,alpha,beta)
    n=size(best,1); ndim=size(best,2);
    scale=ndim;
    
    for i=1:n
        xmin=-1;
        xmax=1;
        R=xmin+rand(1,ndim)*(xmax-xmin);
        
        ns(i,:)=best(i,:)+beta*(gbest-best(i,:))+alpha.*R.*scale;
    end
end

function alpha=newPara(alpha,gamma)
    alpha=alpha*gamma;
end