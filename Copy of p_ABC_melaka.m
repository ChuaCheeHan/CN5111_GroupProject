
tic;
%Limits
x_lo(1) = 1;
x_up(1) = 51;
x_lo(2) = 1;
x_up(2) = 28;
iter = 0;
T = 200;

%Generation of initial population (10 bees)
bees = zeros(10,2);
for (a = 1:10)
    for (b = 1:2)
        bees(a,b) = round(x_lo(b) + rand*(x_up(b) - x_lo(b)));
    end
end
for (a = 1:10)
     while p_BFS_enhanced_melaka(bees(a,1), bees(a,2)) < 0
        bees(a,1) = round(x_lo(1) + rand*(x_up(1) - x_lo(1)));
        bees(a,2) = round(x_lo(2) + rand*(x_up(2) - x_lo(2)));
    end
end

%Evaluation of food sources
for (a = 1:10)
    [result dist_to_airport] = p_BFS_melaka(bees(a,1),bees(a,2));
    bees_fit(a) = p_BFS_enhanced_melaka(bees(a,1),bees(a,2)) + dist_to_airport;
end

while (T > 10)
    
%%Employed bees stage
    for (a = 1:10)
        randomval = randi(4);
        if randomval == 1
            y_mod = 1;
            x_mod = 0;
        end
        if randomval == 2
            y_mod = 0;
            x_mod = 1;
        end
        if randomval == 3
            y_mod = -1;
            x_mod = 0;
        end
        if randomval == 4
            y_mod = 0;
            x_mod = -1;
        end
        while (p_BFS_enhanced_melaka(bees(a,1) + y_mod, bees(a,2) + x_mod) < 0)
            if (randomval < 4)
                randomval = randomval + 1;
            else randomval = 1;
            end
            if randomval == 1
                y_mod = 1;
                x_mod = 0;
            end
            if randomval == 2
                y_mod = 0;
                x_mod = 1;
            end
            if randomval == 3
                y_mod = -1;
                x_mod = 0;
            end
            if randomval == 4
                y_mod = 0;
                x_mod = -1;
            end
        end
        
        [result dist_to_airport] = p_BFS_melaka(bees(a,1) + y_mod, bees(a,2) + x_mod);
        newFitness = p_BFS_enhanced_melaka(bees(a,1) + y_mod, bees(a,2) + x_mod) + dist_to_airport;
        if (newFitness < bees_fit(a) || rand < exp(-(bees_fit(a)-newFitness)/T))
            bees(a,1) = bees(a,1) + y_mod;
            bees(a,2) = bees(a,2) + x_mod;
            bees_fit(a) = newFitness;
        end
    end
    
    %%change values of fitness for probability
    v_totalf = sum(bees_fit);
    inverse_bees_fit = zeros(1,10);
    for (b = 1:10)
        inverse_bees_fit(b) = v_totalf/bees_fit(b);
    end
    bees_probability = zeros(1,10);
    for (b = 1:10)
        bees_probability(b) = inverse_bees_fit(b)/sum(inverse_bees_fit);
    end
    
    %%Onlooker finds the index and possibly swaps the value
    x = cumsum([0 bees_probability(:).'/sum(bees_probability(:))]);
    x(end) = 1e3*eps + x(end);
    [p_val p_idx] = histc(rand,x);
    
    randomval = randi(4);
    if randomval == 1
        y_mod = 1;
        x_mod = 0;
    end
    if randomval == 2
        y_mod = 0;
        x_mod = 1;
    end
    if randomval == 3
        y_mod = -1;
        x_mod = 0;
    end
    if randomval == 4
        y_mod = 0;
        x_mod = -1;
    end
    while (p_BFS_enhanced_melaka(bees(p_idx,1) + y_mod, bees(p_idx,2) + x_mod) < 0)
        if (randomval < 4)
            randomval = randomval + 1;
        else randomval = 1;
        end
        if randomval == 1
            y_mod = 1;
            x_mod = 0;
        end
        if randomval == 2
            y_mod = 0;
            x_mod = 1;
        end
        if randomval == 3
            y_mod = -1;
            x_mod = 0;
        end
        if randomval == 4
            y_mod = 0;
            x_mod = -1;
        end
    end
    
    [result dist_to_airport] = p_BFS_melaka(bees(p_idx,1) + y_mod,bees(p_idx,2) + x_mod);
    newFitness = p_BFS_enhanced_melaka(bees(p_idx,1) + y_mod, bees(p_idx,2) + x_mod) + dist_to_airport;
    if (newFitness < bees_fit(p_idx) || rand < exp(-(bees_fit(p_idx)-newFitness)/T))
        bees(a,1) = bees(p_idx,1) + y_mod;
        bees(a,2) = bees(p_idx,2) + x_mod;
        bees_fit(p_idx) = newFitness;
    end    
    
    %At the end of each round, replace the bee with the worst fitness
    [maxval idx] = max(bees_fit);
    bees(idx,1) = round(x_lo(1) + rand*(x_up(1) - x_lo(1)));
    bees(idx,2) = round(x_lo(2) + rand*(x_up(2) - x_lo(2)));
    while p_BFS_enhanced_melaka(bees(idx,1), bees(idx,2)) < 0
        bees(idx,1) = round(x_lo(1) + rand*(x_up(1) - x_lo(1)));
        bees(idx,2) = round(x_lo(2) + rand*(x_up(2) - x_lo(2)));
    end

    %update the fitness
    [result dist_to_airport] = p_BFS_melaka(bees(idx,1),bees(idx,2));
    bees_fit(idx) = p_BFS_enhanced_melaka(bees(idx,1),bees(idx,2)) + dist_to_airport;
    
    iter = iter + 1;
    T = T * 0.99;
end
%Evaluation of food sources
for (a = 1:10)
    [result dist_to_airport] = p_BFS_melaka(bees(a,1),bees(a,2));
    bees_fit(a) = p_BFS_enhanced_melaka(bees(a,1),bees(a,2)) + dist_to_airport;
end
[minval idx] = min(bees_fit);
minval
yval = bees(idx, 1)
xval = bees(idx, 2)
iter
[result airport] = p_BFS_melaka(yval,xval);
airport
toc