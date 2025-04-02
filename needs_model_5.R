library(tidyverse)
library(patchwork)

weights <- list(
  "Before my arrest, I owned a car." = 0.8719,
  "Before my arrest, I had access to private transportation like a car, motorcycle or bike." = 0.5195,
  "I have had a driver’s license in the past." = 0.41,
  "Before my arrest, I was:" = 0.7773,
  "In the 6 months before my arrest, I applied for:" = 0.7293,
  "The longest time I was employed at a single job in the 3 years before my arrest was:" = 0.6243,
  "Before my arrest, I lived in a household where at least one person had full-time, year-round employment." = 0.2293,
  "The highest level of education I have completed is:" = 0.5618,
  "I was suspended or expelled from school." = 0.3827,
  "I have been diagnosed with a learning disability, attention deficit disorders (ADD or ADHD), or other special education needs." = 0.31111,
  "I have received job-related licenses, certifications, or vocational training." = 0.4526,
  "I have failed or repeated a grade." = 0.5252,
  "I can read and understand a newspaper." = 0.4550333,
  "I am sometimes irritated by people who ask favors of me." = 0.5498,
  "I give up on things before completing them." = 0.3687,
  "I avoid facing problems." = 0.664,
  "During the last year before I got locked up, some of my friends used drugs together." = 0.6246,
  "I need treatment now." = 0.4562,
  "I have been successful in working on my problem, but I’m not sure I can keep up the effort on my own." = 0.3441,
  "I’m willing to stop hanging around my friends to stay out of trouble." = 0.2619,
  "During the last year before I got locked up, my friends felt hopeful about their futures." = 0.3908,
  "During the last year before I got locked up, most of my friends worked regularly on a legal job." = 0.5541,
  "During the last year before I got locked up, my friends spent time together with their families, eating meals or watching TV." = 0.4606,
  "During the last year before I got locked up, most of my friends/acquaintances were arrested." = 0.3401,
  "I have good friends who do not use drugs." = 0.3229,
  "I have a group of close friends." = 0.5963,
  "My friends belong to a group that participates in illegal activities." = 0.4538,
  "I consider my group of friends to be a gang." = 0.5608,
  "My life is out of control." = 0.0136,
  "I want to get my life straightened out." = 0.5236,
  "I’m not the problem. It doesn’t make sense for me to be here." = 0.01,
  "I’m willing to avoid places or hangouts to stay out of trouble." = 0.6824,
  "I am really working hard to change." = 0.7258,
  "I like the “fast” life." = 0.5995,
  "I may be a criminal, but my environment made me that way." = 0.2505,
  "I committed crime because life has been hard for me." = 0.4445,
  "Laws are just a way to keep poor people down." = 0.5342,
  "I don’t take orders well." = 0.6453,
  "People are out to hurt me in some way." = 0.757,
  "If someone disrespects me, then I have to straighten them out." = 0.5585,
  "I have paid my dues in life and am justified in taking what I want." = 0.5551,
  "I have a hot temper." = 0.6521,
  "I sometimes feel upset when I do not get my way." = 0.5794,
  "My temper gets me into fights or other trouble." = 0.8276,
  "Everyone else is doing it, so why shouldn’t I?" = 0.6313,
  "No one has ever really listened to me." = 0.7076,
  "Being locked up does not bother me." = 0.5938,
  "Within the past 3 years, I have hit/hurt someone, including family members, when I was upset." = 0.663,
  "I have committed crimes because I was bored." = 0.5885,
  "I get upset when I hear about someone who lost everything in a disaster." = 0.9445,
  "I am sometimes so moved by an experience that I feel emotions I cannot describe." = 0.4856,
  "I feel bad about my crime(s)." = 0.577,
  "I am proud of the life I have lived." = 0.3942,
  "When I first began regularly using alcohol, I was ____." = 0.3008,
  "When I first began regularly using marijuana, I was ____." = 0.3958,
  "When I first began regularly using drugs other than alcohol or marijuana, I was ____." = 0.6522,
  "I used drugs other than alcohol as a juvenile." = 0.4543,
  "I have used drugs other than marijuana or alcohol since I have grown up." = 0.706,
  "I have been told I had a problem with drugs or alcohol." = 0.7181,
  "I have used drugs for a longer time than I planned." = 0.7457,
  "I feel in control of my addiction." = 0.4596,
  "I have feelings that I need to use drugs or alcohol first thing in the morning." = 0.4596,
  "I will likely relapse soon (in the next few months)." = 0.4596,
  "I miss the life I had when I was using drugs or alcohol." = 0.4596,
  "I was using drugs or alcohol when I was arrested for my current offense." = 0.6526,
  "I have been in treatment for drugs or alcohol such as counseling, outpatient, inpatient, or residential." = 0.4341,
  "I would benefit from drug or alcohol treatment OR I am benefitting from drug or alcohol treatment." = 0.4999,
  "I tried to cut down on my drug use but was unable to do it." = 0.5925,
  "I have spent a lot of time getting drugs, using them or recovering from their use." = 0.7527,
  "I have spent less time at work, school, or with friends so that I could use drugs." = 0.6239,
  "Other people in my family have abused drugs or alcohol." = 0.3414,
  "My drug use has caused health problems, including HIV/AIDS or Hep-C." = 0.4829,
  "I have used more of a drug to get loaded or high." = 0.7419,
  "My drug use has caused problems with family, friends, work or police." = 0.7757,
  "Sometimes, I kept taking a drug to keep from getting sick." = 0.5126,
  "In the past, I have taken prescribed medicine for my mental health issue(s)." = 0.7221,
  "I am currently taking mental health medicine." = 0.6993,
  "In the past, I have seen a mental health counselor, social worker, therapist, psychologist, or psychiatrist for help with a problem." = 0.6993,
  "I am currently seeing a mental health counselor, social worker, therapist, psychologist or psychiatrist for help with a problem." = 0.5989,
  "I have attempted suicide in the past." = 0.4176,
  "I have seen things or heard voices that were not really there." = 0.5166,
  "I have experienced too many ups and downs." = 0.5483,
  "I have experienced a loss of appetite." = 0.4471,
  "I have problems concentrating or staying focused." = 0.5582,
  "Some members of my family have mental health issues." = 0.4518,
  "I feel anxious or nervous." = 0.6101,
  "I feel sad or depressed." = 0.6457,
  "I have trouble sleeping because I am worried about things." = 0.6217,
  "There was violence in my family." = 0.3533,
  "In my life, I have experienced something that was so frightening, horrible or upsetting that in the past month, I have had nightmares about it or thought about it when I did not want to." = 0.7795,
  "In my life, I have experienced something that was so frightening, horrible or upsetting that in the past month, I tried hard not to think about it or went out of my way to avoid situations that remind me of it." = 0.7802,
  "In my life, I have experienced something that was so frightening, horrible or upsetting that in the past month, I was constantly on guard, watchful, or easily startled." = 0.7295,
  "In my life, I have experienced something that was so frightening, horrible or upsetting that in the past month, I felt numb or detached from others, activities or my surroundings." = 0.672,
  "I have seen someone killed." = 0.3191,
  "I see fights often." = 0.3298,
  "Before my arrest, I had enough money for my basic needs." = 0.5309,
  "Before my arrest, I had a checking account at a bank." = 0.3321,
  "Before my arrest, I was on food stamps (SNAP)." = 0.4176,
  "During my adult life, I have been homeless or lived in a shelter." = 0.5337,
  "During my adult life, I have relied on public assistance." = 0.4671,
  "I am usually able to pay my bills without financial help from family or friends." = 0.5144,
  "In the 12 months (1 year) before my arrest, I changed residences ____ times." = 0.3122,
  "It will be difficult for me to find a safe place to live." = 0.3772,
  "Before my arrest, most people in my neighborhood had regular jobs." = 0.3176,
  "I have family members who will support me." = 0.3482,
  "I have children who are 18 years or younger." = 0.6238,
  "In the past, someone has accused me of not paying child support." = 0.8472,
  "I think I am a good parent." = 0.9169,
  "I am involved in important decisions regarding my children (school, health or outside activities)." = 0.8782,
  "Most of the time, I get no support from my children’s father/mother." = 0.8771,
  "In total, how many times have you been arrested in your lifetime?" = 0.58517,
  "In total, how many days have you ever spent in jail or prison?" = 0.12771,
  "How many times were you arrested before age 18?" = 0.19063,
  "In total, how many times have you had parole or probation revoked for any reason?" = 0.20707,
  "In my life, I have been arrested for weapons." = 0.2101,
  "Were any arrests during the last 6 months before entering this program/facility for violent crimes?" = 0.2101
)

