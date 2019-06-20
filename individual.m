classdef individual
    %   class to model each individual agents 
    %   Detailed explanation goes here
    
    properties 
        age 
        bias
        educationLevel 
        gender 
        income 
        mu
        opinion
        stubbornness
    end
    
    methods
        function obj = individual
            obj.mu = 0.5;

            [obj.age, biasAge] = ageDistrib();
            [obj.gender, biasGender] = genderDistrib();
            [obj.educationLevel, biasEdu] = eduDistrib();
            [obj.income, biasIncome] = incomeDistrib();
            
            
            obj.bias = (biasAge + biasGender + biasEdu + biasIncome);
            
            obj.bias = (0.5*4 + obj.bias);
            
            obj.opinion = (1/3)*randn+obj.bias; %std = 0.3 to get distribution in range [-1,1] more or less
            

            if abs(obj.opinion) > 1
                obj.opinion = obj.opinion - obj.bias;
            end
            
            %set stubbornness according to opinion (the more extreme the
            %more stubborn for now)
            
            obj.stubbornness = 2*abs(obj.opinion);
                
            
        end
        
        function [op,stub, mu] = deffuantInteraction(obj, opinionDiff, opinionB)
            op = obj.opinion;
            stub = obj.stubbornness;
            if  (stub + opinionDiff) < 2
                op = obj.opinion + obj.mu*(opinionB - obj.opinion);
                stub = 2*abs(obj.opinion);
                    
            end
            mu = obj.mu*0.98;
        end
        
    end
    
end
