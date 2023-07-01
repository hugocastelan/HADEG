library(tidyverse)

fileNames <- Sys.glob("*.tsv")


for (fileName in fileNames) {
  # read data:
  datos <- read.table(fileName, header = TRUE, sep = "\t")
  # filter:
  filter<-datos %>%group_by(seqid) %>%arrange(bitscore) %>% filter(bitscore ==  max(bitscore))
  #write
  write.table(filter, file=sprintf("%s.csv",fileName),sep=",", row.names=F)

}


