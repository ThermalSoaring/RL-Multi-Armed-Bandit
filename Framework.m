function Framework()
% Plots the reward per pull as a function of # of tries.
% Does many trials to smooth out results
% Tries different epsilons or greediness levels

method = 'grEp';

epsilon = [0 0.01 0.1 0.5];
cols = ['r','b','y','g'];

temp = 100; % Softmax parameter
% Ranks probability of trying an option by how good they've been so far. 
% At t = 0, is greedy choice.
% At large t, chooses without regard of past performance.

for e = 1:length(epsilon) % Greedy epsilon method
    numPullsPerTrial = 100; 
    numTrials = 250;
    numLevers = 10;

    % In each row, store the reward results in one trial
    reward = zeros(numTrials, numPullsPerTrial);
    bestLevers = zeros(numTrials, 1);

    for t = 1:numTrials   
        levers = GenerateLevers(numLevers);
        bestLevers(t,1) = max(levers);
        if (strcmp(method,'grEp'))
            reward(t,:) = GreedyEps(epsilon(e), numPullsPerTrial, levers);
        else
            reward(t,:) = SoftMax(temp, numPullsPerTrial, levers);
        end
    end

    % Average the rows to get the average reward at various times
    % To do this, we take the average of each column
    avgReward = mean(reward);
    avgBest = mean(bestLevers);

    % Plot the average award across many trials
    plot(avgReward/avgBest,cols(e))
    hold on

    % Plot the maximum reward possible
    bestLever = avgBest/avgBest;
    plot([0 numPullsPerTrial], [1 1]*bestLever,'-r' );      
end

