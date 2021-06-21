# Call the packages ------

library(brms)
options(mc.cores = parallel::detectCores())
rstan_options(auto_write = TRUE)
library(bayesplot)
library(MCMCvis)
library(mcmcplots)
library(bayestestR)
library(logspline)
library("ggplot2")
library(haven)

# REGRESSION MODE, FOUR DISCRIMINATION PREDICTORS --------

Bayesian_Data_Set <- read_sav("C:/Users/abigailgabriel/Dropbox (ASU)/Bayesian Data Set.sav")
View(Bayesian_Data_Set)

# Choose features of MCMC --------
#   the number of chains
#   the number of iterations to burn-in, 
#	  the number of iterations to thin by,
#	  the total number of iterations 
n.chains = 4
n.warmup = 1000
n.thin = 1
n.iters.per.chain.after.warmup = 5000
n.iters.total.per.chain = n.iters.per.chain.after.warmup+n.warmup


# Run MCMC -----------

# Fit the model in stan ------
fitted.model.2 <- brm(
  BHS ~ 0 + Intercept + PERCA + OMERR + VERCA + COVID,
  prior = c(set_prior("normal (0, 30)", class="b", coef = "Intercept"),
            set_prior("normal(.23, .03)", class="b", coef = "PERCA"),
            set_prior("normal(.23, .03)", class="b", coef = "OMERR"),
            set_prior("normal(.23, .03)", class="b", coef = "VERCA"),
            set_prior("normal(.23, .03)", class="b", coef = "COVID"),
            set_prior("exponential(1)", class="sigma")
  ),
  data=Bayesian_Data_Set,
  chains=n.chains,
  warmup=n.warmup,
  iter=n.iters.total.per.chain,
  save_all_pars = TRUE,    # Save parameters, needed for fit and bayes factor functions
  save_model = "model.stan",
  diagnostic_file = "fitted.model.diagnostic.file.csv"
)


# Convergence Assessment --------


# convert draws to mcmc.list
draws.as.mcmc.list <- MCMCchains(fitted.model.2, 
                                 mcmc.list = TRUE)


# Define the names of parameters to use for convergence assessment
parameters.for.convergence <- colnames(as.matrix(draws.as.mcmc.list))
parameters.for.convergence <- parameters.for.convergence[!is.element(parameters.for.convergence, c("lp__"))]

# Define the draws to analyze
draws.to.analyze <- draws.as.mcmc.list



# Plot the results
# trace, densities, and autocorrelations
mcmcplot(
  mcmcout = draws.to.analyze,
  parms = parameters.for.convergence,
  dir = getwd(),
  style="plain",
  filename = "MCMC Plots for Convergence Assessment"
)


# Plot R-hat (Gelman-Rubin) diagnostics
# Open a plot
png(paste0("Rhat Plot", ".png"))

# Form the plot
gelman.plot(draws.to.analyze)

# Close the plot
dev.off()




# Posterior Summary --------


# Look at some diagnostics to confirm want to proceed
summary(fitted.model.2)

# Decide on the burn-in 
n.burnin=0 

# Define the draws to analyze
draws.to.analyze <- window(draws.as.mcmc.list,
                           start=n.burnin+1)

# * Compute R squared -----

# Compute R squared
R.squared <- bayes_R2(fitted.model.2, summary=FALSE)


# Combine R squared with other draws from MCMC
draws.to.analyze.as.one.list <- as.mcmc(do.call(rbind,draws.to.analyze), R.squared) 

# Define the names of parameters to use for posterior summary
parameters.to.summarize <- c(colnames(as.matrix(draws.as.mcmc.list)), "R2")
parameters.to.summarize <- parameters.to.summarize[!is.element(parameters.to.summarize, c("lp__"))]

# drop extraneous variables
draws.to.analyze.as.data.frame <- cbind(data.frame(draws.to.analyze.as.one.list), R.squared)
draws.to.analyze.as.data.frame <- subset(draws.to.analyze.as.data.frame, select=parameters.to.summarize)

# convert to mcmc object
draws.to.analyze <- as.mcmc(draws.to.analyze.as.data.frame)

# convert to an mcmc.list for functions below
draws.to.analyze <- as.mcmc.list(draws.to.analyze)




# Plot posterior densities
# Open a plot
png(paste0("Density Plot", ".png"))

# Form the plot
color_scheme_set("purple")
mcmc_dens(
  draws.to.analyze,
  pars = parameters.to.summarize
)

# Close the plot
dev.off()



# Plot posterior densities with summaries
# Open a plot
png(paste0("Density Plot with Summaries", ".png"))

# Form the plot
mcmc_areas(
  draws.to.analyze,
  pars = parameters.to.summarize,
  prob = 0.95, # 95% intervals
  prob_outer = 1, # 100% coverage
  point_est = "mean"
)

# Close the plot
dev.off()

# Plot posterior densities with summaries for slopes
# Open a plot
png(paste0("Density Plot with Summaries for Slopes", ".png"))