input_vars <- list(
  
  Transportation = list(
  'Before my arrest, I owned a car.' = 1:2,
  'Before my arrest, I had access to private transportation like a car, motorcycle or bike.' = 1:2,
  'I have had a driver’s license in the past.' = 1:2),
  
  Employment = list(
  'Before my arrest, I was:' = 1:4,
  'In the 6 months before my arrest, I applied for:' = 1:4,
  'The longest time I was employed at a single job in the 3 years before my arrest was:' = 1:4),
  
  Education = list(
  'Before my arrest, I lived in a household where at least one person had full-time, year-round employment.' = 1:2,
  'The highest level of education I have completed is:' = 1:4,
  'I was suspended or expelled from school.' = 1:2,
  'I have been diagnosed with a learning disability, attention deficit disorders (ADD or ADHD), or other special education needs.' = 1:2,
  'I have received job-related licenses, certifications, or vocational training.' = 1:2,
  'I have failed or repeated a grade.' = 1:2,
  'I can read and understand a newspaper.' = 1:4),
  
  SelfEfficacy = list(
  'I am sometimes irritated by people who ask favors of me.' = 1:4,
  'I give up on things before completing them.' = 1:4,
  'I avoid facing problems.' = 1:4,
  'During the last year before I got locked up, some of my friends used drugs together.' = 1:4,
  'I need treatment now.' = 1:4,
  'I have been successful in working on my problem, but I’m not sure I can keep up the effort on my own.' = 1:4,
  'I’m willing to stop hanging around my friends to stay out of trouble.' = 1:4),
  
  AntiSocial_Peers = list(
  'During the last year before I got locked up, my friends felt hopeful about their futures.' = 1:4,
  'During the last year before I got locked up, most of my friends worked regularly on a legal job.' = 1:4,
  'During the last year before I got locked up, my friends spent time together with their families, eating meals or watching TV.' = 1:4,
  'During the last year before I got locked up, most of my friends/acquaintances were arrested.' = 1:4,
  'I have good friends who do not use drugs.' = 1:4,
  'I have a group of close friends.' = 1:4,
  'My friends belong to a group that participates in illegal activities.' = 1:4,
  'I consider my group of friends to be a gang.' = 1:4),
  
  AntiSocial = list(
  'My life is out of control.' = 1:4,
  'I want to get my life straightened out.' = 1:4,
  'I’m not the problem. It doesn’t make sense for me to be here.' = 1:4,
  'I’m willing to avoid places or hangouts to stay out of trouble.' = 1:4,
  'I am really working hard to change.' = 1:4,
  'I like the “fast” life.' = 1:4,
  'I may be a criminal, but my environment made me that way.' = 1:4,
  'I committed crime because life has been hard for me.' = 1:4,
  'Laws are just a way to keep poor people down.' = 1:4,
  'I don’t take orders well.' = 1:4,
  'People are out to hurt me in some way.' = 1:4,
  'If someone disrespects me, then I have to straighten them out.' = 1:4,
  'I have paid my dues in life and am justified in taking what I want.' = 1:4,
  'I have a hot temper.' = 1:4,
  'I sometimes feel upset when I do not get my way.' = 1:4,
  'My temper gets me into fights or other trouble.' = 1:4,
  'Everyone else is doing it, so why shouldn’t I?' = 1:4,
  'No one has ever really listened to me.' = 1:4,
  'Being locked up does not bother me.' = 1:4,
  'Within the past 3 years, I have hit/hurt someone, including family members, when I was upset.' = 1:4,
  'I have committed crimes because I was bored.' = 1:4),
  
  Remorse = list(
  'I get upset when I hear about someone who lost everything in a disaster.' = 1:4,
  'I am sometimes so moved by an experience that I feel emotions I cannot describe.' = 1:4,
  'I feel bad about my crime(s).' = 1:4,
  'I am proud of the life I have lived.' = 1:4),
  
  Substance_Abuse = list(
  'When I first began regularly using alcohol, I was ____.' = 1:5,
  'When I first began regularly using marijuana, I was ____.' = 1:5,
  'When I first began regularly using drugs other than alcohol or marijuana, I was ____.' = 1:5,
  'I used drugs other than alcohol as a juvenile.' = 1:2,
  'I have used drugs other than marijuana or alcohol since I have grown up.' = 1:2,
  'I have been told I had a problem with drugs or alcohol.' = 1:2,
  'I have used drugs for a longer time than I planned.' = 1:2,
  'I feel in control of my addiction.' = 1:5,
  'I have feelings that I need to use drugs or alcohol first thing in the morning.' = 1:5,
  'I will likely relapse soon (in the next few months).' = 1:5,
  'I miss the life I had when I was using drugs or alcohol.' = 1:5,
  'I was using drugs or alcohol when I was arrested for my current offense.' = 1:2,
  'I have been in treatment for drugs or alcohol such as counseling, outpatient, inpatient, or residential.' = 1:2,
  'I would benefit from drug or alcohol treatment OR I am benefitting from drug or alcohol treatment.' = 1:5,
  'I tried to cut down on my drug use but was unable to do it.' = 1:5,
  'I have spent a lot of time getting drugs, using them or recovering from their use.' = 1:2,
  'I have spent less time at work, school, or with friends so that I could use drugs.' = 1:2,
  'Other people in my family have abused drugs or alcohol.' = 1:2,
  'My drug use has caused health problems, including HIV/AIDS or Hep-C.' = 1:2,
  'I have used more of a drug to get loaded or high.' = 1:2,
  'My drug use has caused problems with family, friends, work or police.' = 1:2,
  'Sometimes, I kept taking a drug to keep from getting sick.' = 1:2),
  
  Depression = list(
  'In the past, I have taken prescribed medicine for my mental health issue(s).' = 1:2,
  'I am currently taking mental health medicine.' = 1:2,
  'In the past, I have seen a mental health counselor, social worker, therapist, psychologist, or psychiatrist for help with a problem.' = 1:2,
  'I am currently seeing a mental health counselor, social worker, therapist, psychologist or psychiatrist for help with a problem.' = 1:2,
  'I have attempted suicide in the past.' = 1:2),
  
  Mental_Health = list(
  'I have seen things or heard voices that were not really there.' = 1:2,
  'I have experienced too many ups and downs.' = 1:2,
  'I have experienced a loss of appetite.' = 1:2,
  'I have problems concentrating or staying focused.' = 1:2,
  'Some members of my family have mental health issues.' = 1:2,
  'I feel anxious or nervous.' = 1:2,
  'I feel sad or depressed.' = 1:2,
  'I have trouble sleeping because I am worried about things.' = 1:2),
  
  Trauma = list(
  'There was violence in my family.' = 1:2,
  'In my life, I have experienced something that was so frightening, horrible or upsetting that in the past month, I have had nightmares about it or thought about it when I did not want to.' = 1:2,
  'In my life, I have experienced something that was so frightening, horrible or upsetting that in the past month, I tried hard not to think about it or went out of my way to avoid situations that remind me of it.' = 1:2,
  'In my life, I have experienced something that was so frightening, horrible or upsetting that in the past month, I was constantly on guard, watchful, or easily startled.' = 1:2,
  'In my life, I have experienced something that was so frightening, horrible or upsetting that in the past month, I felt numb or detached from others, activities or my surroundings.' = 1:2,
  'I have seen someone killed.' = 1:2,
  'I see fights often.' = 1:2),
  
  Financial_Stability = list(
  'Before my arrest, I had enough money for my basic needs.' = 1:2,
  'Before my arrest, I had a checking account at a bank.' = 1:2,
  'Before my arrest, I was on food stamps (SNAP).' = 1:2,
  'During my adult life, I have been homeless or lived in a shelter.' = 1:2,
  'During my adult life, I have relied on public assistance.' = 1:2,
  'I am usually able to pay my bills without financial help from family or friends.' = 1:2,
  'In the 12 months (1 year) before my arrest, I changed residences ____ times.' = 1:4,
  'It will be difficult for me to find a safe place to live.' = 1:2,
  'Before my arrest, most people in my neighborhood had regular jobs.' = 1:2,
  'I have family members who will support me.' = 1:2),

  Family_Parenting = list(
  'I have children who are 18 years or younger.' = 1:2,
  'In the past, someone has accused me of not paying child support.' = 1:3,
  'I think I am a good parent.' = 1:5,
  'I am involved in important decisions regarding my children (school, health or outside activities).' = 1:3,
  'Most of the time, I get no support from my children’s father/mother.' = 1:5),
  
  Criminal_History = list(
  'In total, how many times have you been arrested in your lifetime?' = 1:5,
  'In total, how many days have you ever spent in jail or prison?' = 1:5,
  'How many times were you arrested before age 18?' = 1:4,
  'In total, how many times have you had parole or probation revoked for any reason?' = 1:4
  ),
  
  Violent_Criminal_History = list(
  'In my life, I have been arrested for weapons.' = 1:2,
  'Were any arrests during the last 6 months before entering this program/facility for violent crimes?' = 1:2)
)

