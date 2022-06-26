################################################################################
# Packages #
################################################################################

library(stringi)
library(haven)
# For reading SAS XPT file from NHANES website
# haven::read_xpt


library(srvyr)
# For using survey weights
# survey::svydesign, svymean, svyglm

library(dplyr)
# for data wrangling, mining and manipulation

library(kableExtra)
# for output tables

library(ggplot2)
# for graphical analysis

media_1x<-function(survey,x){
  x <- enquo(x)
  
  
  survey %>%
    group_by(!! x) %>%
    summarize(proportion = survey_mean(),
              total = survey_total())  
  
}

media_1y<-function(survey,x){
  x <- enquo(x)
  
  
  survey %>%
    group_by(!! x) %>%
    summarize(proportion = survey_mean(),
              total = survey_mean())  
  
}

################################################################################
# Folders #
################################################################################

urls<-c(  
  "2006trim1_sav/sdemt106.sav",
  "2006trim2_sav/sdemt206.sav",
  "2006trim3_sav/sdemt306.sav",
  "2006trim4_sav/sdemt406.sav",
  
  "2007trim1_sav/sdemt107.sav",
  "2007trim2_sav/sdemt207.sav",
  "2007trim3_sav/sdemt307.sav",
  "2007trim4_sav/sdemt407.sav",
  
  "2008trim1_sav/sdemt108.sav",
  "2008trim2_sav/sdemt208.sav",
  "2008trim3_sav/sdemt308.sav",
  "2008trim4_sav/sdemt408.sav",
  
  "2009trim1_sav/sdemt109.sav",
  "2009trim2_sav/sdemt209.sav",
  "2009trim3_sav/sdemt309.sav",
  "2009trim4_sav/sdemt409.sav",
  
  "2010trim1_sav/sdemt110.sav",
  "2010trim2_sav/sdemt210.sav",
  "2010trim3_sav/sdemt310.sav",
  "2010trim4_sav/sdemt410.sav",
  
  "2011trim1_sav/sdemt111.sav",
  "2011trim2_sav/sdemt211.sav",
  "2011trim3_sav/sdemt311.sav",
  "2011trim4_sav/sdemt411.sav",
  
  "2012trim1_sav/sdemt112.sav",
  "2012trim2_sav/sdemt212.sav",
  "2012trim3_sav/sdemt312.sav",
  "2012trim4_sav/sdemt412.sav",
  
  "2013trim1_sav/sdemt113.sav",
  "2013trim2_sav/sdemt213.sav",
  "2013trim3_sav/sdemt313.sav",
  "2013trim4_sav/sdemt413.sav",
  
  "2014trim1_sav/sdemt114.sav",
  "2014trim2_sav/sdemt214.sav",
  "2014trim3_sav/sdemt314.sav",
  "2014trim4_sav/sdemt414.sav",
  
  "2015trim1_sav/sdemt115.sav",
  "2015trim2_sav/sdemt215.sav",
  "2015trim3_sav/sdemt315.sav",
  "2015trim4_sav/sdemt415.sav",
  "2016trim1_sav/sdemt116.sav",
          "2016trim2_sav/sdemt216.sav",
          "2016trim3_sav/sdemt316.sav",
          "2016trim4_sav/sdemt416.sav",
  "2017trim1_sav/sdemt117.sav",
  "2017trim2_sav/sdemt217.sav",
  "2017trim3_sav/sdemt317.sav",
  "2017trim4_sav/sdemt417.sav",
  "2018trim1_sav/sdemt118.sav",
        "2018trim2_sav/sdemt218.sav",
        "2018trim3_sav/sdemt318.sav",
        "2018trim4_sav/sdemt418.sav",
        "2019trim1_sav/sdemt119.sav",
        "2019trim2_sav/sdemt219.sav",
        "2019trim3_sav/sdemt319.sav",
        "2019trim4_sav/sdemt419.sav",
        "2020trim1_sav/sdemt120.sav",
        
        "2020trim3_sav/sdemt320.sav",
        "2020trim4_sav/sdemt420.sav",
        "2021trim1_sav/sdemt121.sav",
        "2021trim2_sav/sdemt221.sav",
        "2021trim3_sav/sdemt321.sav",
        "2021trim4_sav/sdemt421.sav",
        "2022trim1_sav/sdemt122.sav")