# Form the plot
mcmc_areas(
  draws.to.analyze,
  pars = c("PERCA", "OMERR", "VERCA","COVID"),
  prob = 0.95, # 95% intervals
  prob_outer = 1, # 100% coverage
  point_est = "mean"
)

# Close the plot
dev.off()



# Plot posterior scatterplot matrix
# Open a plot
png(paste0("Scatterplot Matrix Plot", ".png"))

# Form the plot
# Note that each bivariate plot uses half the chains
color_scheme_set("purple")
mcmc_pairs(
  draws.to.analyze,
  pars = parameters.to.summarize,
)

# Close the plot
dev.off()




# Compute the summary statistics
summary.statistics <- MCMCsummary(
  draws.to.analyze,
  params = parameters.to.summarize,
  HPD=TRUE,
  Rhat=FALSE, # Cannot compute because combined into one chain 
  round=2, 
  func=median, 
  func_name = "median"
)

# Write out the summary statistics
file.name="Summary Statistics.csv"
write.csv(
  x=summary.statistics,
  file=file.name
)


##############################################################################
##############################################################################
##############################################################################
##############################################################################
##############################################################################




# Conduct PPMC ------

# * Generate posterior predictive data -----
# each row is a draw from the posterior predictive distribution
x.rep <- posterior_predict(fitted.model.2)

#create vector
BHSVector <- Bayesian_Data_Set$BHS

# * Density plot of observed data and some posterior predictive data ----
# Open a plot
png(paste0("PP Density Plot", ".png"))

# Form the plot
color_scheme_set("green")
ppc_dens_overlay(y = BHS,
                 yrep = x.rep[1:50,])

# Close the plot
dev.off()

#ERROR CHECK
rlang::last_error()

# * Histogram plot of observed data and some posterior predictive data ----
# Open a plot
png(paste0("PP Histograms Plot", ".png"))

# Form the plot
color_scheme_set("green")
ppc_hist(Bayesian_Data_Set$BHS,
                 x.rep[1:10,])

# Close the plot
dev.off()


# * Scatterplots of posterior predictive intervals and observed data  ----

# Plot for first predictor
# Open a plot
png(paste0("PP Scatterplot by PERCA", ".png"))

# Form the plot
color_scheme_set("green")
ppc_intervals(
  y = Bayesian_Data_Set$BHS,
  yrep = x.rep,
  x = Bayesian_Data_Set$PERCA,
  prob = 0.8
) +
  labs(
    x = "PERCA",
    y = "BHS",
    title = "80% posterior predictive intervals \nvs observed BHS",
    subtitle = "by PERCA"
  ) +
  panel_bg(fill = "gray95", color = NA) +
  grid_lines(color = "white")

# Close the plot
dev.off()


# Plot for second predictor
# Open a plot
png(paste0("PP Scatterplot by OMERR", ".png"))

# Form the plot
color_scheme_set("green")
ppc_intervals(
  y = Bayesian_Data_Set$BHS,
  yrep = x.rep,
  x = Bayesian_Data_Set$OMERR,
  prob = 0.8
) +
  labs(
    x = "OMERR",
    y = "BHS",
    title = "80% posterior predictive intervals \nvs observed BHS",
    subtitle = "by OMERR"
  ) +
  panel_bg(fill = "gray95", color = NA) +
  grid_lines(color = "white")

# Close the plot
dev.off()

# Plot for third predictor
# Open a plot
png(paste0("PP Scatterplot by VERCA", ".png"))

# Form the plot
color_scheme_set("green")
ppc_intervals(
  y = Bayesian_Data_Set$BHS,
  yrep = x.rep,
  x = Bayesian_Data_Set$VERCA,
  prob = 0.8
) +
  labs(
    x = "VERCA",
    y = "BHS",
    title = "80% posterior predictive intervals \nvs observed BHS",
    subtitle = "by VERCA"
  ) +
  panel_bg(fill = "gray95", color = NA) +
  grid_lines(color = "white")

# Close the plot
dev.off()

# Plot for forth predictor
# Open a plot
png(paste0("PP Scatterplot by COVID", ".png"))

# Form the plot
color_scheme_set("green")
ppc_intervals(
  y = Bayesian_Data_Set$BHS,
  yrep = x.rep,
  x = Bayesian_Data_Set$COVID,
  prob = 0.8
) +
  labs(
    x = "COVID",
    y = "BHS",
    title = "80% posterior predictive intervals \nvs observed BHS",
    subtitle = "by COVID"
  ) +
  panel_bg(fill = "gray95", color = NA) +
  grid_lines(color = "white")

# Close the plot
dev.off()


# * PPMC plots for min and max values  ----

# Plot for the minimum
# Open a plot
png(paste0("PP min of BHS", ".png"))

# Form the plot
color_scheme_set("green")
ppc_stat(Bayesian_Data_Set$BHS, x.rep, stat = "min")

# Close the plot
dev.off()


# Plot for the maximum
# Open a plot
png(paste0("PP max of BHS", ".png"))

# Form the plot
color_scheme_set("green")
ppc_stat(Bayesian_Data_Set$BHS, x.rep, stat = "max")

# Close the plot
dev.off()



