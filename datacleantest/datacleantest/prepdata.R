#prepare test data
test <- read.csv("test.csv")
training <- read.csv("train.csv")

# There is no loss variable in test file.
test$loss <- NA

test$type <- "test"
training$type <- "training"

alldata <- rbind(training, test)

# make file a lot smaller

set.seed(123)
alldata <- alldata[sample(1:nrow(alldata), 1000), ]

saveRDS(alldata, file = "alldata.rds")
