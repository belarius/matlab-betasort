function c = betasort_choose(B,actions,noise,num)
%BETASORT_CHOOSE Choice from N alternative data using betasort
%   Detailed explanation goes here

if nargin < 4
	num = 1;
end
actions = actions(:);

% Initialize unfamiliar stimuli
for i = 1:length(actions)
	if isnan(B(actions(i),1))
		B(actions(i),:) = 0;
	end
end

if rand() < noise % If noise...
	% Choose one of the available actions at random
	c = actions(randi(length(actions)));
else % Otherwise...
	C = zeros(length(actions),1);
	% Generate random values using beta distributions for each action
	for i = 1:length(actions)
		C(i) = genbet(B(actions(i),1)+1,B(actions(i),2)+1);
	end
	% Select the largest (num) actions, in that order
	C = flipud(sortrows([actions C],2));
	c = C(1:(num),1);
end

end

