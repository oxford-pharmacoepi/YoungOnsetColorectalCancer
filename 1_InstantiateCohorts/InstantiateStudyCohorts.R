# instantiate outcome cohorts
info(logger, "- getting outcome definitions")

outcome_cohorts <- CDMConnector::readCohortSet(here(
  "1_InstantiateCohorts",
  "OutcomeCohorts"
))

info(logger, "- getting outcomes")


cdm <- CDMConnector::generateCohortSet(cdm = cdm, 
                                       outcome_cohorts,
                                       name = outcome_table_name,
                                       overwrite = TRUE
)

#cohortCount(cdm$dn_youngonsetcrc_o) 

info(logger, "- got outcomes")


