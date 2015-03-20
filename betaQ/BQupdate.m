function [Bout, Rout] = BQupdate(B,R,ch,nc,r,remem)
%BQUPDATE Summary of this function goes here
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
B([ch;nc],:) = B([ch;nc],:).*remem_R([ch;nc],:).*remem;
V = B(:,1)./sum(B,2);
V(isnan(V)) = 0.5;

if r == 1 % When reward is delivered...
	% Increase reward rate for trial stimuli
	R([ch;nc],1) = R([ch;nc],1)+1;
	% Consolidate stimulus position for both trial and implicit stimuli
	B([ch;nc],1) = B([ch;nc],1)+V([ch;nc]);
	B([ch;nc],2) = B([ch;nc],2)-V([ch;nc])+1;
else % Othwerwise...
	% Decrease reward rate for trial stimuli
	R([ch;nc],2) = R([ch;nc],2)+1;
	% Move trial stimuli positions apart
	B(ch,2) = B(ch,2)+1;
	B(nc,1) = B(nc,1)+1;
end

Rout = R;
Bout = B;

end
