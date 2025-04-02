library(tidyverse)

sample_size = 1000000

df <- data.frame(
  gender = sample(0:1,sample_size,TRUE),
  felony_convictions = sample(0:2,sample_size,TRUE),
  age = sample(18:92,sample_size,TRUE),
  offender_class = sample(1:15,sample_size,TRUE),
  time_served = sample(0:672,sample_size,TRUE),
  previous_probation = sample(0:1,sample_size,TRUE),
  previous_parole = sample(0:1,sample_size,TRUE),
  total_sanctions = sample(0:34,sample_size,TRUE),
  total_violations = sample(0:63,sample_size,TRUE),
  current_probation = sample(0:1,sample_size,TRUE),
  ever_revoked = sample(0:1,sample_size,TRUE)
)

supervision_risk_model <- function(X) {
  logit <- function(X) {
    -0.020*X$gender + 
    0.002*X$felony_convictions + 
    -0.037*X$age + 
    0.000*X$age^2 + 
    0.020*X$offender_class + 
    0.001*X$time_served + 
    0.105*X$previous_probation + 
    -0.079*X$previous_parole + 
    -0.066*X$total_sanctions + 
    0.005*X$total_sanctions^2 + 
    0.008*X$total_violations + 
    -0.092*X$current_probation + 
    0.170*X$ever_revoked
  }
  risk <- exp(logit(X)) / (1 + exp(logit(X)))
  return(risk)
}

df$pred <- supervision_risk_model(df)

df %>%
  ggplot(aes(x = pred)) + 
  geom_histogram()

mean(df$pred)
median(df$pred)
sd(df$pred)