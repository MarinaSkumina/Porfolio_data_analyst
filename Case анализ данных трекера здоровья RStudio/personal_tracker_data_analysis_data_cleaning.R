 
# Installing packages for data cleaning process, working with dates, and visualizations.

install.packages('tidyverse')
install.packages('skimr')
install.packages('here')
install.packages('janitor')
install.packages ('lubridate')

library(tidyverse)
library(skimr)
library(here)
library(lubridate)
library(janitor)

# Downloading datasets

daily_activity_1 <- read.csv("../input/fitbit/mturkfitbit_export_3.12.16-4.11.16/Fitabase Data 3.12.16-4.11.16/dailyActivity_merged.csv")
daily_activity_2 <- read.csv("../input/fitbit/mturkfitbit_export_4.12.16-5.12.16/Fitabase Data 4.12.16-5.12.16/dailyActivity_merged.csv")
xiaomi_me_band_activity <- read.csv("../input/exported-data-from-xiaomi-mi-band-fitness-tracker/ACTIVITY/ACTIVITY_1566153601293.csv")


#Cleaning dataset Fitbit 3.12.16-4.11.16 by Mobius. Examining the dataset

str(daily_activity_1)

#Check for duplicates

duplicated(daily_activity_1)

# Changing the date format

daily_activity_1 <- daily_activity_1 %>%
  mutate(ActivityDate=as.Date(ActivityDate, "%m/%d/%Y"))

# Checking if the date format has changed

str(daily_activity_1)

#Checking the value in the columns TotalDistance, TotalSteps, Calories

daily_activity_1 %>% 
  summarise(max_distance=max(TotalDistance), min_distance=min(TotalDistance), max_steps=max(TotalSteps), min_steps=min(TotalSteps), min_calories=min(Calories), max_calories=max(Calories))

#Checking null values in the column Calories
daily_activity_1 %>% 
  filter(Calories==0)

daily_activity_1 %>% 
  filter(SedentaryMinutes==1440)

# Data with 0 calories during should be excluded from the statistics. 

daily_activity_1 <- daily_activity_1 %>% 
  filter(Calories!=0)
 
# Renaming fields and select needed columns

daily_activity_1 <- daily_activity_1 %>% 
  select(Id, ActivityDate,TotalSteps, TotalDistance, VeryActiveDistance, Calories) %>% 
  rename(date=ActivityDate) %>% 
  rename(steps=TotalSteps) %>% 
  rename(distance=TotalDistance) %>% 
  rename(run_distance=VeryActiveDistance) %>% 
  rename_with(tolower)

# Cleaning dataset Fitbit 4.12.16-5.12.16 by Mobius. Examine the dataset

str(daily_activity_2)

# Check for duplicates

duplicated(daily_activity_2)

# Changing the date format

daily_activity_2 <- daily_activity_2 %>%
 mutate(ActivityDate=as.Date(ActivityDate, "%m/%d/%Y"))

# Checking if the date format has changed

str(daily_activity_2)

# Checking the value in the columns TotalDistance, TotalSteps, Calories

daily_activity_2 %>% 
  summarise(max_distance=max(TotalDistance), min_distance=min(TotalDistance), max_steps=max(TotalSteps), min_steps=min(TotalSteps), min_calories=min(Calories), max_calories=max(Calories))

#Checking null values in the column Calories

daily_activity_2 %>% 
  filter(Calories==0)

daily_activity_2 %>% 
  filter(SedentaryMinutes==1440)

# Data with 0 calories during should be excluded from the statistics. 

daily_activity_2 <- daily_activity_2 %>% 
  filter(Calories!=0)

# Renaming fields and select needed columns

daily_activity_2 <- daily_activity_2 %>% 
select(Id, ActivityDate,TotalSteps, TotalDistance, VeryActiveDistance, Calories) %>% 
  rename(date=ActivityDate) %>% 
  rename(steps=TotalSteps) %>% 
  rename(distance=TotalDistance) %>% 
  rename(run_distance=VeryActiveDistance) %>% 
  rename_with(tolower)

# Cleaning dataset Xiaomi Mi Band dataset by BEKBOLAT KURALBAYEV.Examining dataset

str(xiaomi_me_band_activity)

# Removing duplicates

xiaomi_me_band_activity <-  unique(xiaomi_me_band_activity, incomparables = FALSE)

# Changing the format of column date, changing meters into kilometers in the columns distance and runDistance

xiaomi_me_band_activity <- xiaomi_me_band_activity %>% 
  mutate(date=as.Date(date, "%Y-%m-%d")) %>% 
  mutate(distance=distance/1000) %>% 
  mutate(runDistance=runDistance/1000)

# Searching for null values

xiaomi_me_band_activity %>% filter(steps==0)

xiaomi_me_band_activity %>% filter(calories==0)

# Filtering null values of steps and calories
                                          
xiaomi_me_band_activity <- xiaomi_me_band_activity %>% 
  filter(steps!=0)
                                         
# Examining the values in columns
                                          
xiaomi_me_band_activity%>% 
summarise(max_distance=max(distance), min_distance=min(distance), max_steps=max(steps), min_steps=min(steps), min_calories=min(calories), max_calories=max(calories))
                                          
# Renaming the columns in the dataset, excluding the column lastSyncTime
                                        
 xiaomi_me_band_activity <- xiaomi_me_band_activity %>% 
  select(-lastSyncTime) %>% 
  rename(run_distance=runDistance)
                                        