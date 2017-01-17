library(tidyverse)

### download the original data from here: https://nces.ed.gov/ipeds/Section/deltacostproject/ (CSV format)
#
#columns <- cols_only(unitid="i",instname="c",academicyear="i",tuitionfee02_tf="d",
#                     total01="d",buildings05="d",average_subsidy="d",sector_revised="i",
#                     cpi_scalar_2012="d",tuition03="d",net_student_tuition="d",govt_reliance_a="d",any_aid_pct="d",
#                     loan_avg_amount="d",instruction01="d",total_full_time="d",fed_grant_pct="d")
#df01 <- read_csv(file='~/Downloads/IPEDS_Analytics_DCP_87_12_CSV/delta_public_00_12.csv',col_types = columns)
#df02 <- read_csv(file='~/Downloads/IPEDS_Analytics_DCP_87_12_CSV/delta_public_87_99.csv',col_types = columns)

#df <- bind_rows(df01,df02)
#df <- filter(df,sector_revised %in% c(1,2))

df <- read_csv(path = 'filtered_df.csv')

cwru <- 201645

df %>% filter(unitid==cwru) %>% ggplot(.,aes(x=academicyear))+geom_line(aes(y=instruction01))+geom_line(aes(y=tuition03),colour='red')

select_unitid <- df %>% group_by(unitid) %>% summarize(include=sum(total_full_time>5000)) %>% filter(include>25)

df %>% filter(unitid %in% select_unitid$unitid) %>% ggplot(.,aes(x=academicyear,y=any_aid_pct,group=sector_revised))+
  stat_summary(fun.y='median',geom='line')+facet_wrap(~sector_revised,scales='free')
