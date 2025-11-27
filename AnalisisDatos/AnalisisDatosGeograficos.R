
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

> getwd()
[1] "C:/Users/DELL/Documents"
> setwd("C://Users/DELL/Documents/SERVICIO_SOCIAL/EjemplosEjercicios/EjerciciosR/AnalisisDatos")
> getwd()
[1] "C:/Users/DELL/Documents/SERVICIO_SOCIAL/EjemplosEjercicios/EjerciciosR/AnalisisDatos"
> accidents<-read_csv("inViales_2022_2024.csv")
Error in read_csv("inViales_2022_2024.csv") : 
  no se pudo encontrar la función "read_csv"
> library(readr)
> accidents<-read_csv("inViales_2022_2024.csv")
[1mindexing[0m [34minViales_2022_2024.csv[0m [======---------------------] [32m2.15GB/s[0m, eta: [36m 0s[0m[1mindexing[0m [34minViales_2022_2024.csv[0m [=========================] [32m939.36MB/s[0m, eta: [36m 0s[0m                                                                                                                   Rows: 504261 Columns: 17
── Column specification ────────────────────────────────────────────────────────
Delimiter: ","
chr  (11): folio, dia_semana, tipo_incidente_c4, incidente_c4, alcaldia_inic...
dbl   (2): longitud, latitud
date  (2): fecha_creacion, fecha_cierre
time  (2): hora_creacion, hora_cierre

ℹ Use `spec()` to retrieve the full column specification for this data.
ℹ Specify the column types or set `show_col_types = FALSE` to quiet this message.
> View(accidents)
> str(accidents)
spc_tbl_ [504,261 × 17] (S3: spec_tbl_df/tbl_df/tbl/data.frame)
 $ folio            : chr [1:504261] "C2C/20211229/00212" "C2C/20211231/00183" "C2C/20220101/00012" "C2C/20220101/00070" ...
 $ fecha_creacion   : Date[1:504261], format: "2021-12-29" "2021-12-31" ...
 $ hora_creacion    : 'hms' num [1:504261] 23:21:20 23:48:03 01:06:39 09:51:53 ...
  ..- attr(*, "units")= chr "secs"
 $ dia_semana       : chr [1:504261] "Miércoles" "Viernes" "Sábado" "Sábado" ...
 $ fecha_cierre     : Date[1:504261], format: "2022-01-01" "2022-01-01" ...
 $ hora_cierre      : 'hms' num [1:504261] 00:24:06 06:29:52 06:00:12 12:54:10 ...
  ..- attr(*, "units")= chr "secs"
 $ tipo_incidente_c4: chr [1:504261] "Lesionado" "Lesionado" "Accidente" "Accidente" ...
 $ incidente_c4     : chr [1:504261] "Atropellado" "Atropellado" "Choque con lesionados" "Motociclista" ...
 $ alcaldia_inicio  : chr [1:504261] NA "CUAUHTEMOC" "CUAUHTEMOC" "CUAUHTEMOC" ...
 $ codigo_cierre    : chr [1:504261] "I" "A" "A" "A" ...
 $ clas_con_f_alarma: chr [1:504261] "URGENCIAS MEDICAS" "URGENCIAS MEDICAS" "URGENCIAS MEDICAS" "URGENCIAS MEDICAS" ...
 $ tipo_entrada     : chr [1:504261] "BOTÓN DE AUXILIO" "BOTÓN DE AUXILIO" "BOTÓN DE AUXILIO" "RADIO" ...
 $ alcaldia_cierre  : chr [1:504261] NA "CUAUHTEMOC" "CUAUHTEMOC" "CUAUHTEMOC" ...
 $ alcaldia_catalogo: chr [1:504261] "Cuauhtémoc" "Cuauhtémoc" "Cuauhtémoc" "Miguel Hidalgo" ...
 $ colonia_catalogo : chr [1:504261] "Roma Norte" "Obrera" "Doctores" "Tlaxpana" ...
 $ longitud         : num [1:504261] -99.2 -99.1 -99.1 -99.2 -99.1 ...
 $ latitud          : num [1:504261] 19.4 19.4 19.4 19.4 19.4 ...
 - attr(*, "spec")=
  .. cols(
  ..   folio = col_character(),
  ..   fecha_creacion = col_date(format = ""),
  ..   hora_creacion = col_time(format = ""),
  ..   dia_semana = col_character(),
  ..   fecha_cierre = col_date(format = ""),
  ..   hora_cierre = col_time(format = ""),
  ..   tipo_incidente_c4 = col_character(),
  ..   incidente_c4 = col_character(),
  ..   alcaldia_inicio = col_character(),
  ..   codigo_cierre = col_character(),
  ..   clas_con_f_alarma = col_character(),
  ..   tipo_entrada = col_character(),
  ..   alcaldia_cierre = col_character(),
  ..   alcaldia_catalogo = col_character(),
  ..   colonia_catalogo = col_character(),
  ..   longitud = col_double(),
  ..   latitud = col_double()
  .. )
 - attr(*, "problems")=<externalptr> 
> install.packages("leaflet")
Installing package into ‘C:/Users/DELL/AppData/Local/R/win-library/4.3’
(as ‘lib’ is unspecified)
--- Please select a CRAN mirror for use in this session ---
also installing the dependencies ‘terra’, ‘leaflet.providers’, ‘raster’


  There are binary versions available but the source versions are later:
        binary source needs_compilation
terra   1.8-29 1.8-80              TRUE
leaflet  2.2.2  2.2.3             FALSE

  Binaries will be installed
probando la URL 'https://cloud.r-project.org/bin/windows/contrib/4.3/terra_1.8-29.zip'
Content type 'application/zip' length 40018618 bytes (38.2 MB)
downloaded 38.2 MB

probando la URL 'https://cloud.r-project.org/bin/windows/contrib/4.3/leaflet.providers_2.0.0.zip'
Content type 'application/zip' length 44861 bytes (43 KB)
downloaded 43 KB

probando la URL 'https://cloud.r-project.org/bin/windows/contrib/4.3/raster_3.6-32.zip'
Content type 'application/zip' length 3703488 bytes (3.5 MB)
downloaded 3.5 MB

package ‘terra’ successfully unpacked and MD5 sums checked
package ‘leaflet.providers’ successfully unpacked and MD5 sums checked
package ‘raster’ successfully unpacked and MD5 sums checked

The downloaded binary packages are in
        C:\Users\DELL\AppData\Local\Temp\RtmpcnDWqE\downloaded_packages
installing the source package ‘leaflet’

probando la URL 'https://cloud.r-project.org/src/contrib/leaflet_2.2.3.tar.gz'
Content type 'application/x-gzip' length 2013248 bytes (1.9 MB)
downloaded 1.9 MB

* installing *source* package 'leaflet' ...
** package 'leaflet' successfully unpacked and MD5 sums checked
** using staged installation
** R
** data
*** moving datasets to lazyload DB
** inst
** byte-compile and prepare package for lazy loading
** help
*** installing help indices
** building package indices
** testing if installed package can be loaded from temporary location
** testing if installed package can be loaded from final location
** testing if installed package keeps a record of temporary installation path
* DONE (leaflet)

The downloaded source packages are in
        ‘C:\Users\DELL\AppData\Local\Temp\RtmpcnDWqE\downloaded_packages’
> install.packages("leaflet.extras")
Installing package into ‘C:/Users/DELL/AppData/Local/R/win-library/4.3’
(as ‘lib’ is unspecified)
probando la URL 'https://cloud.r-project.org/bin/windows/contrib/4.3/leaflet.extras_2.0.1.zip'
Content type 'application/zip' length 1613204 bytes (1.5 MB)
downloaded 1.5 MB

package ‘leaflet.extras’ successfully unpacked and MD5 sums checked

The downloaded binary packages are in
        C:\Users\DELL\AppData\Local\Temp\RtmpcnDWqE\downloaded_packages
> library(leaflet)
> library(leaflet.extras)
Warning message:
package ‘leaflet.extras’ was built under R version 4.3.3 
> library(tidyverse)
── Attaching core tidyverse packages ──────────────────────── tidyverse 2.0.0 ──
✔ dplyr     1.1.4     ✔ purrr     1.0.2
✔ forcats   1.0.0     ✔ stringr   1.5.1
✔ ggplot2   3.4.4     ✔ tibble    3.2.1
✔ lubridate 1.9.4     ✔ tidyr     1.3.1
── Conflicts ────────────────────────────────────────── tidyverse_conflicts() ──
✖ dplyr::filter() masks stats::filter()
✖ dplyr::lag()    masks stats::lag()
ℹ Use the conflicted package (<http://conflicted.r-lib.org/>) to force all conflicts to become errors
Warning message:
package ‘lubridate’ was built under R version 4.3.3 
> accidents_clean<- accidents %>%
+ filter(!is.na(latitud) & !is.na(longitud)) %>% # Quitar filas sin coordenadas
+ mutate(
+ latitud = as.numeric(latitud),
+ longitud = as.numeric(longitud)
+ )
> set.seed(123)
> datos_muestra <- sample_n(datos_limpios, 2000)
Error: objeto 'datos_limpios' no encontrado
> datos_muestra <- sample_n(accidents_clean, 2000)
> mapa <- leaflet(datos_muestra) %>%
+ addTiles() %>%
+ setView(lng = -98.2063, lat = 19.0414, zoom = 12) %>%
+ addHeatmap(
+ lng = ~longitud,
+ lat = ~latitud,
+ intensity = ~1,
+ blur = 20,
+ max = 0.05,
+ radius = 15
+ )
> mapa
> install.packages("htmlwidgets")
Installing package into ‘C:/Users/DELL/AppData/Local/R/win-library/4.3’
(as ‘lib’ is unspecified)
probando la URL 'https://cloud.r-project.org/bin/windows/contrib/4.3/htmlwidgets_1.6.4.zip'
Content type 'application/zip' length 812967 bytes (793 KB)
downloaded 793 KB

package ‘htmlwidgets’ successfully unpacked and MD5 sums checked

The downloaded binary packages are in
        C:\Users\DELL\AppData\Local\Temp\RtmpcnDWqE\downloaded_packages
> library(htmlwidgets)
Warning message:
package ‘htmlwidgets’ was built under R version 4.3.3 
> saveWidget(mapa, file = "mapa_calor.html")
Error in pandoc_self_contained_html(file, file) : 
  Saving a widget with selfcontained = TRUE requires pandoc. See here to learn more https://bookdown.org/yihui/rmarkdown-cookbook/install-pandoc.html
> 
