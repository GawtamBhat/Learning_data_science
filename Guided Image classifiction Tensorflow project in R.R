## THIS IS GUIDED IMAGE RECOGNITION AND CLASSIFICATION WITH KERAS IN R
## THIS ALSO USES TENSOR FLOW FOR MACHINE LEARNING.

print("Shree Ganeshaya Namaha")
install.packages("tensorflow")
library(tensorflow)
install_tensorflow()
tensorflow::install_tensorflow()

library(EBImage)
library(keras)

pictures <- c('b1.jpg', 'b2.jpg', 'b3.jpg','b4.jpg','b5.jpg','b6.jpg',
              'c1.jpg', 'c2.jpg', 'c3.jpg', 'c4.jpg', 'c5.jpg', 'c6.jpg')

mypictures <- list()
for (i in 1:12) {mypictures[[i]] <- readImage(pictures[i])}

#Explore images
print(mypictures[[2]])
display(mypictures[[4]])
summary(mypictures[[1]])

#Resize images for conv
for (i in 1:12) {mypictures[[i]]<- resize(mypictures[[i]], 28, 28)}

#Check the structure
str(mypictures)

#28*28*3 = 2352 <- single dimensional array

#Reshape
for (i in 1:12) {mypictures[[i]]<- array_reshape(mypictures[[i]], c(28,28,3))}

#Check the structure again
str(mypictures)

#Row Bind
trainX <- NULL
for (i in 7:11 ) {trainX <- rbind(trainX, mypictures[[i]])}
str(trainX)

testX <- rbind(mypictures[[6]], mypictures[[12]])

## Lets represent bikes by 0, cars 1
trainY <- c(0,0,0,0,0,1,1,1,1,1)
testY<- c(0,1)

#One hot encoding
trainLabels <- to_categorical(trainY)
tesLabels <- to_categorical(testY)














