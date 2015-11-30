function [reward] = LeverReward(leverMeanReward)
% Standard deviation
std = 0.1;
reward = normrnd(leverMeanReward,std);

end
