function [income, bias] = incomeDistrib()
    distrib = rand(1)*100;
    
    if distrib <= 20
        income = randi([0 21348]);
        bias = -0.38;
    end
    if (distrib > 20) && (distrib <= 60)
        income = randi([21348 43190]);
        bias = -0.47;
    end
    if (distrib > 60) && (distrib <= 80)
        income = randi([43190 64606]);
        bias = -0.58;
    end
    if (distrib > 80)
        income = randi([64606 110643]);
        bias = -0.63;
    end
end
