function [Bout, Rout] = Bupdate(B,R,c,calt,r,remem)
%BUPDATE Update betasort memory array following feedback
%   Detailed explanation goes here

c = c(:);
calt = calt(:);

% Relax rate representations
R([c;calt],:) = R([c;calt],:).*remem;
E = R(:,1)./sum(R,2);
remem_R = repmat(E./(E+1) + 0.5,1,2);

% Relax position representations
nandex = intersect(find(isnan(B(:,1))),[c;calt]);
B(nandex,:) = 0;
B = B.*remem_R.*remem;
V = B(:,1)./sum(B,2);
V(isnan(V)) = 0.5;

if r == 1 % When reward is delivered...
	% Increase reward rate for trial stimuli
	R([c;calt],1) = R([c;calt],1)+1;
	% Consolidate stimulus position for both trial and implicit stimuli
	B = B + [V 1-V];
else % Othwerwise...
	% Decrease reward rate for trial stimuli
	R([c;calt],2) = R([c;calt],2)+1;
	% Move trial stimuli positions apart
	B(c,:) = B(c,:) + [0 1];
	B(calt,:) = B(calt,:) + [1 0];
	% Shift all implicit stimuli relative to the upper and lower boundaries
	% set by the expected values of the trial stimuli.
	nonc = setxor((1:size(B,1))',[c;calt]);
	bot_post = min(V(c));
	top_post = max(V(calt));
	for i = 1:length(nonc)
		j = nonc(i);
		if V(j) > bot_post && V(j) < top_post
			% Implicit stimuli bounded by the trial stimuli are
			% consolidated
			B(j,:) = B(j,:) + [V(j) 1-V(j)];
		elseif V(j) < top_post
			% Implicit stimuli below the trial stimuli are shifted down
			B(j,:) = B(j,:) + [0 1];
		elseif V(j) > bot_post
			% Implicit stimuli above the trial stimuli are shifted up
			B(j,:) = B(j,:) + [1 0];
		end
	end
end

Rout = R;
Bout = B;

end