get_data<-function(input_urls){
  
output <- as.data.frame(matrix(ncol=1,nrow =1))
  
for(i in 1:length(input_urls)){
    
url<-input_urls[i]
    
    
data<-read_spss(url) 
data<-as.data.frame(data)
colnames(data) <- tolower(colnames(data))

data$l_nac_c<-as.character(data$l_nac_c)
data$sex<-as.character(data$sex)
#data$fac<-as.character(data$fac)
data<-data%>% filter(l_nac_c=="225") %>%
  select(fac,sex) %>% mutate(id=row_number())%>%
  as_survey_design(ids = id, weight = fac)


summary<-media_1x(data,sex)
year<-stri_extract(url,regex = "[0-9]{4}")
summary<-summary %>% mutate(año=year)

output<-bind_rows(output, summary)


}
output<-as.data.frame(output[-1,-1])
output
}

a<-get_data(urls[1:57])


get_data_2<-function(input_urls){
  
  output <- as.data.frame(matrix(ncol=1,nrow =1))
  
  for(i in 1:length(input_urls)){
    
    url<-input_urls[i]
    
    
    data<-read_spss(url) 
    data<-as.data.frame(data)
    colnames(data) <- tolower(colnames(data))
    data$fac<-data$fac_tri
    
    data$l_nac_c<-as.character(data$l_nac_c)
    data$sex<-as.character(data$sex)

      data<-data%>% filter(l_nac_c=="225") %>%
      select(fac,sex) %>% mutate(id=row_number())%>%
      as_survey_design(ids = id, weight = fac)
    
    
    summary<-media_1x(data,sex)
    year<-stri_extract(url,regex = "[0-9]{4}")
    summary<-summary %>% mutate(año=year)
    
    output<-bind_rows(output, summary)
    
    
  }
  output<-as.data.frame(output[-1,-1])
  output
}

b<-get_data_2(urls[58:64])

c<-rbind(a,b)
c<-c %>% filter(sex==2)%>%mutate(id=row_number())

ggplot(c, aes(x=id, y=proportion)) +
  geom_line()+ 
  geom_smooth(method='loess', formula= y~x)+scale_x_discrete("Año",limits = c("2006","","","",
                                                 "2007","","","",
                                                 "2008","","","",
                                                 "2009","","","",
                                                 "2010","","","",
                                                 "2012","","","",
                                                 "2013","","","",
                                                 "2014","","","",
                                                 "2015","","","",
                                                 "2016","","","",
                                                 "2017","","","",
                                           "2018","","","",
                                           "2019","","","",
                                           "2020","","",
                                           "2021","","","",
                                           "2022"))





#############################
## Ejercicio por edades
############################


get_data_age<-function(input_urls,sexo){
  
output <- as.data.frame(matrix(ncol=1,nrow =1))
  
for(i in 1:length(input_urls)){

data<-read_spss(input_urls[i]) 
data<-as.data.frame(data)
colnames(data) <- tolower(colnames(data))

data$l_nac_c<-as.character(data$l_nac_c)
data$sex<-as.character(data$sex)
#data$fac<-as.character(data$fac)
data<-data%>% filter(l_nac_c=="225") %>%
  select(fac,sex,eda) %>% mutate(id=row_number())%>% filter(sex==sexo)%>%
  as_survey_design(ids = id, weight = fac)

summary<-media_1y(data,eda)
age<-as.data.frame(sum(summary$eda*summary$proportion))
names(age)<-c("mean_age")
output<-bind_rows(output, age)


  }
output<-as.data.frame(output[-1,-1])
output
}



get_data_age2<-function(input_urls,sexo){
  
  output <- as.data.frame(matrix(ncol=1,nrow =1))
  
  for(i in 1:length(input_urls)){
    
    data<-read_spss(input_urls[i]) 
    data<-as.data.frame(data)
    colnames(data) <- tolower(colnames(data))
    data$fac<-data$fac_tri
    
    data$l_nac_c<-as.character(data$l_nac_c)
    data$sex<-as.character(data$sex)
    #data$fac<-as.character(data$fac)
    data<-data%>% filter(l_nac_c=="225") %>%
      select(fac,sex,eda) %>% mutate(id=row_number())%>% filter(sex==sexo)%>%
      as_survey_design(ids = id, weight = fac)
    
    summary<-media_1y(data,eda)
    age<-as.data.frame(sum(summary$eda*summary$proportion))
    names(age)<-c("mean_age")
    output<-bind_rows(output, age)
    
    
  }
  output<-as.data.frame(output[-1,-1])
  output
}

