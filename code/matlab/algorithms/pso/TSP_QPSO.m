
function [best_position, best_fit, flocalbest] = TSP_QPSO(...
                        CreatePopFcn, FitnessFcn,UpdatePosition,...
                                            dimension,popsize,MAXITER)
                                        
    sum1=0;
    st=0;
    T=cputime; 
    
    % init parameters of QPSO: 0.9-0.1; 0.9-0.08;
    max_alpha = 0.9;   
    min_alpha = 0.08;
    
    % Initializing swarm position
    x = CreatePopFcn(popsize, dimension);
    
    % Evaluate initial population
    pbest=x;
    gbest=zeros(1,dimension);
    flocalbest=inf * ones(popsize, MAXITER);
    for i=1:popsize
        f_x(i)=FitnessFcn(x(i,:));
        f_pbest(i)=f_x(i);
    end
    
    [~,g] = min(f_pbest);
    gbest=pbest(g,:);
    f_gbest=f_pbest(g);
    MINIUM=f_pbest(g);
    
    for t=1:MAXITER
        alpha=(max_alpha-min_alpha) * (MAXITER-t)/MAXITER + min_alpha;
        mbest=sum(pbest)/popsize;
        
        for i=1:popsize  
            fi=rand(1,dimension);
            p=fi.*pbest(i,:)+(1-fi).*gbest;
            u=rand(1,dimension);
            b=alpha*abs(mbest-x(i,:));
            v=-log(u);
            
            new_position=p+((-1).^ceil(0.5+rand(1,dimension))).*b.*v;
            x(i,:)=UpdatePosition(new_position);            
            f_x(i)=FitnessFcn(x(i,:));
            flocalbest(i, t) = f_x(i);
            
            if f_x(i)<f_pbest(i)
                pbest(i,:)=x(i,:);
                f_pbest(i)=f_x(i);
            end
            if f_pbest(i)<f_gbest
                gbest=pbest(i,:);
                f_gbest=f_pbest(i);
            end
            MINIUM=f_gbest;
        end
        time=cputime-T;
        st=st+time;
        st;
    end
    best_position = gbest; 
    best_fit = f_gbest;  
end