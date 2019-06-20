function [edu, bias] = eduDistrib()
    distrib = rand(1)*100;
    edu = 0;
    bias = -0.41;
    if distrib <= 34
        edu = 1;
        bias = -0.68;
    end
end