## HOMBRES
ages_a_h<-get_data_age(urls[1:57],1)
ages_b_h<-get_data_age2(urls[58:64],1)
ages_c_h<-rbind(ages_a_h,ages_b_h)
ages_c_h<-ages_c_h %>%mutate(id=row_number())
names(ages_c_h)<-c("mean_age","id")
ggplot(ages_c_h, aes(x=id, y=mean_age)) +
  geom_line()+ 
  geom_smooth(method='loess', formula= y~x)+scale_x_discrete("Año",limits = c("2006","","","",
                                                                              "2007","","","",
                                                                              "2008","","","",
                                                                              "2009","","","",
                                                                              "2010","","","",
                                                                              "2012","","","",
                                                                              "2013","","","",
                                                                              "2014","","","",
                                                                              "2015","","","",
                                                                              "2016","","","",
                                                                              "2017","","","",
                                                                              "2018","","","",
                                                                              "2019","","","",
                                                                              "2020","","",
                                                                              "2021","","","",
                                                                              "2022"))

  
#### MUJERES


ages_a<-get_data_age(urls[1:57],2)
ages_b<-get_data_age2(urls[58:64],2)
ages_c<-rbind(ages_a,ages_b)
ages_c<-ages_c %>%mutate(id=row_number())
names(ages_c)<-c("mean_age","id")
ggplot(ages_c, aes(x=id, y=mean_age)) +
  geom_line()+ 
  geom_smooth(method='loess', formula= y~x)+scale_x_discrete("Año",limits = c("2006","","","",
                                                                              "2007","","","",
                                                                              "2008","","","",
                                                                              "2009","","","",
                                                                              "2010","","","",
                                                                              "2012","","","",
                                                                              "2013","","","",
                                                                              "2014","","","",
                                                                              "2015","","","",
                                                                              "2016","","","",
                                                                              "2017","","","",
                                                                              "2018","","","",
                                                                              "2019","","","",
                                                                              "2020","","",
                                                                              "2021","","","",
                                                                              "2022"))

########################
##### OTRAS VARIABLES
########################





#############################
## Ejercicio por salario
############################


get_data_sal<-function(input_urls,sexo){
  
  output <- as.data.frame(matrix(ncol=1,nrow =1))
  
  for(i in 1:length(input_urls)){
    
    data<-read_spss(input_urls[i]) 
    data<-as.data.frame(data)
    colnames(data) <- tolower(colnames(data))
    
    data$l_nac_c<-as.character(data$l_nac_c)
    data$sex<-as.character(data$sex)
    #data$fac<-as.character(data$fac)
    data<-data%>% filter(l_nac_c=="225") %>%
      select(fac,sex,ing_x_hrs) %>% mutate(id=row_number())%>% filter(sex==sexo)%>%
      as_survey_design(ids = id, weight = fac)
    
    summary<-media_1y(data,ing_x_hrs)
    age<-as.data.frame(sum(summary$ing_x_hrs*summary$proportion))
    names(age)<-c("mean_age")
    output<-bind_rows(output, age)
    
    
  }
  output<-as.data.frame(output[-1,-1])
  output
}



get_data_sal2<-function(input_urls,sexo){
  
  output <- as.data.frame(matrix(ncol=1,nrow =1))
  
  for(i in 1:length(input_urls)){
    
    data<-read_spss(input_urls[i]) 
    data<-as.data.frame(data)
    colnames(data) <- tolower(colnames(data))
    data$fac<-data$fac_tri
    
    data$l_nac_c<-as.character(data$l_nac_c)
    data$sex<-as.character(data$sex)
    #data$fac<-as.character(data$fac)
    data<-data%>% filter(l_nac_c=="225") %>%
      select(fac,sex,ing_x_hrs) %>% mutate(id=row_number())%>% filter(sex==sexo)%>%
      as_survey_design(ids = id, weight = fac)
    
    summary<-media_1y(data,ing_x_hrs)
    age<-as.data.frame(sum(summary$ing_x_hrs*summary$proportion))
    names(age)<-c("mean_age")
    output<-bind_rows(output, age)
    
    
  }
  output<-as.data.frame(output[-1,-1])
  output
}

