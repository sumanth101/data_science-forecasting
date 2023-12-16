# Two Sample Mean Test : TO SHOW IMR DEPENDS ON RACE
library(dplyr)

df <- read.csv("imrace.csv")
names(df)

#############################################

# HERE WE ARE FILTERING THE ROWS WITH MISSING VALUES USING DPLYR PACKAGE
# It first filters out the rows where Infant.Mortality.Rate is not missing
# THIS RESULTING DF IS THEN FILTERED TO REMOVE ROWS WHERE INFANT DEATHS IS MISSING
Filter <- df %>% filter(!is.na(Infant.Mortality.Rate))
Filter <- Filter %>% filter(!is.na(Infant.Deaths))

# Filter based on race or ethnicity
# THE NA REMOVED DF IS AGAIN SPLIT INTO TWO DATASETS BASED ON RACE
NHW <- Filter %>% filter(Materal.Race.or.Ethnicity == "Non-Hispanic White")
NHB <- Filter %>% filter(Materal.Race.or.Ethnicity == "Non-Hispanic Black")

# Combine the filtered data frames
# THIS IS THE NEW DATASET THAT COMBINES ROWS OF NHB BELOW NHW
NHtable <- rbind(NHW, NHB)
NHtable

Infant.Mortality.Rate <- NHtable$Infant.Mortality.Rate
Materal.Race.or.Ethnicity <- NHtable$Materal.Race.or.Ethnicity

# IN BELOW TWO LINES WE CARRY OUT HYPOTHESIS TEST
# NULL HYPOTHESIS : RACE DOES NOT MATTER
# WE GOT THE VALUE IN T TEST AS 29.982 WHERE AS USING QT WE GOT RANGE OF CRITICAL t BETWEEN -2.17 TO 2.17
# WE BASICALLY CONCLUDE HERE THAT AVERAGE IMR OF THESE TWO RACES ARE NOT THE SAME
# SO WE REJECT THE NULL HYPOTHESIS => IMR IS AFFECTED BY RACE OR MATERAL AREAS
t.test(Infant.Mortality.Rate ~ Materal.Race.or.Ethnicity , mu=0 , alt="two.sided",conf=0.95,var.eq=F,paired=F) # mu=0 => NULL HYPOTHESIS
qt(c(0.025,0.975),df=12) # FOR CRITICAL T WITH DOF AS 12



#############################################

# CORELATION COEFFICIENT TO INDICATE RELATION BETWEEN IMR AND NUMBER OF INFANT DEATHS
# WE GOT COR VALUE AS 0.65 AND T VALUE=6.51
# CRITICAL t BETWEEN -2.010635 &  2.010635
# WE REJECT THE NULL HYPOTHESIS THAT THERE IS NOT CORELATION BETWEEN IMR AND INFANT DEATHS
# THERE IS A LINEAR ASSOCIATION BETWEEN THE TWO
Infant_Deaths <- Filter$Infant.Deaths
Infant_Mortality_Rate <- Filter$Infant.Mortality.Rate
cor.test(Infant_Deaths,Infant_Mortality_Rate)
plot(Infant_Deaths,Infant_Mortality_Rate,ylab="IMR",xlab="Infant Deaths")
qt(c(0.025,0.975),df=48)



#################################################################