df_Transportation <- expand.grid(input_vars$Transportation)
df_Employment <- expand.grid(input_vars$Employment)
df_Education <- expand.grid(input_vars$Education)
df_SelfEfficacy <- expand.grid(input_vars$SelfEfficacy)
df_AntiSocial_Peers <- expand.grid(input_vars$AntiSocial_Peers)
df_Remorse <- expand.grid(input_vars$Remorse)
df_Depression <- expand.grid(input_vars$Depression)
df_Mental_Health <- expand.grid(input_vars$Mental_Health)
df_Trauma <- expand.grid(input_vars$Trauma)
df_Financial_Stability <- expand.grid(input_vars$Financial_Stability)
df_Family_Parenting <- expand.grid(input_vars$Family_Parenting)
df_Criminal_History <- expand.grid(input_vars$Criminal_History)
df_Violent_Criminal_History <- expand.grid(input_vars$Violent_Criminal_History)


df_Transportation_new <- df_Transportation %>% 
  mutate(
    pred = needs_model(df_Transportation),
    category = case_when(
      pred >= 0 & pred <= 0.6139 ~ "Low",
      pred >= 0.6139 & pred <= 0.652 ~ "Medium",
      pred >= 0.652 ~ "High",
    ),
    category = factor(category, levels = c("Low", "Medium", "High"))
  )

