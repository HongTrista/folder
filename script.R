#### Preamble ####
# Purpose: Clean the survey data downloaded from Open Data Toronto
# Author: Hong Pan
# Data: 29 January 2021
# Contact: hong.pan@mail.utoronto.ca
# License: MIT
# Pre-requisites: 
# - Need to have downloaded the CSV data and saved it to inputs/data
# - Install the following packages: opendatatoronto, tidyverse


#### Workspace setup ####
library(opendatatoronto)
library(tidyverse)



# Read in the raw data:
raw_data<-list_package_resources('7bce9bf4-be5c-4261-af01-abfbc3510309')%>%
  filter(tolower(format) %in% c('csv'))%>%
  filter(row_number()==1)%>%
  get_resource()



#Select interested column:
raw_data<-raw_data %>%
  select(APPLICATION_FOR,RESPONSE_RATE_MET,FINAL_VOTER_COUNT,POTENTIAL_VOTERS)%>%
  rename(Type=APPLICATION_FOR,
         Result=RESPONSE_RATE_MET,
         Real_total_number=FINAL_VOTER_COUNT,
         Potential_total_number=POTENTIAL_VOTERS)


#Create a new column, engagement rate for each type of application:
raw_data<-raw_data%>%
  mutate(Engagement_rate=round((Real_total_number/Potential_total_number),3))


#Save the new data as csv document in input/data
write_csv(raw_data,"input/raw_dataset.csv")












