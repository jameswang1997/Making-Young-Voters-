library(dplyr)
library(readr)
setwd("~/Dropbox/BassConnectionsRAs/HS Survey")
school = read_csv("All Schools NC.csv")
schoolP = read_csv("SchoolPrincipleEmail.csv")
survey = read_csv('SchoolSurvey3.23.csv')
survey$schoolnumber
# school1 = school %>% select(`School Number`, `School Name`, `Locale Type`)

df_join = inner_join(survey, school, by = c('schoolnumber' = "School Number"))
# all 206 schools are joined
write.csv(df_join, 'school_survey_adddress.csv', row.names = F)
school %>% dim

df_left = left_join(schoolP, survey, by =c("schoolnumber" = 'schoolnumber'))
df_left = inner_join(df_left, school,  by = c('schoolnumber' = "School Number"))
df_left$SurveyComplete = "No"
df_left$SurveyComplete[!df_left$IPAddress %>% is.na()] = "Yes"
df_left$SurveyComplete %>% table
write.csv(df_left, 'school_survey_adddress_full2.csv', row.names = F)

df_left$`County Description`
df_left = read_csv('school_survey_adddress_full2.csv')
NCPrezVote = read_csv("NCPrezVote.csv")
NCPrezVote$`Vote by county`
df_v = df_left %>% inner_join(NCPrezVote, by = c('County Description' = 'Vote by county'))
df_v$County = df_v$`County Description`

df_size = read_csv("df_size.csv")
df_size %>% names
# size %>% head
# df_v %>% names
# df_size = size %>% select(index, schoolSize)
df_v_size = df_size %>% right_join(df_v)
df_v_size$schoolSize %>% is.na %>% sum # 93 nas

medianSize = df_v_size$schoolSize %>% median(na.rm = T)
df_v_size$schoolSize[df_v_size$schoolSize %>% is.na] = medianSize
# using median imputation for NA size




write.csv(df_v_size, "df_v_size.csv",row.names = F)


df_v_size = read_csv("df_v_size.csv")
survey$courses == 1

list1 = c(1)
library(dplyr)
library(tidyr)
library(stringr)
df1 = survey %>% gather(courseNum, courseName, `civics courses_1`:`civics courses_5`)
df_course = df1 %>% select(schoolnumber,courseNum,courseName) %>% na.omit()
# how frequent is a course
df_course = df_course[!df_course$courseName %>% tolower() %>% str_detect("please"),]
df_course$courseName %>% table %>% .[df_course$courseName %>% table %>% order] # tells me what string are there
df_course$courseName = df_course$courseName  %>% str_replace("AP", "") %>% tolower() %>% str_trim()

df_course$courseNameEdit = df_course$courseName

df_course$courseNameEdit[df_course$courseNameEdit %>% str_detect("civ")] = "Civics and Economics"
df_course$courseNameEdit[df_course$courseNameEdit %>% str_detect("gov")] = 'Government'
df_course$courseNameEdit[df_course$courseNameEdit %>% str_detect("history")] = "US History"
df_course$courseNameEdit[df_course$courseNameEdit %>% str_detect("english")] = "English"
df_course$courseNameEdit[df_course$courseName %>% str_detect("world")] = "World History"
df_course$courseNameEdit[df_course$courseName %>% str_detect("law")] = "Law and Justice"
df_course$courseNameEdit[df_course$courseNameEdit %>% str_detect("jrotc")] = "j-ROTC"
df_course$courseNameEdit[df_course$courseName %>% str_detect("business")] = 'Business and Entrepreneurship'
df_course$courseNameEdit[df_course$courseName %>% str_detect("entre")] = 'Business and Entrepreneurship'
df_course$courseNameEdit[df_course$courseNameEdit %>% str_detect("inquiry")] = 'Inquiry'
df_course$courseNameEdit[df_course$courseNameEdit %>% str_detect("service")] = 'Community Service'
df_course$courseNameEdit[df_course$courseNameEdit %>% str_detect("current")] = 'Current Affairs'
hotCourseNames = df_course %>% group_by(courseNameEdit) %>% summarise(n=n()) %>% arrange(desc(n)) %>%.$courseNameEdit

df_course$courseNameEdit[!df_course$courseNameEdit %in% hotCourseNames] = "Others"
df_course_hot = df_course %>% group_by(courseNameEdit) %>% summarise(n=n()) %>% arrange(desc(n)) 

write.csv(df_course_hot, "df_course_hot.csv", row.names = F)


# how many courses does each school teach
courseCt = df_course %>% group_by(schoolnumber) %>% summarise(courseCt=n())
# df_v_size$courseCount = 0
# df_v_size$courseCount[df_v_size]
df_v_size1 = df_v_size %>% full_join(courseCt)
df_v_size1$courseCt[df_v_size1$courseCt %>% is.na()]=0
write.csv(df_v_size1, "df_v_size_course.csv",row.names = F)



df_v_size1$courseCt %>% table

df_v_size1_complete = df_v_size1 %>% filter(SurveyComplete == "Yes")




