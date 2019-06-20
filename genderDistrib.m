function [gender, bias] = genderDistrib()
    gender = 'm';
    bias = -0.47;
    distrib = randi([0 1]);
    if distrib == 1
        gender = 'f';
        bias = -0.49;
    end
end
