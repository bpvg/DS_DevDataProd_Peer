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
