# Manage project dependencies ------
# the following will prompt you to install the various packages used in the study 
renv::activate()
renv::restore()

# Load packages ------

library(SqlRender)
library(CirceR)
library(IncidencePrevalence)
library(here)
library(DBI)
library(dbplyr)
library(dplyr)
library(readr)
library(log4r)
library(stringr)
library(CDMConnector)
library(ggplot2)
library(RPostgres)
library(PatientProfiles)
library(plan)

# database metadata and connection details -----
db.name<-"..."

# Set output folder location -----
# the path to a folder where the results from this analysis will be saved
# to set the location within the project with folder called "output, we can use: here("output")
# but this file path could be set to somewhere else
output.folder<-here("Results", db.name)

# Specify databaseConnector connection details -----
# database connection details
# connect to database
user<-Sys.getenv("DB_USER")
password<- Sys.getenv("DB_PASSWORD")
port<-Sys.getenv("DB_PORT") 
host<-Sys.getenv("DB_HOST")
server_dbi <-"..."


# Specify cdm_reference via DBI connection details -----
# In this study we also use the DBI package to connect to the database
# set up the dbConnect details below (see https://dbi.r-dbi.org/articles/dbi for more details)
# you may need to install another package for this (although RPostgres is included with renv in case you are using postgres)
db <- dbConnect(RPostgres::Postgres(),
                dbname = server_dbi,
                port = port,
                host = host, 
                user = user, 
                password = password)

# Set database details -----
# The name of the schema that contains the OMOP CDM with patient-level data
cdm_database_schema<-"public"

# The name of the schema that contains the vocabularies 
# (often this will be the same as cdm_database_schema)
vocabulary_database_schema <- cdm_database_schema

# The name of the schema where results tables will be created 
results_database_schema<-"results"

# Name of outcome table in the result table where the outcome cohorts will be stored
# Note, if there is an existing table in your results schema with the same names
# it will be overwritten 
outcome_table_stem <-"youngonsetcrc_pharmetrics"

# Run the study ------
source(here("RunStudy.R"))
# after the study is run you should have a folder in your output folder to share

# Disconnect from the database
#db(disconnect)