df_Employment_new <- df_Employment %>% 
  mutate(
    pred = needs_model(df_Employment),
    category = case_when(
      pred >= 0 & pred <= 0.4244 ~ "Low",
      pred >= 0.4244 & pred <= 0.5701 ~ "Medium",
      pred >= 0.5701 ~ "High",
    ),
    category = factor(category, levels = c("Low", "Medium", "High"))
  )

df_Education_new <- df_Education %>% 
  mutate(
    pred = needs_model(df_Education),
    category = case_when(
      pred >= 0 & pred <= 0.6711 ~ "Low",
      pred >= 0.6711 & pred <= 0.7651 ~ "Medium",
      pred >= 0.7651 ~ "High",
    ),
    category = factor(category, levels = c("Low", "Medium", "High"))
  )

df_SelfEfficacy_new <- df_SelfEfficacy %>% 
  mutate(
    pred = needs_model(df_SelfEfficacy),
    category = case_when(
      pred >= 0 & pred <= 0.6032 ~ "Low",
      pred >= 0.6032 & pred <= 0.6494 ~ "Medium",
      pred >= 0.6494 ~ "High",
    ),
    category = factor(category, levels = c("Low", "Medium", "High"))
  )

df_AntiSocial_Peers_new <- df_AntiSocial_Peers %>% 
  mutate(
    pred = needs_model(df_AntiSocial_Peers),
    category = case_when(
      pred >= 0 & pred <= 0.4714 ~ "Low",
      pred >= 0.4714 & pred <= 0.5438 ~ "Medium",
      pred >= 0.5438 ~ "High",
    ),
    category = factor(category, levels = c("Low", "Medium", "High"))
  )

