
ngramPredictionFunction <- function(input, ngram1, ngram2, ngram3, ngram4) { 
  
  out <- data.table(y = c(" ", "  ", "   ", "    ", "     "), freq = rep(0,5)) # dummy output
  
      input <- gsub("[^a-zA-Z \']", "", input)
      input <- tolower(input)
      LastChar <- substring(input, nchar(input), nchar(input))    
      input <- NGramTokenizer(input, Weka_control(min = 1, max = 1, delimiters = " \\r\\n\\t.,;:\"()?!"))
      
      # lastChar is space?
      
      if (LastChar==" ") { # new word
          LastWord = paste("^",  character(0) , sep="")
      } else { # filter
          LastWord <- paste("^",  input[length(input)] , sep="")      
          input <- input[-length(input)]
      }
      
      # 4-gram
      if (length(input)>2) {
          txt <- paste(input[(length(input)-2):length(input)], collapse=" ")
          wd.list <- ngram4[x==txt, c(2,3), with = FALSE]
          wd.list <- wd.list[grep(LastWord, wd.list$y),]
          wd.list$freq <- wd.list$freq /sum(wd.list$freq)*0.6
          out <- rbind(out, wd.list)
      }

      # 3-gram
      if (length(input)>1) {
          txt <- paste(input[(length(input)-1):length(input)], collapse=" ")
          wd.list <- ngram3[x==txt, c(2,3), with = FALSE]
          wd.list <-  wd.list[grep(LastWord, wd.list$y),]
          wd.list$freq <- wd.list$freq /sum(wd.list$freq)*0.3
          out <- rbind(out, wd.list)
      }
      
      # 2-gram
      if (length(input)>0) {
          txt <- input[length(input)]
          wd.list <- ngram2[x==txt, c(2,3), with = FALSE]
          if (LastWord != "^") {wd.list <-  wd.list[grep(LastWord, wd.list$y),]}
          wd.list$freq <- wd.list$freq /sum(wd.list$freq )*0.08
          wd.list <- wd.list[min(1,nrow(wd.list)):min(100,nrow(wd.list)),]          
          out <- rbind(out, wd.list)
      }
      
      # 1-gram
      wd.list <- ngram1[grep(LastWord, ngram1$y),]
      wd.list$freq <- wd.list$freq /sum(ngram1$freq)*0.02
      wd.list <- wd.list[min(1,nrow(wd.list)):min(100,nrow(wd.list)),]
      out <- rbind(out, wd.list)
    
      out <- out[, lapply(.SD, sum), by = c("y")]
      out <- out[order(-out$freq),]
      rownames(out) <- NULL
          
      return(head(out, n=5))

}
