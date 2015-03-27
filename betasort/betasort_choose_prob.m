function p = betasort_choose_prob(B,ch,nc,noise)
%BETASORT_CHOOSE_PROB Probability in a two alternative choice from N alternative data using betasort
%   Detailed explanation goes here

if isnan(B(ch,1))
	B(ch,:) = 0;
end

if isnan(B(nc,1))
	B(nc,:) = 0;
end

fun = @(x,v) beta_pdf(x,v(1)+1,v(2)+1).*beta_cdf(x,v(3)+1,v(4)+1);
p = integral(@(x)fun(x,[B(ch,1) B(ch,2) B(nc,1) B(nc,2)]),0,1);

p = (1-noise).*p + noise.*(0.5);

end

