function [softmax] = SoftMax(temp, numIter, leverReal)
% Using the softmax method chooses levers to pull
% Reward for each pull is determined, and levers are pulled numIter times

% Returns a vector, giving the reward obtained each lever pull

% leverReal =  Actual mean reward per leaver

% Estimate the mean reward of each lever
leverRewEst = zeros(1, numLevers); % Average reward received per lever
totalReward = zeros(1, numLevers); % How much reward received per lever
numPullsDone = zeros(1, numLevers); % Pulls per lever

% Uses Boltzmann distributionto estimate the value of the levers
probBoltzLever = zeros(1, numLevers); 

% Actual reward received
reward = zeros(1, numIter);

% Pull a lever and find reward for it numIter times
for i = 1:numIter
    
    % Pull a lever
        % Rank probability of choice of lever by past performance.
        % Use the boltzmann distribution (Thermodynamics)
         
        % The temperature selects how likely we think it is for the energy
        % to be spread out. That is, how much better we think one options
        % is likely to be compared to the others.

        
    % Record reward from the lever chosen
    meanLeverChosen = leverReal(leverPulled);
    reward(i) = LeverReward(meanLeverChosen);
    totalReward(leverPulled) = totalReward(leverPulled)+ reward(i);
   
    % Update estimate of lever reward
    numPullsDone(leverPulled) = numPullsDone(leverPulled) + 1;
    leverRewEst(leverPulled) =  totalReward(leverPulled)/numPullsDone(leverPulled);
    
    % Updates uniquely softmax estimate
    probBoltzLever =  exp(leverRewEst/temp) / sum(exp(leverRewEst/temp));
end

end
