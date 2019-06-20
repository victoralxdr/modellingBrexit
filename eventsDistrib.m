function [shiftMatrix, event] = eventsDistrib(eventRate, groups, agents)
    event = 0;
    shiftMatrix = zeros(groups, agents);
    distrib = rand(1)*100;
    if(distrib > eventRate)
        gravity = randn(1)*(0.05/3) %opinion mean between -0.5 and +0.05
        shiftMatrix = 0.5*randn(groups, agents)+gravity; %events shift in range -0.2 and 0.2
        event = 1;
    end
    
end
