function ULout = betaQ_UL_update(UL,RN,ch,nc,outcome,remem)
%BETAQ_UL_UPDATE Summary of this function goes here
%   Detailed explanation goes here

ch = ch(:);
nc = nc(:);

% Relax rate representations
E = RN(:,1)./sum(RN,2);
remem_R = repmat(E./(E+1) + 0.5,1,2);

% Relax position representations
nandex = intersect(find(isnan(UL(:,1))),[ch;nc]);
UL(nandex,:) = 0;
UL([ch;nc],:) = UL([ch;nc],:).*remem_R([ch;nc],:).*remem;
V = UL(:,1)./sum(UL,2);
V(isnan(V)) = 0.5;

if outcome == 1 % When reward is delivered...
	% Consolidate stimulus position for both trial and implicit stimuli
	UL([ch;nc],1) = UL([ch;nc],1)+V([ch;nc]);
	UL([ch;nc],2) = UL([ch;nc],2)-V([ch;nc])+1;
else % Othwerwise...
	% Move trial stimuli positions apart
	UL(ch,2) = UL(ch,2)+1;
	UL(nc,1) = UL(nc,1)+1;
end

ULout = UL;

end

