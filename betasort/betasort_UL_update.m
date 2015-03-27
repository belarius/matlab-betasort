function ULout = betasort_UL_update(UL,RN,ch,nc,outcome,remem)
%BETASORT_UL_UPDATE Update betasort memory array following feedback
%   Detailed explanation goes here

ch = ch(:);
nc = nc(:);

% Relax rate representations
E = RN(:,1)./sum(RN,2);
remem_RN = repmat(E./(E+1) + 0.5,1,2);

% Relax position representations
nandex = intersect(find(isnan(UL(:,1))),[ch;nc]);
UL(nandex,:) = 0;
UL = UL.*remem_RN.*remem;
V = UL(:,1)./sum(UL,2);
V(isnan(V)) = 0.5;

if outcome == 1 % When reward is delivered...
	% Consolidate stimulus position for both trial and implicit stimuli
	UL = UL + [V 1-V];
else % Othwerwise...
	% Move trial stimuli positions apart
	UL(ch,2) = UL(ch,2) + 1; 
	UL(nc,1) = UL(nc,1) + 1;
	% Shift all implicit stimuli relative to the upper and lower boundaries
	% set by the expected values of the trial stimuli.
	nonc = setxor((1:size(UL,1))',[ch;nc]);
	bot_post = min(V(ch));
	top_post = max(V(nc));
	for i = 1:length(nonc)
		j = nonc(i);
		if V(j) > bot_post && V(j) < top_post
			% Implicit stimuli bounded by the trial stimuli are
			% consolidated
			UL(j,:) = UL(j,:) + [V(j) 1-V(j)];
		elseif V(j) < top_post
			% Implicit stimuli below the trial stimuli are shifted down
			UL(j,2) = UL(j,2) + 1;
		elseif V(j) > bot_post
			% Implicit stimuli above the trial stimuli are shifted up
			UL(j,1) = UL(j,1) + 1;
		end
	end
end

ULout = UL;

end