## HOMBRES
sal_a_h<-get_data_sal(urls[1:57],1)
sal_b_h<-get_data_sal(urls[58:64],1)
sal_c_h<-rbind(sal_a_h,sal_b_h)
sal_c_h<-ages_c_h %>%mutate(id=row_number())
names(sal_c_h)<-c("mean_salary_h","id")
ggplot(sal_c_h, aes(x=id, y=mean_salary_h)) +
  geom_line()+ 
  geom_smooth(method='loess', formula= y~x)+scale_x_discrete("Año",limits = c("2006","","","",
                                                                              "2007","","","",
                                                                              "2008","","","",
                                                                              "2009","","","",
                                                                              "2010","","","",
                                                                              "2012","","","",
                                                                              "2013","","","",
                                                                              "2014","","","",
                                                                              "2015","","","",
                                                                              "2016","","","",
                                                                              "2017","","","",
                                                                              "2018","","","",
                                                                              "2019","","","",
                                                                              "2020","","",
                                                                              "2021","","","",
                                                                              "2022"))


#### MUJERES


sal_a<-get_data_sal(urls[1:57],2)
sal_b<-get_data_sal2(urls[58:64],2)
sal_c<-rbind(sal_a,sal_b)
sal_c<-sal_c %>%mutate(id=row_number())
names(sal_c)<-c("mean_salary_h","id")
ggplot(sal_c, aes(x=id, y=mean_salary_h)) +
  geom_line()+ 
  geom_smooth(method='loess', formula= y~x)+scale_x_discrete("Año",limits = c("2006","","","",
                                                                              "2007","","","",
                                                                              "2008","","","",
                                                                              "2009","","","",
                                                                              "2010","","","",
                                                                              "2012","","","",
                                                                              "2013","","","",
                                                                              "2014","","","",
                                                                              "2015","","","",
                                                                              "2016","","","",
                                                                              "2017","","","",
                                                                              "2018","","","",
                                                                              "2019","","","",
                                                                              "2020","","",
                                                                              "2021","","","",
                                                                              "2022"))

############ HIJOS ########


get_data_nhij<-function(input_urls,sexo){
  
  output <- as.data.frame(matrix(ncol=1,nrow =1))
  
  for(i in 1:length(input_urls)){
    data<-read_spss(input_urls[i]) 
    
    data<-as.data.frame(data)
    colnames(data) <- tolower(colnames(data))
    
    data$l_nac_c<-as.character(data$l_nac_c)
    data$sex<-as.character(data$sex)
    data$n_hij<-as.numeric(data$n_hij)
    
    #data$fac<-as.character(data$fac)
    data<-data%>% filter(l_nac_c=="225") %>%
      select(fac,sex,n_hij) %>% mutate(id=row_number())%>% filter(sex==sexo)%>%
      as_survey_design(ids = id, weight = fac)
    
    summary<-media_1y(data,n_hij)
    summary<-summary %>% na.omit()
    age<-as.data.frame(sum(summary$n_hij*summary$proportion))
    names(age)<-c("mean_age")
    output<-bind_rows(output, age)
    
    
  }
  output<-as.data.frame(output[-1,-1])
  output
}



get_data_nhij2<-function(input_urls,sexo){
  
  output <- as.data.frame(matrix(ncol=1,nrow =1))
  
  for(i in 1:length(input_urls)){
    
    data<-read_spss(input_urls[i]) 
    data<-as.data.frame(data)
    colnames(data) <- tolower(colnames(data))
    data$fac<-data$fac_tri
    
    data$l_nac_c<-as.character(data$l_nac_c)
    data$sex<-as.character(data$sex)
    data$n_hij<-as.numeric(data$n_hij)
    
    #data$fac<-as.character(data$fac)
    data<-data%>% filter(l_nac_c=="225") %>%
      select(fac,sex,n_hij) %>% mutate(id=row_number())%>% filter(sex==sexo)%>%
      as_survey_design(ids = id, weight = fac)
    
    summary<-media_1y(data,n_hij)
    summary<-summary %>% na.omit()
    
    age<-as.data.frame(sum(summary$n_hij*summary$proportion))
    names(age)<-c("mean_age")
    output<-bind_rows(output, age)
    
    
  }
  output<-as.data.frame(output[-1,-1])
  output
}



hij_a<-get_data_nhij(urls[1:57],2)
hij_b<-get_data_nhij2(urls[58:64],2)
hij_c<-rbind(hij_a,hij_b)
hij_c<-hij_c %>%mutate(id=row_number())
names(hij_c)<-c("mean_child_h","id")
ggplot(hij_c, aes(x=id, y=mean_child_h)) +
  geom_line()+ 
  geom_smooth(method='loess', formula= y~x)+scale_x_discrete("Año",limits = c("2006","","","",
                                                                              "2007","","","",
                                                                              "2008","","","",
                                                                              "2009","","","",
                                                                              "2010","","","",
                                                                              "2012","","","",
                                                                              "2013","","","",
                                                                              "2014","","","",
                                                                              "2015","","","",
                                                                              "2016","","","",
                                                                              "2017","","","",
                                                                              "2018","","","",
                                                                              "2019","","","",
                                                                              "2020","","",
                                                                              "2021","","","",
                                                                              "2022"))








