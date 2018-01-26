# Set the directory to store your files

#setwd("C:/Users/Bhagath/Desktop/R files")

#Load the data to 
data(iris)

#set seed to a number which generates the same random numbers though you run from different Machines
set.seed(42)

#set indexes to the data
index <- sample(x = 1:150, size = 100)

print(index)

# Dividing 2/3 to Taining and 1/3 to testing

train <- iris[index,]
test <- iris[-index,]


#To work with decision trees, we are installing tree package
#install.packages("tree")
library("tree")

#creating a model here (species is undefied but it check the result using summary and you will get to understand)
model <- tree(formula = Species ~ .,
              data = train)

#Checking the details
summary(model)

#Ploting the decision tree 
plot(model)

#Adding text to the decision tree
text(model)

#install library to fill individual colors
library(RColorBrewer)

#setting number of different categories
palette <- brewer.pal(3, "Set2")

#plotting the scatterplot
plot(x = iris$Petal.Length,
     y = iris$Petal.Width,
     pch = 19,
     col = palette[as.numeric(iris$Species)],
     main = "Iris Data set Details",
     xlab = "Petal Length",
     ylab = "Petal Width")

#plotting decision boundries
partition.tree(tree = model,
               label = "Species",
               add = TRUE)

#predicting 
prediction <- predict( object = model, newdata = test, type = "class")

#creating confusion matrix

table(x = prediction,
      y = test$Species)

#To determine how accurate or reliable our Machine 
#install.packages(c("caret","e1071"))
library(caret)
library(e1071)

#Evaluate predicted result
confusionMatrix(data = prediction,
                reference = test$Species)

save(model, file = "Tree.Rdata")
