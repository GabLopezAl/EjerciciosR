
R version 4.3.2 (2023-10-31 ucrt) -- "Eye Holes"
Copyright (C) 2023 The R Foundation for Statistical Computing
Platform: x86_64-w64-mingw32/x64 (64-bit)

R es un software libre y viene sin GARANTIA ALGUNA.
Usted puede redistribuirlo bajo ciertas circunstancias.
Escriba 'license()' o 'licence()' para detalles de distribucion.

R es un proyecto colaborativo con muchos contribuyentes.
Escriba 'contributors()' para obtener más información y
'citation()' para saber cómo citar R o paquetes de R en publicaciones.

Escriba 'demo()' para demostraciones, 'help()' para el sistema on-line de ayuda,
o 'help.start()' para abrir el sistema de ayuda HTML con su navegador.
Escriba 'q()' para salir de R.

[Previously saved workspace restored]

> # Palabras vacías
> library(stopwords)
Warning message:
package ‘stopwords’ was built under R version 4.3.3 
> length(stopwords(source = "smart"))
[1] 571
> length(stopwords(source = "snowball"))
[1] 175
> length(stopwords(source = "stopwords-iso"))
[1] 1298
> setdiff(stopwords(source = "snowball"),
+ stopwords(source = "smart"))
 [1] "she's"   "he'd"    "she'd"   "he'll"   "she'll"  "shan't"  "mustn't"
 [8] "when's"  "why's"   "how's"  
> library(tidyverse)
── Attaching core tidyverse packages ──────────────────────── tidyverse 2.0.0 ──
✔ dplyr     1.1.4     ✔ readr     2.1.5
✔ forcats   1.0.0     ✔ stringr   1.5.1
✔ ggplot2   3.4.4     ✔ tibble    3.2.1
✔ lubridate 1.9.4     ✔ tidyr     1.3.1
✔ purrr     1.0.2     
── Conflicts ────────────────────────────────────────── tidyverse_conflicts() ──
✖ dplyr::filter() masks stats::filter()
✖ dplyr::lag()    masks stats::lag()
ℹ Use the conflicted package (<http://conflicted.r-lib.org/>) to force all conflicts to become errors
Warning message:
package ‘lubridate’ was built under R version 4.3.3 
> str_subset(stopwords(source = "smart"), "'")
 [1] "a's"       "ain't"     "aren't"    "c'mon"     "c's"       "can't"    
 [7] "couldn't"  "didn't"    "doesn't"   "don't"     "hadn't"    "hasn't"   
[13] "haven't"   "he's"      "here's"    "i'd"       "i'll"      "i'm"      
[19] "i've"      "isn't"     "it'd"      "it'll"     "it's"      "let's"    
[25] "shouldn't" "t's"       "that's"    "there's"   "they'd"    "they'll"  
[31] "they're"   "they've"   "wasn't"    "we'd"      "we'll"     "we're"    
[37] "we've"     "weren't"   "what's"    "where's"   "who's"     "won't"    
[43] "wouldn't"  "you'd"     "you'll"    "you're"    "you've"   
> # Eliminacion de palabras vacías en R
> library(hcandersenr)
> library(tidytext)
> 
> fir_tree <- hca_fairytales() %>%
+ filter(book == "The fir tree",
+ language == "English")
> 
> tidy_fir_tree <- fir_tree %>%
+ unnest_tokens(word, text)
> 
> tidy_fir_tree %>%
+ filter(!(word %in% stopwords(source = "snowball")))
# A tibble: 1,547 × 3
   book         language word   
   <chr>        <chr>    <chr>  
 1 The fir tree English  far    
 2 The fir tree English  forest 
 3 The fir tree English  warm   
 4 The fir tree English  sun    
 5 The fir tree English  fresh  
 6 The fir tree English  air    
 7 The fir tree English  made   
 8 The fir tree English  sweet  
 9 The fir tree English  resting
10 The fir tree English  place  
# ℹ 1,537 more rows
# ℹ Use `print(n = ...)` to see more rows
> 
> > tidy_fir_tree %>%
Error: inesperado '>' en ">"
> tidy_fir_tree %>%
+ anti_join(get_stopwords(source = "snowball"))
Joining with `by = join_by(word)`
# A tibble: 1,547 × 3
   book         language word   
   <chr>        <chr>    <chr>  
 1 The fir tree English  far    
 2 The fir tree English  forest 
 3 The fir tree English  warm   
 4 The fir tree English  sun    
 5 The fir tree English  fresh  
 6 The fir tree English  air    
 7 The fir tree English  made   
 8 The fir tree English  sweet  
 9 The fir tree English  resting
10 The fir tree English  place  
# ℹ 1,537 more rows
# ℹ Use `print(n = ...)` to see more rows
> 
> # Creación de tu propia lista de palabras vacías
> library(rlang)

Attaching package: ‘rlang’

The following objects are masked from ‘package:purrr’:

    %@%, flatten, flatten_chr, flatten_dbl, flatten_int, flatten_lgl,
    flatten_raw, invoke, splice

> calc_idf <- function(df, word, document) {
+ words <- df %>% pull({{word}}) %>% unique()
+ n_docs <- length(unique(pull(df, {{document}})))
+ n_words <- df %>%
+ nest(data = c({{word}})) %>%
+ pull(data) %>%
+ map_dfc(~ words %in% unique(pull(.x, {{word}}))) %>%
+ rowSums()
+ tibble(word = words,
+ idf = log(n_docs / n_words))
+ }
> q()
> 