############ EDUC ########


get_data_edu<-function(input_urls,sexo){
  
  output <- as.data.frame(matrix(ncol=1,nrow =1))
  
  for(i in 1:length(input_urls)){
    data<-read_spss(input_urls[i]) 
    
    data<-as.data.frame(data)
    colnames(data) <- tolower(colnames(data))
    
    data$l_nac_c<-as.character(data$l_nac_c)
    data$sex<-as.character(data$sex)
    data$cs_p13_1<-as.numeric(data$cs_p13_1)
    
    #data$fac<-as.character(data$fac)
    data<-data%>% filter(l_nac_c=="225") %>%
      select(fac,sex,cs_p13_1) %>% mutate(id=row_number())%>% filter(sex==sexo)%>%
      as_survey_design(ids = id, weight = fac)
    
    summary<-media_1y(data,cs_p13_1)
    summary<-summary %>% na.omit()
    age<-as.data.frame(sum(summary$cs_p13_1*summary$proportion))
    names(age)<-c("mean_age")
    output<-bind_rows(output, age)
    
    
  }
  output<-as.data.frame(output[-1,-1])
  output
}



get_data_edu2<-function(input_urls,sexo){
  
  output <- as.data.frame(matrix(ncol=1,nrow =1))
  
  for(i in 1:length(input_urls)){
    
    data<-read_spss(input_urls[i]) 
    data<-as.data.frame(data)
    colnames(data) <- tolower(colnames(data))
    data$fac<-data$fac_tri
    
    data$l_nac_c<-as.character(data$l_nac_c)
    data$sex<-as.character(data$sex)
    data$cs_p13_1<-as.numeric(data$cs_p13_1)
    
    #data$fac<-as.character(data$fac)
    data<-data%>% filter(l_nac_c=="225") %>%
      select(fac,sex,cs_p13_1) %>% mutate(id=row_number())%>% filter(sex==sexo)%>%
      as_survey_design(ids = id, weight = fac)
    
    summary<-media_1y(data,cs_p13_1)
    summary<-summary %>% na.omit()
    
    age<-as.data.frame(sum(summary$cs_p13_1*summary$proportion))
    names(age)<-c("mean_age")
    output<-bind_rows(output, age)
    
    
  }
  output<-as.data.frame(output[-1,-1])
  output
}


# MUJERES
edu_a<-get_data_edu(urls[1:57],2)
edu_b<-get_data_edu2(urls[58:64],2)
edu_c<-rbind(edu_a,edu_b)
edu_c<-edu_c %>%mutate(id=row_number())
names(edu_c)<-c("mean_edu","id")
ggplot(edu_c, aes(x=id, y=mean_edu)) +
  geom_line()+ 
  geom_smooth(method='loess', formula= y~x)+scale_x_discrete("Año",limits = c("2006","","","",
                                                                              "2007","","","",
                                                                              "2008","","","",
                                                                              "2009","","","",
                                                                              "2010","","","",
                                                                              "2012","","","",
                                                                              "2013","","","",
                                                                              "2014","","","",
                                                                              "2015","","","",
                                                                              "2016","","","",
                                                                              "2017","","","",
                                                                              "2018","","","",
                                                                              "2019","","","",
                                                                              "2020","","",
                                                                              "2021","","","",
                                                                              "2022"))

#HOMBRES
edu_a_h<-get_data_edu(urls[1:57],1)
edu_b_h<-get_data_edu2(urls[58:64],1)
edu_c_h<-rbind(edu_a_h,edu_b_h)
edu_c_h<-edu_c_h %>%mutate(id=row_number())
names(edu_c_h)<-c("mean_edu","id")
ggplot(edu_c_h, aes(x=id, y=mean_edu)) +
  geom_line()+ 
  geom_smooth(method='loess', formula= y~x)+scale_x_discrete("Año",limits = c("2006","","","",
                                                                              "2007","","","",
                                                                              "2008","","","",
                                                                              "2009","","","",
                                                                              "2010","","","",
                                                                              "2012","","","",
                                                                              "2013","","","",
                                                                              "2014","","","",
                                                                              "2015","","","",
                                                                              "2016","","","",
                                                                              "2017","","","",
                                                                              "2018","","","",
                                                                              "2019","","","",
                                                                              "2020","","",
                                                                              "2021","","","",
                                                                              "2022"))




