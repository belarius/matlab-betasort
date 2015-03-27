function p = betasort_choose_prob(UL,ch,nc,noise)
%BETASORT_CHOOSE_PROB Probability in a two alternative choice from N alternative data using betasort
%   Detailed explanation goes here

if isnan(UL(ch,1))
	UL(ch,:) = 0;
end

if isnan(UL(nc,1))
	UL(nc,:) = 0;
end

fun = @(x,v) beta_pdf(x,v(1)+1,v(2)+1).*beta_cdf(x,v(3)+1,v(4)+1);
p = integral(@(x)fun(x,[UL(ch,1) UL(ch,2) UL(nc,1) UL(nc,2)]),0,1);

p = (1-noise).*p + noise.*(0.5);

end

