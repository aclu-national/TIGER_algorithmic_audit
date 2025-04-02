library(tidyverse)

input_vars <- list(
  access_car = 0:1,
  liscense = 0:1,
  n_jobs = 0:4,
  treatment = 0:3,
  not_problem = 0:3,
  life_hard = 0:3,
  not_bother = 0:3,
  alcohol = 0:4,
  more_drug = 0:1,
  see_fights = 0:1,
  homeless = 0:1,
  parole_revoked = 0:3
)

df <- expand.grid(
  input_vars
)


dynamic_risk_model2 <- function(X) {
  logit <- function(X) {
    -.200*X$access_car + 
    .172*X$liscense + 
    .019*X$n_jobs + 
    -.075*X$treatment + 
    3.069*X$not_problem + 
    .085*X$life_hard + 
    -.075*X$not_bother + 
    -.088*X$alcohol + 
    .087*X$more_drug + 
    .123*X$see_fights + 
    .158*X$homeless + 
    .186*X$parole_revoked
  }
  risk <- exp(logit(X)) / (1 + exp(logit(X)))
  return(risk)
}

df$pred <- dynamic_risk_model2(df)

df %>%
  ggplot(aes(x = pred)) + 
  geom_histogram()

mean(df$pred)
median(df$pred)
sd(df$pred)