############ INGRESO ########


get_data_ing<-function(input_urls,sexo){
  
  output <- as.data.frame(matrix(ncol=1,nrow =1))
  
  for(i in 1:length(input_urls)){
    data<-read_spss(input_urls[i]) 
    
    data<-as.data.frame(data)
    colnames(data) <- tolower(colnames(data))
    
    data$l_nac_c<-as.character(data$l_nac_c)
    data$sex<-as.character(data$sex)
    data$cs_p13_1<-as.numeric(data$ingocup)
    
    #data$fac<-as.character(data$fac)
    data<-data%>% filter(l_nac_c=="225") %>%
      select(fac,sex,ingocup) %>% mutate(id=row_number())%>% filter(sex==sexo)%>%
      as_survey_design(ids = id, weight = fac)
    
    summary<-media_1y(data,ingocup)
    summary<-summary %>% na.omit()
    age<-as.data.frame(sum(summary$ingocup*summary$proportion))
    names(age)<-c("mean_age")
    output<-bind_rows(output, age)
    
    
  }
  output<-as.data.frame(output[-1,-1])
  output
}



get_data_ing2<-function(input_urls,sexo){
  
  output <- as.data.frame(matrix(ncol=1,nrow =1))
  
  for(i in 1:length(input_urls)){
    
    data<-read_spss(input_urls[i]) 
    data<-as.data.frame(data)
    colnames(data) <- tolower(colnames(data))
    data$fac<-data$fac_tri
    
    data$l_nac_c<-as.character(data$l_nac_c)
    data$sex<-as.character(data$sex)
    data$cs_p13_1<-as.numeric(data$ingocup)
    
    #data$fac<-as.character(data$fac)
    data<-data%>% filter(l_nac_c=="225") %>%
      select(fac,sex,ingocup) %>% mutate(id=row_number())%>% filter(sex==sexo)%>%
      as_survey_design(ids = id, weight = fac)
    
    summary<-media_1y(data,ingocup)
    summary<-summary %>% na.omit()
    
    age<-as.data.frame(sum(summary$ingocup*summary$proportion))
    names(age)<-c("mean_age")
    output<-bind_rows(output, age)
    
    
  }
  output<-as.data.frame(output[-1,-1])
  output
}


# MUJERES
ing_a<-get_data_ing(urls[1:57],2)
ing_b<-get_data_ing2(urls[58:64],2)
ing_c<-rbind(ing_a,ing_b)
ing_c<-ing_c %>%mutate(id=row_number())
names(ing_c)<-c("mean_inc","id")
ggplot(ing_c, aes(x=id, y=mean_inc)) +
  geom_line()+ 
  geom_smooth(method='loess', formula= y~x)+scale_x_discrete("Año",limits = c("2006","","","",
                                                                              "2007","","","",
                                                                              "2008","","","",
                                                                              "2009","","","",
                                                                              "2010","","","",
                                                                              "2012","","","",
                                                                              "2013","","","",
                                                                              "2014","","","",
                                                                              "2015","","","",
                                                                              "2016","","","",
                                                                              "2017","","","",
                                                                              "2018","","","",
                                                                              "2019","","","",
                                                                              "2020","","",
                                                                              "2021","","","",
                                                                              "2022"))

#HOMBRES
ing_a_h<-get_data_ing(urls[1:57],1)
ing_b_h<-get_data_ing2(urls[58:64],1)
ing_c_h<-rbind(ing_a_h,ing_b_h)
ing_c_h<-ing_c_h %>%mutate(id=row_number())
names(ing_c_h)<-c("mean_inc","id")
ggplot(ing_c_h, aes(x=id, y=mean_inc)) +
  geom_line()+ 
  geom_smooth(method='loess', formula= y~x)+scale_x_discrete("Año",limits = c("2006","","","",
                                                                              "2007","","","",
                                                                              "2008","","","",
                                                                              "2009","","","",
                                                                              "2010","","","",
                                                                              "2012","","","",
                                                                              "2013","","","",
                                                                              "2014","","","",
                                                                              "2015","","","",
                                                                              "2016","","","",
                                                                              "2017","","","",
                                                                              "2018","","","",
                                                                              "2019","","","",
                                                                              "2020","","",
                                                                              "2021","","","",
                                                                              "2022"))



