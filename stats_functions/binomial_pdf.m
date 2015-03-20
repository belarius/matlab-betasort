function pdf = binomial_pdf ( x, N, p )
%BINOMIAL_PDF evaluates the Binomial PDF.
%  Discussion:
%    PDF(X)(N,B) is the probability of exactly X successes in N trials,
%      given that the probability of success on a single trial is p.
%    PDF(X)(N,p) = C(N,X) * p**X * ( 1.0D+00 - p )**( N - X )
%    Binomial_PDF(X)(1,p) = Bernoulli_PDF(X)(p).
%  Licensing:
%    This code is distributed under the GNU LGPL license.
%  Modified:
%    20 March 2015
%  Author:
%    John Burkardt
%    Further modified by Greg Jensen for use with the betasort repository
%  Parameters:
%    Input, integer X, the desired number of successes.
%      0 <= X <= N.
%    Input, integer N, the number of trials.
%      1 <= N.
%    Input, real p, the probability of success on one trial.
%      0.0 <= p <= 1.0.
%    Output, real PDF, the value of the PDF.
	pdf = zeros(size(x,1),size(x,2));
	if N >= 1
		pdf(x<0) = 0.0;
		pdf(x>N) = 0.0;
		if p == 0
			pdf(x==0) = 1.0;
		elseif p == 1
			pdf(x==N) = 1.0;
		else
			dex = find((x>=0)&&(x<=N));
			for i = 1:length(dex)
				cnk = local_binomial_coef ( N, x(i) );
				pdf(i) = cnk * p^x(i) * ( 1.0 - p )^( N - x(i) );
			end
		end
	end
	return
end

function cnk = local_binomial_coef ( n, k )
%BINOMIAL_COEF computes the Binomial coefficient C(N,K).
%  Discussion:
%    The value is calculated in such a way as to avoid overflow and
%      roundoff.  The calculation is done in integer arithmetic.
%    CNK = C(N,K) = N! / ( K! * (N-K)! )
%  Licensing:
%    This code is distributed under the GNU LGPL license.
%  Modified:
%    03 September 2004
%  Author:
%    John Burkardt
%  Reference:
%    M L Wolfson and H V Wright,
%    Combinatorial of M Things Taken N at a Time,
%    ACM Algorithm 160,
%    Communications of the ACM,
%    April, 1963.
%  Parameters:
%    Input, integer N, K, are the values of N and K.
%    Output, integer CNK, the number of combinations of N
%      things taken K at a time.
mn = min ( k, n-k );
if ( mn < 0 )
	cnk = 0;
elseif ( mn == 0 )
	cnk = 1;
else
	mx = max ( k, n-k );
	cnk = mx + 1;
	for i = 2 : mn
		cnk = round ( ( cnk * ( mx + i ) ) / i );
	end
end
return
end

