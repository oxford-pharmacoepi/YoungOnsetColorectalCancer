

# output files ----
if (!file.exists(output.folder)){
  dir.create(output.folder, recursive = TRUE)}

start<-Sys.time()

# start log ----
log_file <- paste0(output.folder, "/log.txt")
logger <- create.logger()
logfile(logger) <- log_file
level(logger) <- "INFO"

# instantiate study cohorts ----
info(logger, 'INSTANTIATING STUDY COHORTS')
source(here("1_InstantiateCohorts","InstantiateStudyCohorts.R"))
info(logger, 'GOT STUDY COHORTS')

# table names----
outcome_table_name <-paste0(outcome_table_stem,"_o")


# create cdm reference ---- do not change this ----
cdm <- CDMConnector::cdm_from_con(con = db, 
                                  cdm_schema = cdm_database_schema,
                                  write_schema = results_database_schema,
                                  cohort_tables = outcome_table_name)


# create dataframe
working_participants <- cdm[[outcome_table_name]] %>% 
  addDemographics(cdm) %>% 
  filter(prior_history >= 365) %>% 
  filter(age >= 18) %>% collect() #


#create the year of diagnosis 
working_participants <- working_participants %>% 
  mutate(year_of_diagnosis = lubridate::year(cohort_start_date))

working_table <- bind_rows(
  working_participants %>% 
    summarise(val = as.character(n())) %>% 
    mutate(var="N"),
  working_participants %>% 
    summarise(val = as.character(median(age)))  %>% 
    mutate(var="Median age"),
  working_participants %>% 
    summarise(val = as.character(median(prior_history)))  %>% 
    mutate(var="Median prior history (days)"),
  
  working_participants %>% 
    summarise(val = as.character(median(future_observation)))  %>% 
    mutate(var="Median future observation (days)"),
  
  working_participants %>% 
    filter(sex == "Male") %>% 
    summarise(val = as.character(n()))  %>% 
    mutate(var="N male"),
  
  working_participants %>% 
    group_by(sex) %>%
    summarise(n = n()) %>%
    mutate(val = paste0(round(n / sum(n) * 100, 0), "%")) %>% 
    ungroup() %>% 
    filter(sex == "Male") %>%
    mutate(var="% Male") %>%
    select("val", "var") ,
  
  working_participants %>% 
    filter(sex == "Female") %>% 
    summarise(val = as.character(n()))  %>% 
    mutate(var="N Female") ,
  
  working_participants %>% 
    group_by(sex) %>%
    summarise(n = n()) %>%
    mutate(val = paste0(round(n / sum(n) * 100, 0), "%")) %>% 
    ungroup() %>% 
    filter(sex == "Female") %>%
    mutate(var="% Female") %>%
    select("val", "var") ,
  
  working_participants %>% 
    group_by(year_of_diagnosis) %>%
    summarise(val = as.character(n())) %>% 
    mutate(var= as.character(year_of_diagnosis)) %>% 
    select(-year_of_diagnosis)
  
  
)

write_csv(working_table, here::here(paste0("Results/",db.name,"/YOCRC_demographics",db.name,".csv")))


print("Done!")
print("-- If all has worked, you can export your results in the results folder to share")
print("-- Thank you for running the counts! :)")
Sys.time()-start
readLines(log_file)

