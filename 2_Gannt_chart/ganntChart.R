library(plan)

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

points(as.POSIXct("2001-01-01"), 100)

lines(gantt$start[3]+c(-30*86400,0), rep(10, 2)) 


data(gantt)
summary(gantt)
#'
#' # 1. Simple plot
plot(gantt)
#'
#' # 2. Plot with two events
event.label <- c("Proposal", "AGU")
event.time <- c("2008-01-28", "2008-12-10")
plot(gantt, event.label=event.label,event.time=event.time)
#'
#' # 3. Control x axis (months, say)
plot(gantt,labels=paste("M",1:6,sep=""))
#'
#' # 4. Control task colours
plot(gantt,
     col.done=c("black", "red", rep("black", 10)),
     col.notdone=c("lightgray", "pink", rep("lightgray", 10)))

plot(gantt, event.time=event.time, event.label=event.label,
     lwd.eventLine=1:2, lty.eventLine=1:2,
     col.eventLine=c("pink", "lightblue"),
     col.event=c("red", "blue"), font.event=1:2, cex.event=1:2)

#' # 7. Demonstrate zero-time item (which becomes a heading)
gantt[["description"]][1] <- "Preliminaries"
gantt[["end"]][1] <- gantt[["start"]][1]
plot(gantt, ylabel=list(font=2, justification=0))

plot(gantt, arrows=c("right","left","left","right"))



library(plan)
arrive <- as.POSIXct("2012-09-05")
month <- 28 * 86400
year <- 12 * month
leave <- arrive + 4 * year
startT1 <- arrive
endT1 <- startT1 + 4 * month
startT2 <- endT1 + 1
endT2 <- startT2 + 4 * month
startQE <- arrive + 9 * month
endQE <- arrive + 12 * month
QEabsoluteEnd <- arrive + 15 * month
startProposal <- arrive + 15 * month # for example
endProposal <- arrive + 20 * month
startThesisWork <- arrive + 2 * month # assumes no thesis work until 2 months in
endThesisWork <- leave - 4 * month
startWriting <- leave - 36 * month
endWriting <- leave

g <- as.gantt(key=1:8, c("Academic",
                         "Term 1 classes",
                         "Term 2 classes",
                         "Qualifying Examination",
                         "Research",
                         "Proposal Defence",
                         "Thesis Work",
                         "Paper/Thesis Writing"),
              c(startT1, startT1, startT2, startQE, startProposal, startProposal,
                startThesisWork, startWriting),
              c(startT1, endT1, endT2, endQE, startProposal, endProposal,
                endThesisWork, endWriting),
              done=rep(0, 7))
plot(g, xlim=c(arrive, leave),
     ylabel=list(font=c(2,rep(1,3),2), justification=c(0,rep(1,3),0)))



library(plan)
data(gantt)
plot(gantt)
points(as.POSIXct("2008-01-01"), 10)
lines(gantt@data$start[3]+c(-30*86400,0), rep(10, 2)) 