df_Remorse_new <- df_Remorse %>% 
  mutate(
    pred = needs_model(df_Remorse),
    category = case_when(
      pred >= 0 & pred <= 0.4494 ~ "Low",
      pred >= 0.4494 & pred <= 0.5123 ~ "Medium",
      pred >= 0.5123 ~ "High",
    ),
    category = factor(category, levels = c("Low", "Medium", "High"))
  )

df_Depression_new <- df_Depression %>% 
  mutate(
    pred = needs_model(df_Depression),
    category = case_when(
      pred >= 0 & pred <= 0.4 ~ "Low",
      pred >= 0.4 & pred <= 0.6 ~ "Medium",
      pred >= 0.6 ~ "High",
    ),
    category = factor(category, levels = c("Low", "Medium", "High"))
  )

df_Mental_Health_new <- df_Mental_Health %>% 
  mutate(
    pred = needs_model(df_Mental_Health),
    category = case_when(
      pred >= 0 & pred <= 0.6831 ~ "Low",
      pred >= 0.6831 & pred <= 0.7537 ~ "Medium",
      pred >= 0.7537 ~ "High",
    ),
    category = factor(category, levels = c("Low", "Medium", "High"))
  )

df_Trauma_new <- df_Trauma %>% 
  mutate(
    pred = needs_model(df_Trauma),
    category = case_when(
      pred >= 0 & pred <= 0.5598 ~ "Low",
      pred >= 0.5598 & pred <= 0.6264 ~ "Medium",
      pred >= 0.6264 ~ "High",
    ),
    category = factor(category, levels = c("Low", "Medium", "High"))
  )

