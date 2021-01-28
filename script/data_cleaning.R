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

# Read in the raw data from Open Data Toronto Portal:
raw_data_without_cleaning<-list_package_resources('7bce9bf4-be5c-4261-af01-abfbc3510309')%>%
  filter(tolower(format) %in% c('csv'))%>%
  filter(row_number()==1)%>%
  get_resource()


# To save the raw data without cleaning as a csv document in the input folder, input/data.
write_csv(raw_data_without_cleaning,"input/raw_dataset_without_cleaning.csv")



#Select columns of interest and rename them:
clean_data<-raw_data_without_cleaning %>%
  select(APPLICATION_FOR,RESPONSE_RATE_MET,FINAL_VOTER_COUNT,POTENTIAL_VOTERS,CLOSE_DATE,POLL_RESULT)%>%
  rename(Date=CLOSE_DATE,
         Application_topic=APPLICATION_FOR,
         Response_rate_met=RESPONSE_RATE_MET,
         Final_result=POLL_RESULT,
         Real_total_number=FINAL_VOTER_COUNT,
         Potential_total_number=POTENTIAL_VOTERS)



## Clean Data##

#After exploring the raw dataset, I found that some application topics belong to branch, I changed the names to the main category.:

# 1.The topic,Appeal-Front Yard Parking, belongs to the topic of Front Yard Parking. 

clean_data$Application_topic[clean_data$Application_topic=='Appeal - Front Yard Parking']<-"Front Yard Parking"

# 2. The topic, Proposed Business Improvement Area, belongs to the topic of Business Improvement Area. 
clean_data$Application_topic[clean_data$Application_topic=='Proposed Business Improvement Area']<-"	Business Improvement Area"


# 3.The topics,Traffic Calming-Island and Traffic Calming Safety Zone, belong to the topic of Traffic Calming. 
clean_data$Application_topic[clean_data$Application_topic=='Traffic Calming – Island' | clean_data$Application_topic=='Traffic Calming Safety Zone']<-"Traffic Calming"



# Because the data is a daily update, to not confuse people, I only use the data collected before 2020/12/30
clean_data <-
  clean_data %>%
  filter(Date <= as.Date("2020-12-30"))


#Save the cleaned data as csv document in input/data
write_csv(clean_data,"input/clean_data.csv")












