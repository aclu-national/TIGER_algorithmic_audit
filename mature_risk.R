library(tidyverse)

input_vars <- list(
  mental_health_level = 1:6,
  history_revocations = 0:2,
  felony_convictions = 0:2,
  crime_type_other = 0:1,
  crime_type_property = 0:1,
  crime_type_sexual_violent = 0:1,
  crime_type_violent = 0:1,
  prior_recidivisms = 0:5
)

df <- expand.grid(
  input_vars
)

mature_risk_model <- function(X) {
  logit <- function(X) {
    -0.021*X$mental_health_level +
      0.077*X$history_revocations + 
      0.01*X$felony_convictions + 
      0.482*X$prior_recidivisms + 
      0.331*X$crime_type_other + 
      0.077*X$crime_type_property + 
      0.175*X$crime_type_sexual_violent + 
      0.025*X$crime_type_violent
  }
 risk <- exp(logit(X)) / (1 + exp(logit(X)))
 return(risk)
}

df$pred <- mature_risk_model(combinations)

df %>%
  ggplot(aes(x = pred)) + 
  geom_histogram()

mean(df$pred)
median(df$pred)
sd(df$pred)