df_Financial_Stability_new <- df_Financial_Stability %>% 
  mutate(
    pred = needs_model(df_Financial_Stability),
    category = case_when(
      pred >= 0 & pred <= 0.5465 ~ "Low",
      pred >= 0.5465 & pred <= 0.6007 ~ "Medium",
      pred >= 0.6007 ~ "High",
    ),
    category = factor(category, levels = c("Low", "Medium", "High"))
  )

df_Family_Parenting_new <- df_Family_Parenting %>% 
  mutate(
    pred = needs_model(df_Family_Parenting),
    category = case_when(
      pred >= 0 & pred <= 0.3958 ~ "Low",
      pred >= 0.3958 & pred <= 0.4681 ~ "Medium",
      pred >= 0.4681 ~ "High",
    ),
    category = factor(category, levels = c("Low", "Medium", "High"))
  )

df_Family_Parenting_new <- df_Family_Parenting %>% 
  mutate(
    pred = needs_model(df_Family_Parenting),
    category = case_when(
      pred >= 0 & pred <= 0.3958 ~ "Low",
      pred >= 0.3958 & pred <= 0.4681 ~ "Medium",
      pred >= 0.4681 ~ "High",
    ),
    category = factor(category, levels = c("Low", "Medium", "High"))
  )


needs_model <- function(X){
  variable_names <- names(X)
  
  weighted_responses <- 0
  item_weights <- 0
  item_weights_x_max_response <- 0
  
  for (variable in variable_names) {
    weight <- weights[[variable]] 
    values <- X[[variable]]    

    weighted_responses <- weighted_responses + weight * values
    item_weights <- item_weights + weight
    item_weights_x_max_response <- item_weights_x_max_response + weight * max(values)
  }
  
  numerator <- weighted_responses - item_weights
  denominator <- item_weights_x_max_response - item_weights
  
  value <- numerator / denominator
  
  value
}

plot_category_distribution <- function(df, name) {
  tabulated_df <- df %>%  
    tabyl(category) %>%
    mutate(perc = n / sum(n) * 100)
  
  ggplot(tabulated_df, aes(x = category, y = perc)) +
    geom_bar(stat = "identity") +
    labs(title = name,
         x = "Category", 
         y = "Percentage") +
    theme_minimal() +
    theme(axis.text.x = element_text(angle = 45, hjust = 1))
}

plots <- lapply(names(datasets), function(name) {
  plot_category_distribution(datasets[[name]], name)
})

combined_plot <- wrap_plots(plots, ncol = 3)

print(combined_plot)
