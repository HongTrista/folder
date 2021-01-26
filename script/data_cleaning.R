#### Preamble ####
# Purpose: Clean the survey data downloaded from Open Data Toronto
# Author: Hong Pan
# Data: 29 January 2021
# Contact: hong.pan@mail.utoronto.ca
# License: MIT
# Pre-requisites: 
# - Install the following packages: opendatatoronto, tidyverse


#### Workspace setup ####
library(opendatatoronto)
library(tidyverse)



# Read in the raw data from Open Data Toronto:
raw_data<-list_package_resources('7bce9bf4-be5c-4261-af01-abfbc3510309')%>%
  filter(tolower(format) %in% c('csv'))%>%
  filter(row_number()==1)%>%
  get_resource()



#Select interested column:
raw_data<-raw_data %>%
  select(APPLICATION_FOR,RESPONSE_RATE_MET,FINAL_VOTER_COUNT,POTENTIAL_VOTERS,OPEN_DATE)%>%
  rename(Date=OPEN_DATE,
         Type=APPLICATION_FOR,
         Result=RESPONSE_RATE_MET,
         Real_total_number=FINAL_VOTER_COUNT,
         Potential_total_number=POTENTIAL_VOTERS)


#After exploring the dataset, I found some types of application can be changed the name with other types. 
# 1.The type of Appeal-Front Yard Parking is the same with the type of Front Yard Parking. 

raw_data$Type[raw_data$Type=='Appeal - Front Yard Parking']<-"Front Yard Parking"

# 2. The type of Business Improvement Area is the same type of the Proposed Business Improvement Area. 
raw_data$Type[raw_data$Type=='Proposed Business Improvement Area']<-"	Business Improvement Area"

#The type of Traffic Calming is the same type with Traffic Calming-Island and Traffic Calming Safety Zone, they are all about the type of traffic calming.

raw_data$Type[raw_data$Type=='Traffic Calming – Island' | raw_data$Type=='Traffic Calming Safety Zone']<-"Traffic Calming"





#Create a new column, engagement rate, for each type of application:
raw_data<-raw_data%>%
  mutate(Engagement_rate=round((Real_total_number/Potential_total_number),3))


#Save the new data as csv document in input/data
write_csv(raw_data,"input/raw_dataset.csv")












