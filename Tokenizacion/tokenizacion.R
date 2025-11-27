
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

> library(tokenizers)
Warning message:
package ‘tokenizers’ was built under R version 4.3.3 
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
> library(tidytext)
> library(hcandersenr)
> the_fir_tree<-hcandersen_en %>%
+ filter(book == "The fir tree") %>%
+ pull(text)
> head(the_fir_tree, 9)
[1] "Far down in the forest, where the warm sun and the fresh air made a sweet"    
[2] "resting-place, grew a pretty little fir-tree; and yet it was not happy, it"   
[3] "wished so much to be tall like its companions– the pines and firs which grew" 
[4] "around it. The sun shone, and the soft air fluttered its leaves, and the"     
[5] "little peasant children passed by, prattling merrily, but the fir-tree heeded"
[6] "them not. Sometimes the children would bring a large basket of raspberries or"
[7] "strawberries, wreathed on a straw, and seat themselves near the fir-tree, and"
[8] "say, \"Is it not a pretty little tree?\" which made it feel more unhappy than"
[9] "before."                                                                      
> # Dividir las dos primeras lineas
> strsplit(the_fir_tree[1:2], "[^a-zA-Z0-9]+")
[[1]]
 [1] "Far"    "down"   "in"     "the"    "forest" "where"  "the"    "warm"  
 [9] "sun"    "and"    "the"    "fresh"  "air"    "made"   "a"      "sweet" 

[[2]]
 [1] "resting" "place"   "grew"    "a"       "pretty"  "little"  "fir"    
 [8] "tree"    "and"     "yet"     "it"      "was"     "not"     "happy"  
[15] "it"     

> tokenize_words(the_fir_tree[1:2])
[[1]]
 [1] "far"    "down"   "in"     "the"    "forest" "where"  "the"    "warm"  
 [9] "sun"    "and"    "the"    "fresh"  "air"    "made"   "a"      "sweet" 

[[2]]
 [1] "resting" "place"   "grew"    "a"       "pretty"  "little"  "fir"    
 [8] "tree"    "and"     "yet"     "it"      "was"     "not"     "happy"  
[15] "it"     

> sample_vector <- c("Far down in the forest",
+ "grew a pretty little fir-tree")
> sample_tibble <- tibble(text = sample_vector)
> tokenize_words(sample_vector)
[[1]]
[1] "far"    "down"   "in"     "the"    "forest"

[[2]]
[1] "grew"   "a"      "pretty" "little" "fir"    "tree"  

> sample_tibble %>%
+ unnest_tokens(word, text, token = "words")
# A tibble: 11 × 1
   word  
   <chr> 
 1 far   
 2 down  
 3 in    
 4 the   
 5 forest
 6 grew  
 7 a     
 8 pretty
 9 little
10 fir   
11 tree  
> sample_tibble %>%
+ unnest_tokens(word, text, token = "words", strip_punct = FALSE)
# A tibble: 12 × 1
   word  
   <chr> 
 1 far   
 2 down  
 3 in    
 4 the   
 5 forest
 6 grew  
 7 a     
 8 pretty
 9 little
10 fir   
11 -     
12 tree  
> # Tokens de caracteres
> tft_token_characters <- tokenize_characters(x = the_fir_tree,
+ lowercase = TRUE,
+ strip_non_alphanum = TRUE,
+ simplify = FALSE)
> head(tft_token_characters) %>%
+ glimpse()
List of 6
 $ : chr [1:57] "f" "a" "r" "d" ...
 $ : chr [1:57] "r" "e" "s" "t" ...
 $ : chr [1:61] "w" "i" "s" "h" ...
 $ : chr [1:56] "a" "r" "o" "u" ...
 $ : chr [1:64] "l" "i" "t" "t" ...
 $ : chr [1:64] "t" "h" "e" "m" ...
