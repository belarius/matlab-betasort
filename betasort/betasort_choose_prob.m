function p = betasort_choose_prob(UL,ch,nc,noise)
%BETASORT_CHOOSE_PROB Probability of choosing ch from N alternative data using betasort
%   N = length(ch) + length(nc)

all = [ch(:);nc(:)];

UL(isnan(UL(:,1)),:) = 0;

fun = @(x,v,UL) (...
	beta_pdf(x,v(1)+1,v(2)+1).*local_cdf_stack(x,UL) ...
	);

if isempty(nc)
	p = 1;
else
	p = integral(@(x)fun(x,[UL(ch,1) UL(ch,2)],UL(nc,:)),0,1);
end

p = (1-noise).*p + noise.*(1./length(all));

end

function p = local_cdf_stack(x,UL)
	p = 1;
	for i = 1:size(UL,1)
		p = p.*beta_cdf(x,UL(i,1)+1,UL(i,2)+1);
	end
end