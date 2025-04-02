library(tidyverse)

sample_size = 1000000

df <- data.frame(
  age_first_arrest = sample(8:76, sample_size, replace = TRUE),
  mental_health_level = sample(1:6, sample_size, replace = TRUE),
  gender = sample(0:1, sample_size, replace = TRUE),
  marijuana_conviction = sample(0:1, sample_size, replace = TRUE),
  history_revocations = sample(0:2, sample_size, replace = TRUE),
  age_release = sample(2920:33580, sample_size, replace = TRUE), # Sketchy
  employment_history = sample(0:1, sample_size, replace = TRUE),
  history_drugs_alcohol = sample(0:2, sample_size, replace = TRUE),
  felony_convictions = sample(0:2, sample_size, replace = TRUE),
  crime_type_other = sample(0:1, sample_size, replace = TRUE),
  crime_type_property = sample(0:1, sample_size, replace = TRUE),
  crime_type_sex = sample(0:1, sample_size, replace = TRUE),
  crime_type_sexual_violent = sample(0:1, sample_size, replace = TRUE),
  crime_type_violent = sample(0:1, sample_size, replace = TRUE),
  offender_class = sample(1:22, sample_size, replace = TRUE),
  time_served = sample(0:48, sample_size, replace = TRUE),
  p07_job_placement = sample(0:1, sample_size, replace = TRUE),
  prior_recidivisms = sample(0:5, sample_size, replace = TRUE)
)

institutional_risk_model2 <- function(X) {
  logit <- function(X) {
    0.003*X$age_first_arrest + 
    -0.006*X$mental_health_level + 
    0.043*X$gender + 
    -0.011*X$marijuana_conviction + 
    0.165*X$history_revocations + 
    -0.000*X$age_release + 
    0.000*X$age_release^2 + 
    0.015*X$employment_history + 
    0.014*X$history_drugs_alcohol + 
    0.040*X$felony_convictions + 
    0.131*X$crime_type_other +
    0.105*X$crime_type_property + 
    0.219*X$crime_type_sex + 
    0.282*X$crime_type_sexual_violent + 
    0.206*X$crime_type_violent + 
    0.047*X$offender_class + 
    0.007*X$time_served + 
    0.047*X$p07_job_placement + 
    0.255*X$prior_recidivisms + 
    -0.049*X$prior_recidivisms^2 + 
    0.000*X$age_release*X$prior_recidivisms
  }
  risk <- exp(logit(X)) / (1 + exp(logit(X)))
  return(risk)
}

df$pred <- institutional_risk_model2(df)

df %>%
  ggplot(aes(x = pred)) + 
  geom_histogram()

mean(df$pred)
median(df$pred)
sd(df$pred)