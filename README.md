Auto-complete
============

### Summary
This rep contains an n-gram language model that predicts the next word, given a phrase of text as input. The prediction model is implemented as a shiny web application, in which the input text box was enabled with the functionality of the jQuery-ui autocomplete widget. The end result is a list of suggested words that shows up underneath the input text box and gets continuously updated as the user types. 

### Description of files

* **nGramsLite.RData**: An R data file that contains four data frames (ngram1, ngram2, ngram3, and ngram4). Each data frame corresponds to a specific length n-gram with three columns (n-1 phrase, nth word, and the corresponding frequency of occurrence). For example, the top 3 entries in the ngram4 data frame are:

|   | n-1 phrase  | nth word  | Count |
|---|-------------|-----------|-------|
| 1 | the end of  | the       | 7676  |
| 2 | the rest of | the       | 6698  |
| 3 | at the end  | of        | 6651  |

* **ngramPredictionFunction.R**: An R function that predicts the next word(s) based on a given phrase and a set of n-grams. Example of usage for predicting the 5 top most likely words: *ngramPredictionFunction("fool me once ", ngram1, ngram2, ngram3, ngram4)*

* **server.R**: The shiny server-side R code. 

* **www\index.html**: The html ui. Note that this file replaces the ui.R file, which does not exist in this alternative implementation.

* **www\jquery-ui.min.js**: The jQuery-ui auto-complete widget, downloaded from http://jqueryui.com/download/.

* **www\jquery-ui.css**: The css stylesheet for the jQuery-ui auto-complete widget, downloaded from http://jqueryui.com/download/.

* **www\images\**: Some other dependencies for the jQuery-ui auto-complete widget.

### Screenshot of working application

![auto-complete](screenshot.png?raw=true)

