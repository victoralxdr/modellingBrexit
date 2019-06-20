clc
clear all
clf
close all

%population parameters
N = 100000; %population size
groups = 5000; % how many groupies 
agents = N/groups;%agents per group

%experiment params
%iterations
t_max = 1000;
%social mobility
swap = 1;
%how many simulations should run
simulations = 1;

turnout = 72.2;
undecisiveness = 0.05;
event = 99;

%{
vectorLeave = zeros(1,t_max/10);
vectorRemain = zeros(1,t_max/10);
%}

counter = 0;
index = 1;
modulo = 1;

for l = 1:simulations
    
    %fill matrix with agents
    for i = 1:groups
        for j = 1:agents
            population(i,j) = individual;
            opinion(i,j) = population(i,j).opinion;
        end
    end

    %run simulation for t_max iterations
    for t = 1:t_max

        [shiftMatrix, happened] = eventsDistrib(event, groups, agents);
        if(happened == 1)
            for x = 1:groups
                for y = 1:agents
                    population(x,y).opinion = population(x,y).opinion + shiftMatrix(x,y);
                    if(population(x,y).opinion > 1)
                        population(x,y).opinion = 1;
                    end
                    if(population(x,y).opinion < -1)
                        population(x,y).opinion = -1;
                    end
                    population(x,y).stubbornness = 2*abs(population(x,y).opinion);
                end
            end
        end
        
        for i = 1:groups
            agentA = randperm(agents, 1);
            agentB = randperm(agents, 1);
            
            diff = abs(population(i, agentA).opinion - population(i, agentB).opinion);
            
            temp = population(i, agentA).opinion;
            
            [population(i, agentA).opinion,population(i, agentA).stubbornness, population(i, agentA).mu] = deffuantInteraction(population(i, agentA), diff, population(i, agentB).opinion);
            [population(i, agentB).opinion,population(i, agentB).stubbornness, population(i, agentB).mu] = deffuantInteraction(population(i, agentB), diff, temp);
            opinion(i, agentA) = population(i, agentA).opinion;
            opinion(i, agentB) = population(i, agentB).opinion;
        end
        
        %social mobility
        if(swap ==1) 
            %select at random 2 communities for permutation
            c = randi(groups,2); 
            %select at random 2 agents for permuation
            a = randi(agents,2,1);
            temp = population(c(1),a(1));
            population(c(1),a(1)) = population(c(2),a(2));
            opinion(c(1), a(1)) = population(c(2),a(2)).opinion;
            population(c(2),a(2)) = temp;
            opinion(c(2), a(2)) = temp.opinion;
        end
        
       %tracking both remain and leave opinion
       %{ 
       if(modulo == 10)
            modulo = 0
            
            for i = 1:groups
                for j = 1:agents
                    %undecisive take random vote
                    if(abs(opinion(i,j)) < undecisiveness)
                        opinion(i,j) = 2*rand(1)-1;
                    end
                    
                    distrib = rand(1)*100;
                    %abstention
                    if(distrib < turnout)
                        %72.2% of votes counted
                        if(opinion(i,j) < 0)
                            %remain
                            vectorRemain(1, index) = vectorRemain(1, index) + 1;
                        end
                        if opinion(i,j) > 0
                        %leave
                            vectorLeave(1, index) = vectorLeave(1, index) + 1;
                        end
                        %27.8% of votes ignored -> did not turnout
                    end
                end
            end
            vectorRemain(1, index) = (vectorRemain(1, index)/(vectorLeave(1, index)+vectorRemain(1, index)))*100;
            vectorLeave(1, index) = 100- vectorRemain(1, index);
            index = index +1;
        end
        modulo = modulo +1;
        %}
        
    end 
    
    clear population;
end

figure(5)
histogram(opinion, 10)
xlabel("opinion")
ylabel("percent")
yticklabels(yticks/1000)
