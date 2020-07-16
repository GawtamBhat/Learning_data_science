## THIS IS GUIDED IMAGE RECOGNITION AND CLASSIFICATION WITH KERAS IN R
## THIS ALSO USES TENSOR FLOW FOR MACHINE LEARNING.

print("Shree Ganeshaya Namaha")
library(EBImage)
library(keras)
library(tensorflow)

setwd('/Users/gawtambhat/Documents/R Studio/Projects/Image Recognition and Classification')
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
for (i in 1:5) {trainX <- rbind(trainX, mypictures[[i]])}
for (i in 7:11 ) {trainX <- rbind(trainX, mypictures[[i]])}
str(trainX)

testX <- rbind(mypictures[[6]], mypictures[[12]])

## Lets represent bikes by 0, cars 1
trainY <- c(0,0,0,0,0,1,1,1,1,1)
testY<- c(0,1)

#One hot encoding
trainLabels <- to_categorical(trainY)
testLabels <- to_categorical(testY)

trainLabels

# Model
model <- keras_model_sequential()
model %>%
  layer_dense(units=256, activation='relu', input_shape = c(2352)) %>%
  layer_dense(unit=128, activation= 'relu')%>%
  layer_dense(units=2, activation = 'softmax')
summary(model)

#Compile
model%>%
  compile(loss='binary_crossentropy',
          optimizer= optimizer_rmsprop(),
          metrics=c('accuracy'))

#Fit model
history <- model %>%
  fit(trainX, 
      trainLabels, 
      epochs= 30, 
      batch_size=32, 
      validation_split= 0.2)

plot(history)


#Evaluation & Prediction - tRAIN data
model %>% evaluate(trainX, trainLabels)
pred <- model %>% predict_classes(trainX)
table(Predicted= pred, Actual= trainY)

prob <- model %>% predict_proba(trainX)
cbind(prob, Prected= pred, Actual= trainY)

#Evaluation & Prediction - test data
model %>% evaluate(testX, testLabels)
pred <- model %>% predict_classes((testX))
table(Prected= pred, Actual= testY)