> # Mantener la puntuacion
> tokenize_characters(x = the_fir_tree,
+ strip_non_alphanum = FALSE) %>%
+ head() %>%
+ glimpse()
List of 6
 $ : chr [1:73] "f" "a" "r" " " ...
 $ : chr [1:74] "r" "e" "s" "t" ...
 $ : chr [1:76] "w" "i" "s" "h" ...
 $ : chr [1:72] "a" "r" "o" "u" ...
 $ : chr [1:77] "l" "i" "t" "t" ...
 $ : chr [1:77] "t" "h" "e" "m" ...
> tokenize_characters("flowers")
[[1]]
[1] "f" "l" "o" "w" "e" "r" "s"

> # Tokens de palabras
> tft_token_words <- tokenize_words(x = the_fir_tree,
+ lowercase = TRUE,
+ stopwords = NULL,
+ strip_punct = TRUE,
+ strip_numeric = FALSE)
> # Resultado
> head(tft_token_words) %>%
+ glimpse()
List of 6
 $ : chr [1:16] "far" "down" "in" "the" ...
 $ : chr [1:15] "resting" "place" "grew" "a" ...
 $ : chr [1:15] "wished" "so" "much" "to" ...
 $ : chr [1:14] "around" "it" "the" "sun" ...
 $ : chr [1:12] "little" "peasant" "children" "passed" ...
 $ : chr [1:13] "them" "not" "sometimes" "the" ...
> hcandersen_en %>%
+ filter(book %in% c("The fir tree", "The little mermaid")) %>%
+ unnest_tokens(word, text) %>%
+ count(book, word) %>%
+ group_by(book) %>%
+ arrange(desc(n)) %>%
+ slice(1:5)
# A tibble: 10 × 3
# Groups:   book [2]
   book               word      n
   <chr>              <chr> <int>
 1 The fir tree       the     278
 2 The fir tree       and     161
 3 The fir tree       tree     76
 4 The fir tree       it       66
 5 The fir tree       a        56
 6 The little mermaid the     817
 7 The little mermaid and     398
 8 The little mermaid of      252
 9 The little mermaid she     240
10 The little mermaid to      199
> # El codigo de arriba ^ es para contar que palabras se repiten más
> 
> # Tokenizacion de n gramas
> # Unigrama: "Hello", "day", "my", "little"
> # Bigrama: "fir tree", "fresh air", "to be", "Robin Hood"
> # Trigrama: "You and I", "please let go", "no time like", "the little mermaid"
> 
> tft_token_ngram <- tokenize_ngrams(x = the_fir_tree,
+ lowercase = TRUE,
+ n = 3L,
+ n_min = 3L,
+ stopwords = character(),
+ ngram_delim = " ",
+ simplify = FALSE)
> tft_token_ngram[[1]]
 [1] "far down in"      "down in the"      "in the forest"    "the forest where"
 [5] "forest where the" "where the warm"   "the warm sun"     "warm sun and"    
 [9] "sun and the"      "and the fresh"    "the fresh air"    "fresh air made"  
