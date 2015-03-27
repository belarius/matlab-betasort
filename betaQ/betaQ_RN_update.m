function RNout = betaQ_RN_update(RN,ch,nc,reward,remem)
%BQUPDATE Summary of this function goes here
%   Detailed explanation goes here

ch = ch(:);
nc = nc(:);

% Relax rate representations
RN([ch;nc],:) = RN([ch;nc],:).*remem;

if reward == 1 % When reward is delivered...
	% Increase reward rate for trial stimuli
	RN([ch;nc],1) = RN([ch;nc],1)+1;
else % Othwerwise...
	% Decrease reward rate for trial stimuli
	RN([ch;nc],2) = RN([ch;nc],2)+1;
end

RNout = RN;

end

