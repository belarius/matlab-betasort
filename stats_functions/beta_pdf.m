function pdf = beta_pdf ( x, a, b )
%BETA_PDF evaluates the Beta PDF.
%  Discussion:
%    PDF(X)(A,B) = X**(A-1) * (1-X)**(B-1) / BETA(A,B).
%    A = B = 1 yields the Uniform distribution on [0,1].
%    A = B = 1/2 yields the Arcsin distribution.
%        B = 1 yields the power function distribution.
%    A = B -> Infinity tends to the Normal distribution.
%  Licensing:
%    This code is distributed under the GNU LGPL license.
%  Modified:
%    20 March 2015
%  Author:
%    John Burkardt
%    Further modified by Greg Jensen for use with the betasort repository
%  Parameters:
%    Input, real X, the argument of the PDF.
%      0.0 <= X <= 1.0.
%    Input, real A, B, the parameters of the PDF.
%      0.0 < A,
%      0.0 < B.
%    Output, real PDF, the value of the PDF.
  pdf = zeros(size(x,1),size(x,2));
  dex = find((x > 0.0).*(x < 1.0));
  pdf(dex) = x(dex).^( a - 1.0 ) .* ( 1.0 - x(dex) ).^( b - 1.0 ) ./ local_beta ( a, b );
end

function value = local_beta ( a, b )
%BETA returns the value of the Beta function.
%  Discussion:
%    BETA(A,B) = ( GAMMA ( A ) * GAMMA ( B ) ) / GAMMA ( A + B )
%              = Integral ( 0 <= T <= 1 ) T**(A-1) (1-T)**(B-1) dT.
%  Licensing:
%    This code is distributed under the GNU LGPL license.
%  Modified:
%    02 September 2004
%  Author:
%    John Burkardt
%  Parameters:
%    Input, real A, B, the parameters of the function.
%      0.0D+00 < A,
%      0.0D+00 < B.
%    Output, real BETA, the value of the function.
  if ( a <= 0.0 || b <= 0.0 )
    fprintf ( 1, '\n' );
    fprintf ( 1, 'BETA - Fatal error!\n' );
    fprintf ( 1, '  Both A and B must be greater than 0.\n' );
    error ( 'BETA - Fatal error!' );
  end
  value = exp ( gammaln ( a ) + gammaln ( b ) - gammaln ( a + b ) );
  return
end