[13] "air made a"       "made a sweet"    
> set.seed(1234)
> length_and_max <- function(x) {
+ tab <- table(x)
+ paste(length(tab), max(tab), sep = "-")
+ }
> > count_ngrams <- function(data, n, n_min) {
Error: inesperado '>' en ">"
> count_ngrams <- function(data, n, n_min) {
+ ngrams <- tokenize_ngrams(data, n, n_min)
+ map_chr(ngrams, length_and_max)
+ }
> ngram_types <- c("quadrugram", "trigram", "bigram", "unigram")
> plotting_data <- hcandersen_en %>%
+ nest(data = c(text)) %>%
+ mutate(data = map_chr(data, ~ paste(.x$text, collapse = " "))) %>%
+ mutate(unigram = count_ngrams(data, n = 1, n_min = 1),
+ bigram = count_ngrams(data, n = 2, n_min = 2),
+ trigram = count_ngrams(data, n = 3, n_min = 3),
+ quadrugram = count_ngrams(data, n = 4, n_min = 4)) %>%
+ select(unigram, bigram, trigram, quadrugram) %>%
+ pivot_longer(cols = unigram:quadrugram, names_to = "ngrams") %>%
+ separate(value, c("length", "max"), convert = TRUE) %>%
+ mutate(ngrams = factor(ngrams, levels = ngram_types))
> plotting_data %>%
+ ggplot(aes(length, ngrams, color = max)) +
+ geom_jitter(width = 0, alpha = 0.8, height = 0.35) +
+ scale_color_viridis_c(trans = "log", breaks = c(1, 10, 100, 1000)) +
+ labs(x = "Number of unique n-grams",
+ y = NULL,
+ color = "Count of\nmost frequent\nngram",
+ title = "Unique n-grams by n-gram order",
+ subtitle = "Each point represents a H.C. Andersen Fairy tale")
> 
> tft_token_ngram <- tokenize_ngrams(x = the_fir_tree,
+ n = 2L,
+ n_min = 1L)
> tft_token_ngram[[1]]
 [1] "far"          "far down"     "down"         "down in"      "in"          
 [6] "in the"       "the"          "the forest"   "forest"       "forest where"
[11] "where"        "where the"    "the"          "the warm"     "warm"        
[16] "warm sun"     "sun"          "sun and"      "and"          "and the"     
[21] "the"          "the fresh"    "fresh"        "fresh air"    "air"         
[26] "air made"     "made"         "made a"       "a"            "a sweet"     
[31] "sweet"       
> # Sí es n = 1,2; irá como aparece arriba}: una palabra, dos palabras, una palabra...
> # Sí es n = 3,3; irá tres en tres pero la sigueinte palabra empezará con las últimas dos palabras anteriores
> # Ejemplo ("Hola yo soy" "yo soy Angel" "soy Angel Gabriel"), a diferencia de solo 1,2
> # Y así sucesivamente
> 
> # Líneas, oraciones, y párrafos de tokens
> # Novela Northanger Abbey
> add_paragraphs <- function(data) {
+ pull(data, text) %>%
+ paste(collapse = "\n") %>%
+ tokenize_paragraphs() %>%
+ unlist() %>%
+ tibble(text = .) %>%
+ mutate(paragraph = row_number())
+ }
> install.packages("janeaustenr")
Installing package into ‘C:/Users/DELL/AppData/Local/R/win-library/4.3’
(as ‘lib’ is unspecified)
--- Please select a CRAN mirror for use in this session ---
probando la URL 'https://cloud.r-project.org/bin/windows/contrib/4.3/janeaustenr_1.0.0.zip'
Content type 'application/zip' length 1626720 bytes (1.6 MB)
downloaded 1.6 MB

package ‘janeaustenr’ successfully unpacked and MD5 sums checked

The downloaded binary packages are in
        C:\Users\DELL\AppData\Local\Temp\RtmpyKOxis\downloaded_packages
> library(janeaustenr)
Warning message:
package ‘janeaustenr’ was built under R version 4.3.3 
> northangerabbey_paragraphed <- tibble(text = northangerabbey) %>%
+ mutate(chapter = cumsum(str_detect(text, "^CHAPTER "))) %>%
+ filter(chapter > 0,
+ !str_detect(text, "^CHAPTER ")) %>%
+ nest(data = text) %>%
+ mutate(data = map(data, add_paragraphs)) %>%
+ unnest(cols = c(data))
> glimpse(northangerabbey_paragraphed)
Rows: 1,020
Columns: 3
$ chapter   <int> 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 2, 2, …
$ text      <chr> "No one who had ever seen Catherine Morland in her infancy w…
$ paragraph <int> 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 1…
> 
> the_fir_tree_sentences <- the_fir_tree %>%
+ paste(collapse = " ") %>%
+ tokenize_sentences()
> head(the_fir_tree_sentences[[1]])
[1] "Far down in the forest, where the warm sun and the fresh air made a sweet resting-place, grew a pretty little fir-tree; and yet it was not happy, it wished so much to be tall like its companions– the pines and firs which grew around it."
[2] "The sun shone, and the soft air fluttered its leaves, and the little peasant children passed by, prattling merrily, but the fir-tree heeded them not."                                                                                       
[3] "Sometimes the children would bring a large basket of raspberries or strawberries, wreathed on a straw, and seat themselves near the fir-tree, and say, \"Is it not a pretty little tree?\""                                                  
[4] "which made it feel more unhappy than before."                                                                                                                                                                                                
[5] "And yet all this while the tree grew a notch or joint taller every year; for by the number of joints in the stem of a fir-tree we can discover its age."                                                                                     
[6] "Still, as it grew, it complained."                                                                                                                                                                                                           
> 
> hcandersen_sentences <- hcandersen_en %>%
+ nest(data = c(text)) %>%
+ mutate(data = map_chr(data, ~ paste(.x$text, collapse = " "))) %>%
+ unnest_sentences(sentences, data)
> 
> # ¿Dónde falla la tokenización?
> tokenize_words("$1")
[[1]]
[1] "1"

> tokenize_words("$1", strip_punct = FALSE)
[[1]]
[1] "$" "1"

> # Construir tu propio token
> # Tokenizar a los personajes, manteniendo solo las letras
> letter_tokens <- str_extract_all(
+ string = "This sentence include 2 numbers and 1 period.",
+ pattern = "[:alpha:]{1}"
+ )
> letter_tokens
[[1]]
 [1] "T" "h" "i" "s" "s" "e" "n" "t" "e" "n" "c" "e" "i" "n" "c" "l" "u" "d" "e"
[20] "n" "u" "m" "b" "e" "r" "s" "a" "n" "d" "p" "e" "r" "i" "o" "d"

> danish_sentence <- "Så mødte han en gammel heks på landevejen"
> str_extract_all(danish_sentence, "[:alpha:]")
[[1]]
 [1] "S" "å" "m" "ø" "d" "t" "e" "h" "a" "n" "e" "n" "g" "a" "m" "m" "e" "l" "h"
[20] "e" "k" "s" "p" "å" "l" "a" "n" "d" "e" "v" "e" "j" "e" "n"

> str_extract_all(danish_sentence, "[a-zA-Z]")
[[1]]
 [1] "S" "m" "d" "t" "e" "h" "a" "n" "e" "n" "g" "a" "m" "m" "e" "l" "h" "e" "k"
[20] "s" "p" "l" "a" "n" "d" "e" "v" "e" "j" "e" "n"

> # Permitir palabras con guion
> > str_split("This isn't a sentence with hyphenated-words.", "[:space:]")
Error: inesperado '>' en ">"
> str_split("This isn't a sentence with hyphenated-words.", "[:space:]")
[[1]]
[1] "This"              "isn't"             "a"                
[4] "sentence"          "with"              "hyphenated-words."

> str_split("This isn't a sentence with hyphenated-words.", "[:space:]") %>%
+ map(~ str_remove_all(.x, "^[:punct:]+|[:punct:]+$"))
[[1]]
[1] "This"             "isn't"            "a"                "sentence"        
[5] "with"             "hyphenated-words"

> str_extract_all(
+ string = "This isn't a sentence with hyphenated-words.",
+ pattern = "[:alpha:]+-[:alpha:]+"
+ )
[[1]]
[1] "hyphenated-words"

> str_extract_all(
+ string = "This isn't a sentence with hyphenated-words.",
+ pattern = "[:alpha:]+-?[:alpha:]+"
+ )
[[1]]
[1] "This"             "isn"              "sentence"         "with"            
[5] "hyphenated-words"

> str_extract_all(
+ string = "This isn't a sentence with hyphenated-words.",
+ pattern = "[[:alpha:]']+-?[[:alpha:]']+"
+ )
[[1]]
[1] "This"             "isn't"            "sentence"         "with"            
[5] "hyphenated-words"

> str_extract_all(
+ string = "This isn't a sentence with hyphenated-words.",
+ pattern = "[[:alpha:]']+-?[[:alpha:]']+|[:alpha:]{1}"
+ )
[[1]]
[1] "This"             "isn't"            "a"                "sentence"        
[5] "with"             "hyphenated-words"

> # Envolviéndolo (wrapping) en una función
> tokenize_hyphenated_words <- function(x, lowercase = TRUE) {
+ if (lowercase)
+ x <- str_to_lower(x)
+ str_split(x, "[:space:]") %>%
+ map(~ str_remove_all(.x, "^[:punct:]+|[:punct:]+$"))
+ }
> tokenize_hyphenated_words(the_fir_tree[1:3])
[[1]]
 [1] "far"    "down"   "in"     "the"    "forest" "where"  "the"    "warm"  
 [9] "sun"    "and"    "the"    "fresh"  "air"    "made"   "a"      "sweet" 

[[2]]
 [1] "resting-place" "grew"          "a"             "pretty"       
 [5] "little"        "fir-tree"      "and"           "yet"          
 [9] "it"            "was"           "not"           "happy"        
[13] "it"           

[[3]]
 [1] "wished"     "so"         "much"       "to"         "be"        
 [6] "tall"       "like"       "its"        "companions" "the"       
[11] "pines"      "and"        "firs"       "which"      "grew"      

> # Convertirlo a función
> tokenize_character_ngram <- function(x, n){
+ ngram_loc <- str_locate_all(x, paste0("(?=(\\w{", n, "}))"))
+ map2(ngram_loc, x, ~str_sub(.y, .x[, 1], .x[, 1] + n - 1))
+ }
> tokenize_character_ngram(the_fir_tree[1:3], n = 3)
[[1]]
 [1] "Far" "dow" "own" "the" "for" "ore" "res" "est" "whe" "her" "ere" "the"
[13] "war" "arm" "sun" "and" "the" "fre" "res" "esh" "air" "mad" "ade" "swe"
[25] "wee" "eet"

[[2]]
 [1] "res" "est" "sti" "tin" "ing" "pla" "lac" "ace" "gre" "rew" "pre" "ret"
[13] "ett" "tty" "lit" "itt" "ttl" "tle" "fir" "tre" "ree" "and" "yet" "was"
[25] "not" "hap" "app" "ppy"

[[3]]
 [1] "wis" "ish" "she" "hed" "muc" "uch" "tal" "all" "lik" "ike" "its" "com"
[13] "omp" "mpa" "pan" "ani" "nio" "ion" "ons" "the" "pin" "ine" "nes" "and"
[25] "fir" "irs" "whi" "hic" "ich" "gre" "rew"

> # Tokenizacion para alfabetos no latinos
> install.packages("jiebaR") # usen un mirror de China!
Installing package into ‘C:/Users/DELL/AppData/Local/R/win-library/4.3’
(as ‘lib’ is unspecified)
Warning message:
package ‘jiebaR’ is not available for this version of R

A version of this package for your version of R might be available elsewhere,
see the ideas at
https://cran.r-project.org/doc/manuals/r-patched/R-admin.html#Installing-packages 
> library(jiebaR)
Error in library(jiebaR) : there is no package called ‘jiebaR’
> # Benchmarks para la tokenizacion
> install.packages("bench")
Installing package into ‘C:/Users/DELL/AppData/Local/R/win-library/4.3’
(as ‘lib’ is unspecified)
also installing the dependencies ‘glue’, ‘pillar’, ‘profmem’, ‘rlang’


  There are binary versions available but the source versions are later:
        binary source needs_compilation
pillar  1.10.2 1.11.1             FALSE
profmem  0.6.0  0.7.0             FALSE
rlang    1.1.5  1.1.6              TRUE

  Binaries will be installed
probando la URL 'https://cloud.r-project.org/bin/windows/contrib/4.3/glue_1.8.0.zip'
Content type 'application/zip' length 181878 bytes (177 KB)
downloaded 177 KB

probando la URL 'https://cloud.r-project.org/bin/windows/contrib/4.3/rlang_1.1.5.zip'
Content type 'application/zip' length 1587106 bytes (1.5 MB)
downloaded 1.5 MB

probando la URL 'https://cloud.r-project.org/bin/windows/contrib/4.3/bench_1.1.4.zip'
Content type 'application/zip' length 402408 bytes (392 KB)
downloaded 392 KB

package ‘glue’ successfully unpacked and MD5 sums checked
Warning: cannot remove prior installation of package ‘glue’
Warning: restored ‘glue’
package ‘rlang’ successfully unpacked and MD5 sums checked
Warning: cannot remove prior installation of package ‘rlang’
Warning: restored ‘rlang’
package ‘bench’ successfully unpacked and MD5 sums checked

The downloaded binary packages are in
        C:\Users\DELL\AppData\Local\Temp\RtmpyKOxis\downloaded_packages
installing the source packages ‘pillar’, ‘profmem’

probando la URL 'https://cloud.r-project.org/src/contrib/pillar_1.11.1.tar.gz'
Content type 'application/x-gzip' length 409508 bytes (399 KB)
downloaded 399 KB

probando la URL 'https://cloud.r-project.org/src/contrib/profmem_0.7.0.tar.gz'
Content type 'application/x-gzip' length 19616 bytes (19 KB)
downloaded 19 KB

* installing *source* package 'pillar' ...
** package 'pillar' successfully unpacked and MD5 sums checked
** using staged installation
** R
** inst
** byte-compile and prepare package for lazy loading
** help
*** installing help indices
*** copying figures
** building package indices
** installing vignettes
** testing if installed package can be loaded from temporary location
** testing if installed package can be loaded from final location
** testing if installed package keeps a record of temporary installation path
* DONE (pillar)
* installing *source* package 'profmem' ...
** package 'profmem' successfully unpacked and MD5 sums checked
** using staged installation
** R
** inst
** byte-compile and prepare package for lazy loading
** help
*** installing help indices
** building package indices
** installing vignettes
** testing if installed package can be loaded from temporary location
** testing if installed package can be loaded from final location
** testing if installed package keeps a record of temporary installation path
* DONE (profmem)

The downloaded source packages are in
        ‘C:\Users\DELL\AppData\Local\Temp\RtmpyKOxis\downloaded_packages’
Warning messages:
1: In file.copy(savedcopy, lib, recursive = TRUE) :
  problema al copiar C:\Users\DELL\AppData\Local\R\win-library\4.3\00LOCK\glue\libs\x64\glue.dll  a C:\Users\DELL\AppData\Local\R\win-library\4.3\glue\libs\x64\glue.dll: Permission denied
2: In file.copy(savedcopy, lib, recursive = TRUE) :
  problema al copiar C:\Users\DELL\AppData\Local\R\win-library\4.3\00LOCK\rlang\libs\x64\rlang.dll  a C:\Users\DELL\AppData\Local\R\win-library\4.3\rlang\libs\x64\rlang.dll: Permission denied
> library(bench)
Error: package or namespace load failed for ‘bench’ in loadNamespace(j <- i[[1L]], c(lib.loc, .libPaths()), versionCheck = vI[[j]]):
 namespace ‘pillar’ 1.9.0 is already loaded, but >= 1.10.1 is required
Además: Warning message:
package ‘bench’ was built under R version 4.3.3 
> remove.packages("bench")
Removing package from ‘C:/Users/DELL/AppData/Local/R/win-library/4.3’
(as ‘lib’ is unspecified)
> 
