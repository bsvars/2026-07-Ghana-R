
install.packages("bpvars")                        # install the package

library(bpvars)                                   # load the package
tail(ilo_dynamic_panel$COL, 8)                    # inspect Colombian data


# specify, estimate, forecast, and plot
##########################################
spec = specify_bvarPANEL$new(                           # specify the model
  ilo_dynamic_panel,                                    # data
  exogenous = ilo_exogenous_variables                   # exogenous variables
)

burn = estimate(spec, S = 5000, show_progress = FALSE) # run the burn-in
post = estimate(burn, S = 5000)                        # estimate the model

fore = forecast(                                    # forecast the model
  post,                                             # estimation output
  horizon = 3,                                      # forecast horizon
  exogenous_forecast = ilo_exogenous_forecasts,     # forecasts for exogenous variables
) 
plot(fore, "GHA", main = "Forecasts for Ghana")   # plot the forecasts

summ = summary(fore, "GHA")                       # compute forecast summaries
summ$variable2                                    # report forecasts for UR

post |>                                              # estimation output
  compute_variance_decompositions(horizon = 5) |>    # compute variance decompositions
  plot(which_c = "GHA")                              # plot variance decompositions 

# a model with rates restrictions
##########################################
specr = specify_bvarPANEL$new(                           # specify the model
  ilo_dynamic_panel,                                     # data
  exogenous = ilo_exogenous_variables,                   # exogenous variables
  type = c("real","rate","rate","rate")                  # set variable type
)

burnr = estimate(specr, S = 5000, show_progress = FALSE) # run the burn-in
postr = estimate(burnr, S = 5000)                        # estimate the model

forer = forecast(                                   # forecast the model
  postr,                                            # estimation output
  horizon = 3,                                      # forecast horizon
  exogenous_forecast = ilo_exogenous_forecasts,     # forecasts for exogenous variables
) 
plot(forer, "GHA", main = "Forecasts for Ghana")    # plot the forecasts

# a model with missing data
##########################################
specm = specify_bvarPANEL$new(                           # specify the model
  ilo_dynamic_panel_missing                              # data with missing observations
)

burnm = estimate(specm, S = 5000, show_progress = FALSE) # run the burn-in
postm = estimate(burnm, S = 5000)                        # estimate the model

forem = forecast(                                   # forecast the model
  postm,                                            # estimation output
  horizon = 3                                       # forecast horizon
) 
plot(forem, "GHA", main = "Forecasts for Ghana")    # plot the forecasts
