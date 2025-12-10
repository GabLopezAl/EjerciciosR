
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

> library(hcandersenr)
>  library(tidyverse)
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
> 
> fir_tree <- hca_fairytales() %>%
+ filter(book == "The fir tree",
+ language == "English")
> 
> tidy_fir_tree <- fir_tree %>%
+ unnest_tokens(word, text) %>%
+ anti_join(get_stopwords())
Joining with `by = join_by(word)`
> 
> tidy_fir_tree %>%
+ count(word, sort = TRUE) %>%
+ filter(str_detect(word, "^tree"))
# A tibble: 3 × 2
  word       n
  <chr>  <int>
1 tree      76
2 trees     12
3 tree's     1
>  library(SnowballC)
> tidy_fir_tree %>%
+ mutate(stem = wordStem(word)) %>%
+ count(stem, sort = TRUE)
# A tibble: 570 × 2
   stem        n
   <chr>   <int>
 1 tree       88
 2 fir        34
 3 littl      23
 4 said       22
 5 stori      16
 6 thought    16
 7 branch     15
 8 on         15
 9 came       14
10 know       14
# ℹ 560 more rows
# ℹ Use `print(n = ...)` to see more rows
> 
>  stopword_df <- tribble(~language, ~two_letter,
+ "danish", "da"
+ "english", "en",
Error: unexpected string constant in:
""danish", "da"
"english""
>  stopword_df <- tribble(~language, ~two_letter,
+ "danish", "da",
+ "english", "en",
+ "french", "fr",
+ "german", "de",
+ "spanish", "es")
> 
>  tidy_by_lang <- hca_fairytales() %>%
+  filter(book == "The fir tree") %>%
+ select(text, language) %>%
+ mutate(language = str_to_lower(language)) %>%
+ unnest_tokens(word, text) %>%
+ nest(data = word)
> 
> # Eliminar palabras vacias
>  tidy_by_lang %>%
+ inner_join(stopword_df) %>%
+ mutate(data = map2(
+ data, two_letter, ~ anti_join(.x, get_stopwords(language = .y)))
+ ) %>%
+ unnest(data) %>%
+ mutate(stem = wordStem(word, language = language)) %>%
+ group_by(language) %>%
+ count(stem) %>%
+ top_n(20, n) %>%
+ ungroup %>%
+ ggplot(aes(n, fct_reorder(stem, n), fill = language)) +
+ geom_col(show.legend = FALSE) +
+  facet_wrap(~language, scales = "free_y", ncol = 2) +
+ labs(x = "Frequency", y = NULL)
Joining with `by = join_by(language)`
Joining with `by = join_by(word)`
Joining with `by = join_by(word)`
Joining with `by = join_by(word)`
Joining with `by = join_by(word)`
Joining with `by = join_by(word)`
> library(hunspell)
Error in library(hunspell) : there is no package called ‘hunspell’
> install.packages("hunspell")
Installing package into ‘C:/Users/DELL/AppData/Local/R/win-library/4.3’
(as ‘lib’ is unspecified)
--- Please select a CRAN mirror for use in this session ---
Warning: failed to download mirrors file (no fue posible abrir la URL 'https://cran.r-project.org/CRAN_mirrors.csv'); using local file 'C:/PROGRA~1/R/R-43~1.2/doc/CRAN_mirrors.csv'
probando la URL 'https://cloud.r-project.org/bin/windows/contrib/4.3/hunspell_3.0.6.zip'
Content type 'application/zip' length 1487956 bytes (1.4 MB)
downloaded 1.4 MB

package ‘hunspell’ successfully unpacked and MD5 sums checked

The downloaded binary packages are in
        C:\Users\DELL\AppData\Local\Temp\RtmpeC9J8e\downloaded_packages
Warning message:
In download.file(url, destfile = f, quiet = TRUE) :
  URL 'https://cran.r-project.org/CRAN_mirrors.csv': Timeout of 60 seconds was reached
> library(hunspell)
Warning message:
package ‘hunspell’ was built under R version 4.3.3 
> tidy_fir_tree %>%
+ mutate(stem = hunspell_stem(word)) %>%
+ unnest(stem) %>%
+ count(stem, sort = TRUE)
# A tibble: 595 × 2
   stem       n
   <chr>  <int>
 1 tree      89
 2 fir       34
 3 little    23
 4 said      22
 5 story     16
 6 branch    15
 7 one       15
 8 came      14
 9 know      14
10 now       14
# ℹ 585 more rows
# ℹ Use `print(n = ...)` to see more rows
> hunspell_stem("discontented")
[[1]]
[1] "contented" "content"  

> # Conjunto de datos de opiniones de la Corte Suprema de los Estados Unidos
> install.packages("remotes")
Installing package into ‘C:/Users/DELL/AppData/Local/R/win-library/4.3’
(as ‘lib’ is unspecified)
probando la URL 'https://cloud.r-project.org/bin/windows/contrib/4.3/remotes_2.5.0.zip'
Content type 'application/zip' length 431760 bytes (421 KB)
downloaded 421 KB

package ‘remotes’ successfully unpacked and MD5 sums checked

The downloaded binary packages are in
        C:\Users\DELL\AppData\Local\Temp\RtmpeC9J8e\downloaded_packages
> remotes::install_github("EmilHvitfeldt/scotus")
Using GitHub PAT from the git credential store.
Downloading GitHub repo EmilHvitfeldt/scotus@HEAD
── R CMD build ─────────────────────────────────────────────────────────────────
         checking for file 'C:\Users\DELL\AppData\Local\Temp\RtmpeC9J8e\remotes2b681a09442\EmilHvitfeldt-scotus-e5ccdea/DESCRIPTION' ...  ✔  checking for file 'C:\Users\DELL\AppData\Local\Temp\RtmpeC9J8e\remotes2b681a09442\EmilHvitfeldt-scotus-e5ccdea/DESCRIPTION' (846ms)
      ─  preparing 'scotus':
   checking DESCRIPTION meta-information ...     checking DESCRIPTION meta-information ...   ✔  checking DESCRIPTION meta-information
      ─  checking for LF line-endings in source and make files and shell scripts
  ─  checking for empty or unneeded directories
      ─  building 'scotus_1.0.0.tar.gz'
     
Installing package into ‘C:/Users/DELL/AppData/Local/R/win-library/4.3’
(as ‘lib’ is unspecified)
* installing *source* package 'scotus' ...
** using staged installation
** R
** data
*** moving datasets to lazyload DB
** byte-compile and prepare package for lazy loading
** help
*** installing help indices
** building package indices
** testing if installed package can be loaded from temporary location
** testing if installed package can be loaded from final location
** testing if installed package keeps a record of temporary installation path
* DONE (scotus)
> library(scotus)
> tidy_scotus <- scotus_filtered %>%
+ unnest_tokens(word, text) %>%
+ anti_join(get_stopwords())
Joining with `by = join_by(word)`
>  tidy_scotus %>%
+ count(word, sort = TRUE)
# A tibble: 167,852 × 2
   word        n
   <chr>   <int>
 1 court  286449
 2 v      204176
 3 state  148320
 4 states 128161
 5 case   121439
 6 act    111033
 7 s.ct   108168
 8 u.s    106413
 9 upon   105069
10 united 103267
# ℹ 167,842 more rows
# ℹ Use `print(n = ...)` to see more rows
> install.packages("quanteda")
Installing package into ‘C:/Users/DELL/AppData/Local/R/win-library/4.3’
(as ‘lib’ is unspecified)

  There is a binary version available but the source version is later:
         binary source needs_compilation
quanteda  4.2.0  4.3.1              TRUE

  Binaries will be installed
probando la URL 'https://cloud.r-project.org/bin/windows/contrib/4.3/quanteda_4.2.0.zip'
Content type 'application/zip' length 2684383 bytes (2.6 MB)
downloaded 2.6 MB

package ‘quanteda’ successfully unpacked and MD5 sums checked

The downloaded binary packages are in
        C:\Users\DELL\AppData\Local\Temp\RtmpeC9J8e\downloaded_packages
> library(quanteda)
Package version: 4.2.0
Unicode version: 15.1
ICU version: 74.1
Parallel computing: 4 of 4 threads used.
See https://quanteda.io for tutorials and examples.

Attaching package: ‘quanteda’

The following object is masked from ‘package:hunspell’:

    dictionary

Warning messages:
1: package ‘quanteda’ was built under R version 4.3.3 
2: In .recacheSubclasses(def@className, def, env) :
  undefined subclass "ndiMatrix" of class "replValueSp"; definition not updated
>  tidy_scotus %>%
+ count(case_name, word) %>%
+ cast_dfm(case_name, word, n)
Document-feature matrix of: 9,642 documents, 167,852 features (99.49% sparse) and 0 docvars.
                                                                                  features
docs                                                                                1
  149 Madison Ave. Corp. v. Asselta                                                 4
  2,606.84 Acres of Land in Tarrant County, Texas, and Frank Corn v. United States  2
  4,885 Bags of Linseed                                                             8
  44 Liquormart, Inc. v. Rhode Island                                              18
  62 Cases of Jam v. United States                                                  1
  A. & P. TEA CO. v. Supermarket Corp.                                              4
                                                                                  features
docs                                                                               1.40
  149 Madison Ave. Corp. v. Asselta                                                   1
  2,606.84 Acres of Land in Tarrant County, Texas, and Frank Corn v. United States    0
  4,885 Bags of Linseed                                                               0
  44 Liquormart, Inc. v. Rhode Island                                                 0
  62 Cases of Jam v. United States                                                    0
  A. & P. TEA CO. v. Supermarket Corp.                                                0
                                                                                  features
docs                                                                               10
  149 Madison Ave. Corp. v. Asselta                                                 3
  2,606.84 Acres of Land in Tarrant County, Texas, and Frank Corn v. United States  0
  4,885 Bags of Linseed                                                             0
  44 Liquormart, Inc. v. Rhode Island                                               5
  62 Cases of Jam v. United States                                                  0
  A. & P. TEA CO. v. Supermarket Corp.                                              1
                                                                                  features
docs                                                                               1056
  149 Madison Ave. Corp. v. Asselta                                                   1
  2,606.84 Acres of Land in Tarrant County, Texas, and Frank Corn v. United States    0
  4,885 Bags of Linseed                                                               0
  44 Liquormart, Inc. v. Rhode Island                                                 0
  62 Cases of Jam v. United States                                                    0
  A. & P. TEA CO. v. Supermarket Corp.                                                0
                                                                                  features
docs                                                                               1060
  149 Madison Ave. Corp. v. Asselta                                                   1
  2,606.84 Acres of Land in Tarrant County, Texas, and Frank Corn v. United States    0
  4,885 Bags of Linseed                                                               0
  44 Liquormart, Inc. v. Rhode Island                                                 0
  62 Cases of Jam v. United States                                                    0
  A. & P. TEA CO. v. Supermarket Corp.                                                0
                                                                                  features
docs                                                                               11
  149 Madison Ave. Corp. v. Asselta                                                 2
  2,606.84 Acres of Land in Tarrant County, Texas, and Frank Corn v. United States  0
  4,885 Bags of Linseed                                                             0
  44 Liquormart, Inc. v. Rhode Island                                               3
  62 Cases of Jam v. United States                                                  1
  A. & P. TEA CO. v. Supermarket Corp.                                              4
                                                                                  features
docs                                                                               1223
  149 Madison Ave. Corp. v. Asselta                                                   1
  2,606.84 Acres of Land in Tarrant County, Texas, and Frank Corn v. United States    0
  4,885 Bags of Linseed                                                               0
  44 Liquormart, Inc. v. Rhode Island                                                 0
  62 Cases of Jam v. United States                                                    0
  A. & P. TEA CO. v. Supermarket Corp.                                                0
                                                                                  features
docs                                                                               1242
  149 Madison Ave. Corp. v. Asselta                                                   1
  2,606.84 Acres of Land in Tarrant County, Texas, and Frank Corn v. United States    0
  4,885 Bags of Linseed                                                               0
  44 Liquormart, Inc. v. Rhode Island                                                 0
  62 Cases of Jam v. United States                                                    0
  A. & P. TEA CO. v. Supermarket Corp.                                                0
                                                                                  features
docs                                                                               1244
  149 Madison Ave. Corp. v. Asselta                                                   1
  2,606.84 Acres of Land in Tarrant County, Texas, and Frank Corn v. United States    0
  4,885 Bags of Linseed                                                               0
  44 Liquormart, Inc. v. Rhode Island                                                 0
  62 Cases of Jam v. United States                                                    0
  A. & P. TEA CO. v. Supermarket Corp.                                                0
                                                                                  features
docs                                                                               1246
  149 Madison Ave. Corp. v. Asselta                                                   1
  2,606.84 Acres of Land in Tarrant County, Texas, and Frank Corn v. United States    0
  4,885 Bags of Linseed                                                               0
  44 Liquormart, Inc. v. Rhode Island                                                 0
  62 Cases of Jam v. United States                                                    0
  A. & P. TEA CO. v. Supermarket Corp.                                                0
[ reached max_ndoc ... 9,636 more documents, reached max_nfeat ... 167,842 more features ]
> # Aplicando steamming
>  tidy_scotus %>%
+ mutate(stem = wordStem(word)) %>%
+ count(case_name, stem) %>%
+ cast_dfm(case_name, stem, n)
Document-feature matrix of: 9,642 documents, 135,543 features (99.48% sparse) and 0 docvars.
                                                                                  features
docs                                                                                1 1.40 10 1056 1060
  149 Madison Ave. Corp. v. Asselta                                                 4    1  3    1    1
  2,606.84 Acres of Land in Tarrant County, Texas, and Frank Corn v. United States  2    0  0    0    0
  4,885 Bags of Linseed                                                             8    0  0    0    0
  44 Liquormart, Inc. v. Rhode Island                                              18    0  5    0    0
  62 Cases of Jam v. United States                                                  1    0  0    0    0
  A. & P. TEA CO. v. Supermarket Corp.                                              4    0  1    0    0
                                                                                  features
docs                                                                               11 1223 1242 1244
  149 Madison Ave. Corp. v. Asselta                                                 2    1    1    1
  2,606.84 Acres of Land in Tarrant County, Texas, and Frank Corn v. United States  0    0    0    0
  4,885 Bags of Linseed                                                             0    0    0    0
  44 Liquormart, Inc. v. Rhode Island                                               3    0    0    0
  62 Cases of Jam v. United States                                                  1    0    0    0
  A. & P. TEA CO. v. Supermarket Corp.                                              4    0    0    0
                                                                                  features
docs                                                                               1246
  149 Madison Ave. Corp. v. Asselta                                                   1
  2,606.84 Acres of Land in Tarrant County, Texas, and Frank Corn v. United States    0
  4,885 Bags of Linseed                                                               0
  44 Liquormart, Inc. v. Rhode Island                                                 0
  62 Cases of Jam v. United States                                                    0
  A. & P. TEA CO. v. Supermarket Corp.                                                0
[ reached max_ndoc ... 9,636 more documents, reached max_nfeat ... 135,533 more features ]
> # Manejo de la puntuacon al realizar stemming
> tidy_fir_tree %>%
+ count(word, sort = TRUE) %>%
+ filter(str_detect(word, "^tree"))
# A tibble: 3 × 2
  word       n
  <chr>  <int>
1 tree      76
2 trees     12
3 tree's     1
> fir_tree_counts <- fir_tree %>%
+ unnest_tokens(word, text, token = "regex", pattern = "\\s+|[[:punct:]]+") %>%
+ anti_join(get_stopwords()) %>%
+ mutate(stem = wordStem(word)) %>%
+ mutate(stem = wordStem(word)) %>%
+ count(stem, sort = TRUE)
Joining with `by = join_by(word)`
> fir_tree_counts
# A tibble: 572 × 2
   stem        n
   <chr>   <int>
 1 tree       89
 2 fir        34
 3 littl      23
 4 said       22
 5 stori      16
 6 thought    16
 7 branch     15
 8 on         15
 9 came       14
10 know       14
# ℹ 562 more rows
# ℹ Use `print(n = ...)` to see more rows
> fir_tree_counts %>%
+ filter(str_detect(stem, "^tree"))
# A tibble: 1 × 2
  stem      n
  <chr> <int>
1 tree     89
> # Comparar algunas opciones de stemming
> 
> stemming <- tidy_fir_tree %>%
+ select(-book, -language) %>%
+ mutate(`Remove S` = str_remove(word, "s$"),
+ `Plural endings` = case_when(str_detect(word, "[^e|aies$]ies$") ~
+ str_replace(word, "ies$", "y"),
+ str_detect(word, "[^e|a|oes$]es$") ~
+ str_replace(word, "es$", "e"),
+ str_detect(word, "[^ss$|us$]s$") ~
+ str_remove(word, "s$"),
+ TRUE ~ word),
+ `Porter stemming` = wordStem(word)) %>%
+ rename(`Original word` = word)
> 
> stemming %>%
+ gather(Type, Result, `Remove S`:`Porter stemming`) %>%
+ mutate(Type = fct_inorder(Type)) %>%
+ count(Type, Result) %>%
+ group_by(Type) %>%
+ top_n(20, n) %>%
+ ungroup %>%
+ ggplot(aes(fct_reorder(Result, n),
+ n, fill = Type)) +
+ geom_col(show.legend = FALSE) +
+ facet_wrap(~Type, scales = "free_y") +
+ pe, scales = "free_y") +
Error: inesperado ',' in:
"facet_wrap(~Type, scales = "free_y") +
pe,"
>  stemming %>%
+ gather(Type, Result, `Remove S`:`Porter stemming`) %>%
+ mutate(Type = fct_inorder(Type)) %>%
+ count(Type, Result) %>%
+ group_by(Type) %>%
+ top_n(20, n) %>%
+ ungroup %>%
+ ggplot(aes(fct_reorder(Result, n),
+ n, fill = Type)) +
+ geom_col(show.legend = FALSE) +
+ facet_wrap(~Type, scales = "free_y") +
+ pe, scales = "free_y") +
Error: inesperado ',' in:
"facet_wrap(~Type, scales = "free_y") +
pe,"
>  stemming %>%
+ gather(Type, Result, `Remove S`:`Porter stemming`) %>%
+ mutate(Type = fct_inorder(Type)) %>%
+ count(Type, Result) %>%
+ group_by(Type) %>%
+ top_n(20, n) %>%
+ ungroup %>%
+ ggplot(aes(fct_reorder(Result, n),
+ n, fill = Type)) +
+ geom_col(show.legend = FALSE) +
+ facet_wrap(~Type, scales = "free_y") +
+ coord_flip() +
+ labs(x=NULL, y="Frequency")
> 
>  stemming %>%
+ filter(`Remove S` != `Plural endings`) %>%
+ distinct(`Remove S`, `Plural endings`, .keep_all = TRUE)
# A tibble: 13 × 4
   `Original word` `Remove S`  `Plural endings` `Porter stemming`
   <chr>           <chr>       <chr>            <chr>            
 1 raspberries     raspberrie  raspberry        raspberri        
 2 strawberries    strawberrie strawberry       strawberri       
 3 less            les         less             less             
 4 us              u           us               u                
 5 brightness      brightnes   brightness       bright           
 6 conscious       consciou    conscious        consciou         
 7 faintness       faintnes    faintness        faint            
 8 happiness       happines    happiness        happi            
 9 ladies          ladie       lady             ladi             
10 babies          babie       baby             babi             
11 anxious         anxiou      anxious          anxiou           
12 princess        princes     princess         princess         
13 stories         storie      story            stori            
> 
>  stemming %>%
+ gather(Type, Result, `Remove S` : `Porter stemming`) %>%
+ filter(Result %in% c("come", "coming")) %>%
+ distinct(`Original word`, Type, Result)
# A tibble: 9 × 3
  `Original word` Type            Result
  <chr>           <chr>           <chr> 
1 come            Remove S        come  
2 comes           Remove S        come  
3 coming          Remove S        coming
4 come            Plural endings  come  
5 comes           Plural endings  come  
6 coming          Plural endings  coming
7 come            Porter stemming come  
8 comes           Porter stemming come  
9 coming          Porter stemming come  
> 
