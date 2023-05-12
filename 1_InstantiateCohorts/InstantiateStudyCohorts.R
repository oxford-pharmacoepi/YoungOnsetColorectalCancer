# instantiate outcome cohorts
info(logger, "- getting outcome definitions")

outcome_cohorts <- CDMConnector::readCohortSet(here(
  "1_InstantiateCohorts",
  "OutcomeCohorts"
))

info(logger, "- getting outcomes")


cdm <- CDMConnector::generateCohortSet(cdm, 
                                       outcome_cohorts,
                                       name = outcome_table_name,
                                       computeAttrition = TRUE,
                                       overwrite = TRUE
)

#cohortCount(cdm$dn_youngonsetcrc_o) check the numbers

info(logger, "- got outcomes")


