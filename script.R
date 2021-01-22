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



# Read in the raw data. 
raw_data<-list_package_resources('7bce9bf4-be5c-4261-af01-abfbc3510309')%>%
  filter(tolower(format) %in% c('csv'))%>%
  filter(row_number()==1)%>%
  get_resource()



#Clean Existing Data
raw_data<-raw_data %>%
  select(BALLOTS_BLANK,BALLOTS_CAST,BALLOTS_IN_FAVOUR,BALLOTS_OPPOSED,BALLOTS_RECEIVED_BY_VOTERS,BALLOTS_RETURNED_TO_SENDER,APPLICATION_FOR,RESPONSE_RATE_MET,FINAL_VOTER_COUNT)%>%
  rename(Blank=BALLOTS_BLANK,
         Cast=BALLOTS_CAST,
         Favour=BALLOTS_IN_FAVOUR,
         Opposed=BALLOTS_OPPOSED,
         Received_by_voters=BALLOTS_RECEIVED_BY_VOTERS,
         Fail_delivered=BALLOTS_RETURNED_TO_SENDER,
         Type=APPLICATION_FOR,
         Result=RESPONSE_RATE_MET,
         Total_number=FINAL_VOTER_COUNT)


#Save the new data as csv document in input/data
write_csv(raw_data,"input/raw_dataset.csv")












