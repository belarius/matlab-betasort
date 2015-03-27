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
	for t = 1:length(r)
		p = betasort_choose_prob(UL,c(t,1),c(t,2),noise);
		if c(t,1) < c(t,2)
			e_r(t) = p;
		else
			e_r(t) = 1-p;
		end
		LLH = LLH - log(p);
		RN = betasort_RN_update(RN,c(t,1),c(t,2),r(t),remem);
		UL = betasort_UL_update(UL,RN,c(t,1),c(t,2),r(t),remem);
	end
	LLH = LLH - log(binomial_pdf(round(sum(e_r)),length(r),mean(r)));
end

end

