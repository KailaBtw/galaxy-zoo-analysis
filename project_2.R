library(ggplot2)
library(tidyr)
library(dplyr)
library(olsrr)
library(leaps)
set.seed(42)



#setwd("C:/Users/Admini/OneDrive/_csci_projects/_big_data/zoo/")
# Astronomy Project

# Import Data
galaxy = read.csv("C:/Users/Admin/OneDrive/_csci_projects/_big_data/zoo/GalaxyZoo_data.csv", header = T)

# Classify our galaxies
galaxy$ELIPTICAL = ifelse(galaxy$P_ELLIPTICAL >= 0.8, 1, 0)
galaxy$SPIRAL = ifelse(galaxy$P_SPIRAL >= 0.8, 1, 0)
galaxy$NEITHER = ifelse(galaxy$ELIPTICAL != 1 & galaxy$SPIRAL != 1, 1, 0)

galaxy = galaxy[galaxy$SPIRAL == 1 | galaxy$ELIPTICAL == 1,]
sum(galaxy$NEITHER)

# Fix row numbers
rownames(galaxy) <- 1:nrow(galaxy)

# De-log our data
galaxy <- galaxy %>%
  mutate(MASS = 10^LOG_MASS)
galaxy <- galaxy %>%
  mutate(LOC_DENSITY = 10^LOCAL_DENSITY)

subDf = subset(galaxy, select = c(LOG_MASS, LOCAL_DENSITY,MASS,LOC_DENSITY,
                                  NEARCLUSTER_MASS,AXIAL_RATIO,ELIPTICAL,SPIRAL))


#clean up some outliers
galaxy <- galaxy %>%
  filter(MASS <= 450000000000)
#subDf <- subDf %>%
#  filter(NEARCLUSTER_MASS <= 400000000000000)


#plot(df$x, df$y, main="Scatterplot of df", xlab="X", ylab="Y", pch=18, col = rgb(0.5, 0, 1))
ggplot(subDf, aes(x = NEARCLUSTER_MASS, y = LOG_MASS, color = as.factor(ELIPTICAL == "1"))) + 
  geom_point(size = 0.8, shape = 18) +
  scale_color_manual(values = c("#E88339", "#3029EE"), labels = c("Spiral", "Elliptical")) +
  theme(legend.position = "right") + 
  labs(x= "NEARCLUSTER_MASS", 
       y= "Galaxy Mass",
       color = "Galaxy Type",
       title = "Does Local Density affect Galaxy Mass",
       subtitle = "Scatterplot") + 
  #cale_x_continuous(breaks=seq(-2,2,0.5))+
  scale_y_continuous(breaks=seq(9.5,11.5,0.5)) 

#plot(df$x, df$y, main="Scatterplot of df", xlab="X", ylab="Y", pch=18, col = rgb(0.5, 0, 1))
ggplot(galaxy, aes(x = LOCAL_DENSITY, y = LOG_MASS, color = as.factor(ELIPTICAL == "1"))) + 
  geom_point(size = 0.8, shape = 18) +
  scale_color_manual(values = c("#E88339", "#3029EE"), labels = c("Spiral", "Elliptical")) +
  theme(legend.position = "right") + 
  labs(x= "Local Density", 
       y= "Galaxy Mass",
       color = "Galaxy Type",
       title = "Comparing Elliptical and Spiral Mass",
       subtitle = "Scatterplot") + 
  scale_x_continuous(breaks=seq(-2,2,0.5))+
  scale_y_continuous(breaks=seq(9.5,11.5,0.5)) 

subset_density_eli <- galaxy$LOC_DENSITY[as.numeric(galaxy$ELIPTICAL) == 1]
subset_density_spiral <- galaxy$LOC_DENSITY[as.numeric(galaxy$ELIPTICAL) == 0]
subset_mass_eli <- galaxy$MASS[as.numeric(galaxy$ELIPTICAL) == 1]
subset_mass_spiral <- galaxy$MASS[as.numeric(galaxy$ELIPTICAL) == 0]

sprintf("Mean NEARCLUSTER_MASS %f", mean(subDf$NEARCLUSTER_MASS))
sprintf("Mean LOCAL_DENSITY eli %f", mean(subset_density_eli))
sprintf("Mean LOCAL_DENSITY Spiral %f", mean(subset_density_spiral))
sprintf("Mean Mass %f", mean(galaxy$LOG_MASS))
sprintf("Mean Mass %f", mean(subset_mass_eli))
sprintf("Mean Mass %f", mean(subset_mass_spiral))
#sprintf("")

  
t_test_result <- t.test(subset_mass_eli, subset_mass_spiral)
print(t_test_result)

t_test_result2 <- t.test(subset_density_eli, subset_density_spiral)
print(t_test_result2)

ggplot(galaxy, aes(x = LOG_MASS, fill = as.character(SPIRAL))) +
  geom_histogram(position = "dodge", bins = 40) +
  scale_fill_manual(values = c("#E88339", "#3029EE"), labels = c("Elliptical", "Spiral")) +
  labs(fill = "Galaxy Type") +
  theme(legend.position = "right") + 
  labs(x= "Galaxy Mass", 
       y= "Galaxy Count",
       color = "Galaxy Type",
       title = "Mass Differences Between Galaxy Types",
       subtitle = "Histogram") 

ggplot(galaxy, aes(x = LOCAL_DENSITY, fill = as.character(SPIRAL))) +
  geom_histogram(position = "dodge", bins = 40) +
  scale_fill_manual(values = c("#E88339", "#3029EE"), labels = c("Elliptical", "Spiral")) +
  labs(fill = "Galaxy Type") +
  theme(legend.position = "right") + 
  labs(x= "Local Mass", 
       y= "Galaxy Count",
       color = "Galaxy Type",
       title = "Local Mass Differences Between Galaxy Types",
       subtitle = "Histogram") 


summary(galaxy$NEARCLUSTER_DIST)




# 1.d
lm_ld <- lm(LOG_MASS ~ LOCAL_DENSITY, data=galaxy)
summary(lm_ld)
anova(lm_ld)

ld_lm <- lm(LOCAL_DENSITY ~ LOG_MASS, data=subDf)
summary(ld_lm)
anova(ld_lm)

# t.test(a, b)

















