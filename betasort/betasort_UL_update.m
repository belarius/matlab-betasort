function [Bout, Rout] = Bupdate(B,R,ch,nc,r,remem)
%BUPDATE Update betasort memory array following feedback
%   Detailed explanation goes here

ch = ch(:);
nc = nc(:);

% Relax rate representations
R([ch;nc],:) = R([ch;nc],:).*remem;
E = R(:,1)./sum(R,2);
remem_R = repmat(E./(E+1) + 0.5,1,2);

% Relax position representations
nandex = intersect(find(isnan(B(:,1))),[ch;nc]);
B(nandex,:) = 0;
B = B.*remem_R.*remem;
V = B(:,1)./sum(B,2);
V(isnan(V)) = 0.5;

if r == 1 % When reward is delivered...
	% Increase reward rate for trial stimuli
	R([ch;nc],1) = R([ch;nc],1)+1;
	% Consolidate stimulus position for both trial and implicit stimuli
	B = B + [V 1-V];
else % Othwerwise...
	% Decrease reward rate for trial stimuli
	R([ch;nc],2) = R([ch;nc],2)+1;
	% Move trial stimuli positions apart
	B(ch,2) = B(ch,2) + 1; 
	B(nc,1) = B(nc,1) + 1;
	% Shift all implicit stimuli relative to the upper and lower boundaries
	% set by the expected values of the trial stimuli.
	nonc = setxor((1:size(B,1))',[ch;nc]);
	bot_post = min(V(ch));
	top_post = max(V(nc));
	for i = 1:length(nonc)
		j = nonc(i);
		if V(j) > bot_post && V(j) < top_post
			% Implicit stimuli bounded by the trial stimuli are
			% consolidated
			B(j,:) = B(j,:) + [V(j) 1-V(j)];
		elseif V(j) < top_post
			% Implicit stimuli below the trial stimuli are shifted down
			B(j,2) = B(j,2) + 1;
		elseif V(j) > bot_post
			% Implicit stimuli above the trial stimuli are shifted up
			B(j,1) = B(j,1) + 1;
		end
	end
end

Rout = R;
Bout = B;

end

