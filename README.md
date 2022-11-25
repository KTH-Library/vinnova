
<!-- README.md is generated from README.Rmd. Please edit that file -->

# vinnova

<!-- badges: start -->

[![Lifecycle:
experimental](https://img.shields.io/badge/lifecycle-experimental-orange.svg)](https://lifecycle.r-lib.org/articles/stages.html#experimental)
[![R-CMD-check](https://github.com/KTH-Library/vinnova/actions/workflows/R-CMD-check.yaml/badge.svg)](https://github.com/KTH-Library/vinnova/actions/workflows/R-CMD-check.yaml)
<!-- badges: end -->

The goal of the R-package `vinnova` is to provide access to open data
from [Vinnova - Sweden’s Innovation
Agency](https://www.vinnova.se/en/about-us).

The open data APIs from Vinnova covers data about programmes, calls for
proposals and application rounds as well as projects that have been
funded. The APIs are documented at <https://data.vinnova.se/api/> and
this R package uses the open APIs at Vinnova to make data available for
use from R, primarily in tabular formats .

## Installation

You can install the development version of vinnova from
[GitHub](https://github.com/) with:

``` r
# install.packages("devtools")
devtools::install_github("KTH-Library/vinnova")
```

## Example

Basic examples which shows you how to get data.

Fetching “projects” data:

    #> 
    #> Attaching package: 'dplyr'
    #> The following objects are masked from 'package:stats':
    #> 
    #>     filter, lag
    #> The following objects are masked from 'package:base':
    #> 
    #>     intersect, setdiff, setequal, union
    #> [1] 598
    #>  [1] "Diarienummer"                 "Ärenderubrik"                
    #>  [3] "ÄrenderubrikEngelska"         "DiarienummerAnsokningsomgang"
    #>  [5] "DiarienummerUtlysning"        "DiarienummerProgram"         
    #>  [7] "MalSvenska"                   "ResultatSvenska"             
    #>  [9] "ImplementationSvenska"        "MalEngelska"                 
    #> [11] "ResultatEngelska"             "ImplementationEngelska"      
    #> [13] "Projektreferat"               "BeviljatBidrag"              
    #> [15] "ProjektStart"                 "ProjektSlut"                 
    #> [17] "KoordinatorOrg"               "KoordinatorArb"              
    #> [19] "LankLista"                    "Status"

| Diarienummer | Ärenderubrik                                                                                                                |
|:-------------|:----------------------------------------------------------------------------------------------------------------------------|
| 2016-02752   | Innovationstorg, Mötesplats välfärdsteknologi och e-hälsa                                                                   |
| 2016-04632   | Hållbar Konsumtion och Beteendefinans                                                                                       |
| 2017-03503   | E!11654, ENEFRF, Energy Efficient PET Cancer Diagnostics: Novel RF Source for Radioisotope Production, ComHeat Microwave AB |

More context can be retrieved as related tables:

``` r

vinnova_latest(from_date = Sys.Date())
#> $calls
#> # A tibble: 6 × 12
#>   Diarie…¹ Diari…² Titel Beskr…³ Titel…⁴ Beskr…⁵ Publi…⁶ Dokum…⁷ LankL…⁸ Ansok…⁹
#>   <chr>    <chr>   <chr> <chr>   <chr>   <chr>   <chr>   <list>  <list>  <list> 
#> 1 2017-02… 2014-0… "Nat… "Natio… x       x       2022-1… <df>    <list>  <df>   
#> 2 2018-02… 2014-0… "Int… "Inter… x       x       2021-0… <df>    <list>  <df>   
#> 3 2018-02… 2014-0… "Inn… "Innov… x       x       2022-1… <df>    <list>  <df>   
#> 4 2019-01… 2019-0… "AI … "AI - … AI - A… AI - A… 2022-1… <df>    <list>  <df>   
#> 5 2021-03… 2019-0… "Inn… "Innov… xx      xx      2022-1… <df>    <list>  <df>   
#> 6 2021-03… 2019-0… "AI … "AI - … AI - S… AI - S… 2022-0… <df>    <list>  <df>   
#> # … with 2 more variables: KontaktLista <list>, Publik <int>, and abbreviated
#> #   variable names ¹​Diarienummer, ²​DiarienummerProgram, ³​Beskrivning,
#> #   ⁴​TitelEngelska, ⁵​BeskrivningEngelska, ⁶​Publiceringsdatum, ⁷​DokumentLista,
#> #   ⁸​LankLista, ⁹​AnsokningsomgangDnrLista
#> 
#> $calls_tbls
#> $calls_tbls$contacts
#> # A tibble: 4 × 6
#>   Diarienummer Namn             Telefon       Epost                Roll  Konta…¹
#>   <chr>        <chr>            <chr>         <chr>                <chr>   <int>
#> 1 2017-02932   Lena Dalsmyr     08-473 31 61  lena.dalsmyr@vinnov… Admi…  1.24e7
#> 2 2017-02932   Anders Blom      08-555 031 60 anders.blom@innovai… Inri…  1.24e7
#> 3 2017-02932   Mats-Olof Olsson 08-782 48 84  mats-olof.olsson@fm… Inri…  1.24e7
#> 4 2017-02932   Sanna Edlund     08-473 31 63  sanna.edlund@vinnov… Utly…  1.28e7
#> # … with abbreviated variable name ¹​KontaktID
#> 
#> $calls_tbls$links
#> # A tibble: 0 × 1
#> # … with 1 variable: Diarienummer <chr>
#> 
#> $calls_tbls$documents
#> # A tibble: 1 × 8
#>   Diarienummer Titel               Beskr…¹ FileN…² Dokum…³ fileURL Lang  Primary
#>   <chr>        <chr>               <chr>   <chr>   <chr>   <chr>   <chr> <lgl>  
#> 1 2017-02932   Fastställt beslut … Fastst… Fastst… 2017-0… https:… Sv    FALSE  
#> # … with abbreviated variable names ¹​Beskrivning, ²​FileName, ³​DokumentID
#> 
#> $calls_tbls$round_ids
#> # A tibble: 25 × 2
#>    Diarienummer DiarienummerAnsokningsomgang
#>    <chr>        <chr>                       
#>  1 2017-02932   2017-02942                  
#>  2 2017-02932   2018-05355                  
#>  3 2018-02052   2018-03110                  
#>  4 2018-02052   2018-05351                  
#>  5 2018-02052   2020-00225                  
#>  6 2018-02053   2018-02054                  
#>  7 2018-02053   2018-04397                  
#>  8 2018-02053   2018-05372                  
#>  9 2018-02053   2019-05248                  
#> 10 2018-02053   2020-00352                  
#> # … with 15 more rows
#> 
#> 
#> $programmes
#> # A tibble: 12 × 6
#>    Diarienummer Titel                            Beskr…¹ Titel…² Beskr…³ Utlys…⁴
#>    <chr>        <chr>                            <chr>   <chr>   <chr>   <list> 
#>  1 2009-02191   Genus och mångfald för innovati… "Tidig… Gender… "Gende… <df>   
#>  2 2012-00741   Test och experimenterande        "Progr… Test a… "The p… <df>   
#>  3 2013-01243   Innovationsledning och organise… "VINNO… Innova… "Withi… <df>   
#>  4 2014-04016   SIP - Innovair                   "SIO s… SIP - … "SIP -… <df>   
#>  5 2015-02453   Innovationsforskning             "Innov… Innova… "Innov… <df>   
#>  6 2015-03143   Kompetenscentrumprogrammet       "Kompe… Compet… "Compe… <df>   
#>  7 2016-02206   Next generation Biologics        "Reger… Next g… "Vinno… <df>   
#>  8 2016-03566   Innovationshubbar                "Innov… Innova… "Innov… <df>   
#>  9 2019-01294   Innovationsplattformar           "Innov… x       "x"     <df>   
#> 10 2021-00999   Hållbar precisionshälsa i samve… "Hållb… Sustai… "Susta… <df>   
#> 11 2021-01085   Enskilda ansökningar inom preci… "Enski… Indivi… "Indiv… <df>   
#> 12 2021-01086   Internationella samarbeten för … "Inter… Intern… "Inter… <df>   
#> # … with abbreviated variable names ¹​Beskrivning, ²​TitelEngelska,
#> #   ³​BeskrivningEngelska, ⁴​UtlysningDnrLista
#> 
#> $programmes_tbls
#> $programmes_tbls$call_ids
#> # A tibble: 84 × 2
#>    Diarienummer DiarienummerUtlysning
#>    <chr>        <chr>                
#>  1 2009-02191   2004-03144           
#>  2 2009-02191   2007-01574           
#>  3 2009-02191   2008-00400           
#>  4 2009-02191   2009-02405           
#>  5 2009-02191   2010-01385           
#>  6 2009-02191   2013-01962           
#>  7 2009-02191   2014-01280           
#>  8 2009-02191   2014-06304           
#>  9 2009-02191   2018-04520           
#> 10 2012-00741   2012-00911           
#> # … with 74 more rows
#> 
#> 
#> $rounds
#> # A tibble: 6 × 23
#>   Diarie…¹ Diari…² Titel Beskr…³ Titel…⁴ Beskr…⁵ Oppni…⁶ Stang…⁷ Dagli…⁸ Avlas…⁹
#>   <chr>    <chr>   <chr> <chr>   <chr>   <chr>   <chr>   <chr>     <int> <list> 
#> 1 2017-02… 2017-0… Nati… "Natio… x       x       2017-0… 2017-0…       0 <list> 
#> 2 2018-05… 2017-0… Fors… "Är du… Resear… Are yo… 2019-0… 2019-0…       0 <list> 
#> 3 2019-05… 2018-0… Tysk… "Tyskl… German… German… 2019-1… 2019-1…       1 <list> 
#> 4 2020-00… 2018-0… Sama… "I det… Collab… In thi… 2020-0… 2020-0…       0 <list> 
#> 5 2021-03… 2021-0… Inno… "Innov… xx      xx      2021-0… 2021-1…       1 <list> 
#> 6 2022-00… 2021-0… Kart… "Kartl… Mappin… Mappin… 2022-0… 2022-0…       1 <list> 
#> # … with 13 more variables: UppskattatBeslutsdatum <chr>,
#> #   TidigastProjektstart <chr>, SenastProjektstart <lgl>,
#> #   SenastProjektslut <chr>, DokumentLista <list>, LankLista <list>,
#> #   KontaktLista <list>, Publik <int>, Webbsida <int>,
#> #   AnnonseringslägeÅr <lgl>, AnnonseringslägePeriod <lgl>, Extern <int>,
#> #   WebTextLista <list>, and abbreviated variable names ¹​Diarienummer,
#> #   ²​DiarienummerUtlysning, ³​Beskrivning, ⁴​TitelEngelska, …
#> 
#> $rounds_tbls
#> $rounds_tbls$contacts
#> # A tibble: 2 × 6
#>   Diarienummer Namn           Telefon       Epost                  Roll  Konta…¹
#>   <chr>        <chr>          <chr>         <chr>                  <chr>   <int>
#> 1 2020-00225   Sanna Edlund   " 4684733163" sanna.edlund@vinnova.… Prog…  1.32e7
#> 2 2020-00225   Peter Lindberg " 4684733193" peter.lindberg@vinnov… EURE…  1.32e7
#> # … with abbreviated variable name ¹​KontaktID
#> 
#> $rounds_tbls$links
#> # A tibble: 3 × 3
#>   Diarienummer Beskrivning URL                                                  
#>   <chr>        <chr>       <chr>                                                
#> 1 2017-02942   Ansök här   https://portal.vinnova.se/DynFormNet/CreateForm.aspx…
#> 2 2018-05355   Ansök här   https://portal.vinnova.se/DynFormNet/CreateForm.aspx…
#> 3 2020-00225   Ansök här   https://portal.vinnova.se/DynFormNet/CreateForm.aspx…
#> 
#> $rounds_tbls$documents
#> # A tibble: 14 × 8
#>    Diarienummer Titel              Beskr…¹ FileN…² Dokum…³ fileURL Lang  Primary
#>    <chr>        <chr>              <chr>   <chr>   <chr>   <chr>   <chr> <lgl>  
#>  1 2017-02942   "CLUSTER DESCRIPT… "CLUST… Cluste… 2017-0… https:… Sv    FALSE  
#>  2 2017-02942   "CV attachment - … "CV at… CV att… 2017-0… https:… Sv    FALSE  
#>  3 2017-02942   "Nationella Flygt… "Natio… Utlysn… 2017-0… https:… Sv    FALSE  
#>  4 2017-02942   "Projektbeskrivni… "Proje… Projek… 2017-0… https:… Sv    FALSE  
#>  5 2017-02942   "CV-mall"          "CV-ma… Mall f… 2017-0… https:… Sv    FALSE  
#>  6 2017-02942   "Klusterbeskrivni… "Klust… Kluste… 2017-0… https:… Sv    FALSE  
#>  7 2017-02942   "PROJECT DESCRIPT… "PROJE… Projec… 2017-0… https:… Sv    FALSE  
#>  8 2018-05355   "Projektbeskrivni… "Proje… Projek… 2018-0… https:… Sv    FALSE  
#>  9 2018-05355   "CV-mall - nation… "CV-ma… mall-f… 2018-0… https:… Sv    FALSE  
#> 10 2018-05355   "Andra utlysninge… "Andra… NFFP 7… 2018-0… https:… Sv    FALSE  
#> 11 2020-00225   "Eureka projectfo… "Eurek… Eureka… 2020-0… https:… En    FALSE  
#> 12 2020-00225   "UK-Sweden Call f… "UK-Sw… UK-Swe… 2020-0… https:… En    FALSE  
#> 13 2020-00225   "UK-Sweden Call f… "UK-Sw… UK-Swe… 2020-0… https:… En    TRUE   
#> 14 2020-00225   "Samarbetsprojekt… "Samar… UK-Swe… 2020-0… https:… Sv    TRUE   
#> # … with abbreviated variable names ¹​Beskrivning, ²​FileName, ³​DokumentID
#> 
#> $rounds_tbls$readings
#> # A tibble: 0 × 1
#> # … with 1 variable: Diarienummer <chr>
#> 
#> 
#> $projects
#> # A tibble: 120 × 20
#>    Diarienummer Ärende…¹ Ärend…² Diari…³ Diari…⁴ Diari…⁵ MalSv…⁶ Resul…⁷ Imple…⁸
#>    <chr>        <chr>    <chr>   <chr>   <chr>   <chr>   <chr>   <chr>   <chr>  
#>  1 2017-03503   E!11654… E!1165… 2016-0… 2014-0… 2009-0… "Syfte… "Proje… "Delta…
#>  2 2017-04846   SUDDEN-… SUDDEN… 2017-0… 2017-0… 2014-0… "Syfte… "Flygi… "Uppla…
#>  3 2017-04864   Passiv … Passiv… 2017-0… 2017-0… 2014-0… "Proje… "Proje… "Proje…
#>  4 2017-04884   Självfö… Self-E… 2017-0… 2017-0… 2014-0… "Målet… "Proje… "Själv…
#>  5 2017-04890   Koncept… Early … 2017-0… 2017-0… 2014-0… "Framt… "Proje… "Proje…
#>  6 2018-02228   EUREKA … EUREKA… 2017-0… 2016-0… 2016-0… "En me… "Det s… "Proje…
#>  7 2018-03119   E!12257… Modula… 2017-0… 2014-0… 2009-0… "Syfte… "Vi fö… "Upplä…
#>  8 2019-00838   Odlande… Farmin… 2017-0… 2013-0… 2011-0… "Ett p… "Odlan… "Proje…
#>  9 2019-02088   Antenns… Antenn… 2018-0… 2014-0… 2014-0… "Proje… "Två a… "Proje…
#> 10 2019-02383   Eureka … Eureka… 2019-0… 2016-0… 2016-0… "IVVES… "IVVES… "IVVES…
#> # … with 110 more rows, 11 more variables: MalEngelska <chr>,
#> #   ResultatEngelska <chr>, ImplementationEngelska <chr>, Projektreferat <chr>,
#> #   BeviljatBidrag <int>, ProjektStart <chr>, ProjektSlut <chr>,
#> #   KoordinatorOrg <chr>, KoordinatorArb <chr>, LankLista <list>, Status <chr>,
#> #   and abbreviated variable names ¹​Ärenderubrik, ²​ÄrenderubrikEngelska,
#> #   ³​DiarienummerAnsokningsomgang, ⁴​DiarienummerUtlysning,
#> #   ⁵​DiarienummerProgram, ⁶​MalSvenska, ⁷​ResultatSvenska, …
#> 
#> $projects_tbls
#> $projects_tbls$links
#> # A tibble: 133 × 3
#>    Diarienummer Beskrivning                                                URL  
#>    <chr>        <chr>                                                      <chr>
#>  1 2017-03503   ""                                                         "htt…
#>  2 2017-04846   ""                                                         ""   
#>  3 2017-04864   ""                                                         ""   
#>  4 2017-04884   ""                                                         ""   
#>  5 2017-04890   ""                                                         ""   
#>  6 2018-02228   "ForSyDe and IDeSyDe -- Tools developed during the projec… "htt…
#>  7 2018-02228   "Eclipse APP4MC -- Tool developed during the project"      "htt…
#>  8 2018-02228   "Panorama Project Main Webpage"                            "htt…
#>  9 2018-02228   "Eclipse Capra -- Tool developed during the project"       "htt…
#> 10 2018-03119   ""                                                         ""   
#> # … with 123 more rows
```

Files can be retrieved:

``` r

# files from Vinnova
filez <- vinnova_files()

# number of rows
nrow(filez)
#> [1] 58

# field names
names(filez)
#> [1] "file"         "Diarienummer" "Titel"        "Beskrivning"  "FileName"    
#> [6] "DokumentID"   "fileURL"      "Lang"         "Primary"

# display result - first few rows... (which could be inserted into a database table)
filez %>% slice(1:5) %>% select("Titel", 1:2, "fileURL") %>% knitr::kable()
```

| Titel                                                                                   | file              | Diarienummer | fileURL                                          |
|:----------------------------------------------------------------------------------------|:------------------|:-------------|:-------------------------------------------------|
| CLUSTER DESCRIPTION - template                                                          | blob\[42.09 kB\]  | 2017-02942   | <https://data.vinnova.se/api/file/2017-02942_10> |
| CV attachment - template                                                                | blob\[27.47 kB\]  | 2017-02942   | <https://data.vinnova.se/api/file/2017-02942_11> |
| Nationella Flygtekniska Forsknings Programmet 7 - utlysningstext (reviderad 2017-09-18) | blob\[345.27 kB\] | 2017-02942   | <https://data.vinnova.se/api/file/2017-02942_14> |
| Projektbeskrivning - mall                                                               | blob\[36.94 kB\]  | 2017-02942   | <https://data.vinnova.se/api/file/2017-02942_5>  |
| CV-mall                                                                                 | blob\[26.73 kB\]  | 2017-02942   | <https://data.vinnova.se/api/file/2017-02942_6>  |
