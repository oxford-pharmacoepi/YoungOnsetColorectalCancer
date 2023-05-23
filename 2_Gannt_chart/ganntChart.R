#https://github.com/dankelley/plan

install.packages("remotes")
remotes::install_github("giocomai/ganttrify")
install.packages("devtools")
devtools::install_github("BlakeRMills/MetBrewer")

library(plan)
library(ganttrify)
library(here)
library(readr)
library(dplyr)
library(MetBrewer)
library(RColorBrewer)

g <- new("gantt")
g <- ganttAddTask(g, "Study 1: Characterisation")
g <- ganttAddTask(g, "Data curation", "2000-01-01", "2000-03-01", done = 100)
g <- ganttAddTask(g, "Characterisation", "2000-03-01", "2000-09-01", done = 100)
g <- ganttAddTask(g, "Writeup", "2000-09-01", "2000-11-01", done = 100)

g <- ganttAddTask(g, "Study 2: Identifying Subtypes")
g <- ganttAddTask(g, "Clustering", "2000-11-01", "2001-01-01", done = 100)
g <- ganttAddTask(g, "Validation of clusters", "2001-01-01", "2001-03-01", done = 100)
g <- ganttAddTask(g, "Writeup", "2001-03-01", "2001-05-01", done = 100)

g <- ganttAddTask(g, "Study 3: Mendelian randomization")
g <- ganttAddTask(g, "Genetic instrument selection", "2001-06-01", "2001-09-01", done = 100)
g <- ganttAddTask(g, "MR analysis", "2001-09-01", "2002-01-01", done = 100)
g <- ganttAddTask(g, "Writeup", "2002-10-01", "2003-01-01", done = 100)

g <- ganttAddTask(g, "Study 4: Improving diagnostics")
g <- ganttAddTask(g, "Validation of existing tools", "2001-06-01", "2001-09-01", done = 100)
g <- ganttAddTask(g, "Extending existing tools", "2001-09-01", "2002-01-01", done = 100)
g <- ganttAddTask(g, "Model validation", "2002-01-01", "2002-04-01", done = 100)
g <- ganttAddTask(g, "Writeup", "2002-10-01", "2003-01-01", done = 100)

g <- ganttAddTask(g, "Training & Development")
g <- ganttAddTask(g, "Leadership & project management", "2001-06-01", "2001-09-01", done = 100)
g <- ganttAddTask(g, "Mendelian randomization", "2001-09-01", "2002-01-01", done = 100)
g <- ganttAddTask(g, "Engagement & Dissemination")
g <- ganttAddTask(g, "PPI", "2002-01-01","2002-02-01", done = 100)
g <- ganttAddTask(g, "PPI", "2001-01-01","2001-02-01", done = 100)
g <- ganttAddTask(g, "PPI", "2000-01-01","2000-02-01", done = 100)
g <- ganttAddTask(g, "Publication submissions", "2002-01-01", "2002-04-01", done = 100)
g <- ganttAddTask(g, "Conference attendance", "2002-01-01", "2002-04-01", done = 100)

plan::plot(g,
           ylabel = list(font = ifelse(is.na(g[["start"]]), 2, 1)),
           event.time = c("2001-01-01", "2002-01-01"),
           xlim = c("2000-01-01", "2003-01-01"),
           col.done = c("#00468BFF", "#00468BFF","#00468BFF", "#00468BFF",
                        "#ED0000FF","#ED0000FF", "#ED0000FF","#ED0000FF",
                        "#42B540FF", "#42B540FF","#42B540FF","#42B540FF",
                        "#0099B4FF", "#0099B4FF","#0099B4FF","#0099B4FF","#0099B4FF",
                        "#925E9FFF", "#925E9FFF","#925E9FFF","#925E9FFF"
                        
                        ),
           #col.notdone = c("red"),
           axes  = TRUE, 
           #las=2,
           maiAdd=c(0.5,0,0,0),
           time.format = paste((seq(0, 36, by = 3)), sep = "") 
)

line <- 1.75 # adjust this
mtext("Months", side=1, line=line, at = 0.75)


gannt_fellowship <- read_csv(here("Github", "YoungOnsetColorectalCancer","2_Gannt_chart", "gannt_chart.csv"))

gannt_fellowship <- gannt_fellowship %>% 
  mutate(across(everything(), as.character))

ganttrify(project = gannt_fellowship,
          size_text_relative = 0.8,
          month_breaks = 2,
          alpha_wp = 0,
          mark_years = TRUE,
          #axis_text_align = "left",
          #show_vertical_lines = FALSE,
          hide_wp = FALSE,
          project_start_date = "2024-01",
          #size_wp = 7,
          #month_date_label = FALSE,
          #x_axis_position = "bottom",
          font_family = "Roboto Condensed",
         # colour_palette  = c("#00468BFF", "#ED0000FF", "#42B540FF", "#0099B4FF","#925E9FFF", "blue"))
         #colour_palette  = c("#6ACCEA", "#00FFB8", "#B90000", "#6C919C"))
         #colour_palette = MetBrewer::met.brewer("Signac", n=6, type="discrete"))
         colour_palette = brewer.pal(6,"Set2"))



ggplot2::ggsave(filename = here("Github", "YoungOnsetColorectalCancer","2_Gannt_chart", "my_gantt.png"), width = 7, height = 4, bg = "white")

