testc2 <- function(fa1, fa2, n1_n, n2_n){

  # if any input is NaN, it was computed as zero divided by zero; replace by 1e-10
  props = c(fa1, fa2)
  if (any(is.nan(props))){warning("Proportions in the data equal to 0; replaced by 1e-10")}
  props[is.nan(props)] <- 1e-10
    
  # replace 0 and 1 by close approximations to avoid Inf values
  if (any(props==0)){warning("Proportions in the data equal to 0; replaced by 1e-10")}
  props[props==0] <- 1e-10
  if (any(props==1)){warning("Proportions in the data equal to 1; replaced by 1-(1e-10)")}
  props[props==1] <- 1-1e-10
  fa1 <- props[1]
  fa2 <- props[2]
  
  # compute c1 and c2
  c1 <- qnorm(fa1)
  c2 <- qnorm(fa2)
  
  # compute variance of c1 and c2
  var_c1 <- ( (fa1*(1 - fa1)) / (n1_n*dnorm(qnorm(fa1))^2) )
  var_c2 <- ( (fa2*(1 - fa2)) / (n2_n*dnorm(qnorm(fa2))^2) )

  #compute z-score
  z <- (c1 - c2) / (sqrt(var_c1 + var_c2))
  
  #compute p-value, two-tailed
  p_val <- 2 * (pnorm(-abs(z)))
  
  #output
  return(list(c=(c(c1,c2)), var=(c(var_c1,var_c2)), z=z, p_value=p_val))
}