function [reward] = GreedyEs(epsilon, numIter, leverReal)
% Using the greedy epsilon methods, calculates reward at each iteration
% Returns a vector, given reward for each round

% leverReal =  Actual mean reward per leaver

numLevers = length(leverReal);

% Estimate the mean reward of each lever
leverRewEst = zeros(1, numLevers); % Average reward received per lever
totalReward = zeros(1, numLevers); % How much reward received per lever
numPullsDone = zeros(1, numLevers); % Pulls per lever

% Actual reward received
reward = zeros(1, numIter);

% Pull a lever and find reward for it numIter times
for i = 1:numIter
    
    % Pull a lever
        % Choose to explore or pull most greedy
        
         % Choose to pull the most greedy lever
         % (if epsilon = 0 is always greedy)
         curiosity = rand(1);
        if (curiosity >= epsilon) % Be greedy 
            temp =  find(leverRewEst==max(leverRewEst));
            if (length(temp) > 1)
                leverPulled = temp(1);
            else
               leverPulled = temp; 
            end
            
        else % Explore
            scrambledLevers = randi([1 numLevers], 1, 1);
            leverPulled = scrambledLevers(1);
        end
        
    % Record reward from the lever chosen
    meanLeverChosen = leverReal(leverPulled);
    reward(i) = LeverReward(meanLeverChosen);
    totalReward(leverPulled) = totalReward(leverPulled)+ reward(i);
   
    % Update estimate of lever reward
    numPullsDone(leverPulled) = numPullsDone(leverPulled) + 1;
    leverRewEst(leverPulled) =  totalReward(leverPulled)/numPullsDone(leverPulled);      
end

end