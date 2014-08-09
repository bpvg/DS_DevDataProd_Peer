#################################
#    Black-Scholes functions    #
#################################


# Returns the number of years between two dates
# I assumed Act/365 day count fraction
time2expiry <- function(Tdy, Dt){
    Dt <- as.Date(Dt)
    dif <- diff(as.numeric(strptime(c(Tdy, Dt), "%Y-%m-%d")))
    return(dif/(60*60*24*365)) 
}

# Returns the forward price of an asset given the spot price, interest rate, 
# dividend yield and time until maturity
Fwd <- function(S, Rt, DY, Tm){
    return( S * exp((Rt-DY)*Tm) )
}

# Auxiliary functions for CALL and PUT pricing
d1 <- function(Fw, K, Tm, Vol, Rt, DY){
    return( (log(Fw/K) + (1/2)*(Vol^2)*Tm)/(Vol*sqrt(Tm)) ) 
}
d2 <- function(d, Vol, Tm){
    return(d - Vol*sqrt(Tm))
}


# European Call valuation and greeks
Call <- function(Spot, Strike, Today, Maturity, Vol, Rate, DivY){
    T2M <- time2expiry(Today, Maturity)
    f <- Fwd(Spot, Rate, DivY, T2M)
    d_1 <- d1(f, Strike, T2M, Vol, Rate, DivY)
    d_2 <- d2(d_1, Vol, T2M)
    
    #computing premium and major greeks
    pre <- exp(-Rate*T2M) * (f * pnorm(d_1) - Strike * pnorm(d_2))
    del <- pnorm(d_1) * exp(-DivY*T2M)
    gam <- exp(-DivY*T2M) * dnorm(d_1) / (Spot * Vol * sqrt(T2M))
    the <- (-exp(-DivY*T2M) * (Spot * dnorm(d_1) * Vol) / (2 * sqrt(T2M)) - 
                Rate * Strike * exp(-Rate*T2M) * pnorm(d_2) + 
                DivY * Spot * exp(-DivY*T2M) * pnorm(d_1)) / 365   #daily theta
    veg <- (Spot * exp(-DivY*T2M) * dnorm(d_1) * sqrt(T2M)) / 100  #%
    rh  <- (Strike * T2M * exp(-Rate*T2M) * pnorm(d_2)) / 100    #%
    
    # returning results as a list
    r <- list(premium = pre,
              delta   = del,
              gamma   = gam,
              theta   = the,
              vega    = veg,
              rho     = rh)
    return(r)
}


Calculator <- function(Spot, Strike, Maturity, Vol, Rate, DivY){
    
    C <- Call(Spot, Strike, Sys.Date(), Maturity, Vol, Rate, DivY)
    
    P<-0
    
    return(list(Call=C, Put=P))
}