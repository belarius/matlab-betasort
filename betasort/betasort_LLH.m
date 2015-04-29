function LLH = betasort_LLH(ULstart,RNstart,c,r,noise,remem)
%BETASORT_LLH Calculate negative log-likelihood associated with string of behaviors and
%outcomes using the betasort algorithm.
%   Note: A penalty is applied based on the expected rate of reward. This
%   is done because otherwise the interaction between rewards and
%   subsequent behavior can in some cases favor parameters that
%   subsequently yields behavior that does not resembles the original
%   input.

if noise < 0 || noise > 1 || remem < 0 || remem > 1
	LLH = -length(r).*log(0.0001);
else
	e_r = zeros(length(r),1);
	UL = ULstart;
	RN = RNstart;
	LLH = 0;
	if isnumeric(c)
		for t = 1:length(r)
			[LLH,e_r,UL,RN] = local_updater(noise,remem,t,c,r,e_r,UL,RN,LLH);
		end
	elseif iscell(c)
		for t = 1:length(r)
			c_temp = cell2mat(c(t,:));
			[LLH,e_rt,UL,RN] = local_updater(noise,remem,1,c_temp,r(t),0,UL,RN,LLH);
			e_r(t) = e_rt;
		end
	end
	LLH = LLH - log(binomial_pdf(round(sum(e_r)),length(r),mean(r)));
end

end

function [LLH,e_r,UL,RN] = local_updater(noise,remem,t,c,r,e_r,UL,RN,LLH)

if length(c)==1
	p = 1;
	e_r(t) = p;
	RN = betasort_RN_update(RN,c(t,1),[],r(t),remem);
	UL = betasort_UL_update(UL,RN,c(t,1),[],r(t),remem);
else
	p = betasort_choose_prob(UL,c(t,1),c(t,2:end),noise);
	if c(t,1) == min(c(t,:))
		e_r(t) = p;
	else
		c_sort = sort(c);
		e_r(t) = betasort_choose_prob(UL,c_sort(t,1),c_sort(t,2:end),noise);
	end
	RN = betasort_RN_update(RN,c(t,1),c(t,2),r(t),remem);
	UL = betasort_UL_update(UL,RN,c(t,1),c(t,2),r(t),remem);
end
LLH = LLH - log(p);

end
