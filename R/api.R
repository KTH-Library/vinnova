utils::globalVariables(".")

#' Data for entities such as programmes, call for proposals, rounds or funded projects
#'
#' This function take the kind of entity requested and also either accepts a vector of identifiers or a date since which changes should be returned
#' @param kind the type of entity, Default: c("programmes", "proposals", "rounds", "projects")
#' @param from_date the date since when changes should be requested, if not set, since three days back
#' @param id identifier (or comma separated identifiers) for specific entities
#' @return table with results
#' @examples
#' \dontrun{
#' if(interactive()){
#'  vinnova("programmes", from_date = Sys.Date())
#'  }
#' }
#' @export
#' @importFrom lubridate ymd
#' @importFrom httr GET stop_for_status content
#' @importFrom jsonlite fromJSON
#' @importFrom dplyr as_tibble
vinnova <- function(
    kind = c("programmes", "proposals", "rounds", "projects"),
    from_date,
    id) {

  entity <- switch(match.arg(kind),
    "programmes" = "program",
    "proposals" = "utlysningar",
    "rounds" = "ansokningsomgangar",
    "projects" = "projekt"
  )

  if (missing(id)) {
    if (missing(from_date)) from_date = Sys.Date() - 3
    d <- lubridate::ymd(from_date)
    route <- "https://data.vinnova.se/api/%s/%s" %>% sprintf(entity, d) %>% httr::GET()
  } else {
    if (length(id) > 20)
      warning("Please page/batch request in chunks of 20.... Issuing request for the first 20 ids only!")
    if (length(id) > 1) id <- paste(collapse = ",", unique(trimws(id[1:20])))
    route <- "https://data.vinnova.se/api/%s/%s" %>% sprintf(entity, id) %>% httr::GET()
  }

  httr::stop_for_status(route)

  route %>% httr::content() %>% rawToChar() %>%
    jsonlite::fromJSON() %>%
    dplyr::as_tibble()
}

#' Files or document contents from Vinnova documents
#' @param id identifier (use DocumentID field)
#' @return raw binary file content
#' @examples
#' \dontrun{
#' if(interactive()){
#'  #EXAMPLE1
#'  }
#' }
#' @export
#' @importFrom httr GET stop_for_status content
vinnova_file <- function(id) {
  if (missing(id)) stop("Please provide document id.")
  route <- "https://data.vinnova.se/api/file/%s" %>% sprintf(id) %>% httr::GET()
  httr::stop_for_status(route)
  route %>% httr::content(encoding = "UTF-8")
}

#' Utility function to flatten nested objects into tabular format
#' @param x the object to flatten
#' @param id vector of corresponding identifiers
#' @param id_col string with title for identifier column, Default: 'Diarienummer'
#' @return table with flattened results
#' @importFrom dplyr as_tibble mutate bind_cols bind_rows rename select everything
#' @importFrom purrr map_dfr
#' @importFrom rlang `:=` `.data`
#' @export
flatten_with_id <-  function(x, id, id_col = "Diarienummer")
  x %>%
  purrr::map_dfr(dplyr::bind_rows, .id = "row") %>%
  dplyr::as_tibble() %>%
  dplyr::mutate(row = as.integer(row)) %>%
  dplyr::bind_cols(intermediary = id[.$row]) %>%
  dplyr::rename({{ id_col }} := .data$intermediary) %>%
  dplyr::select({{ id_col }}, everything()) %>%
  dplyr::select(-c("row"))

#' Flattened complete data for calls, programmes, rounds and projects since a given date
#' @param from_date the date since changes are requested, Default: Sys.Date() - 3
#' @return object with tables
#' @examples
#' \dontrun{
#' if(interactive()){
#'  vinnova_latest()
#'  }
#' }
#' @export
vinnova_latest <- function(from_date = Sys.Date() - 3) {

  calls <- vinnova("proposals", from_date = from_date)

  calls_tbls <- list(
    contacts = with(calls, flatten_with_id(KontaktLista, Diarienummer)),
    links = with(calls, flatten_with_id(LankLista, Diarienummer)),
    documents = with(calls, flatten_with_id(DokumentLista, Diarienummer)),
    round_ids = with(calls, flatten_with_id(AnsokningsomgangDnrLista, Diarienummer))
  )

  programmes <- vinnova("programmes", from_date = from_date)

  programmes_tbls <- list(
    call_ids = with(programmes, flatten_with_id(UtlysningDnrLista, Diarienummer))
  )

  rounds <- vinnova("rounds", from_date = from_date)

  rounds_tbls <- list(
    contacts = with(rounds, flatten_with_id(KontaktLista, Diarienummer)),
    links = with(rounds, flatten_with_id(LankLista, Diarienummer)),
    documents = with(rounds, flatten_with_id(DokumentLista, Diarienummer)),
    readings = with(rounds, flatten_with_id(AvlasningstillfalleLista, Diarienummer))
  )

  projects <- vinnova("projects", from_date = from_date)

  projects_tbls <- list(
    links = with(projects, flatten_with_id(LankLista, Diarienummer))
  )

  list(
    calls = calls, calls_tbls = calls_tbls,
    programmes = programmes, programmes_tbls = programmes_tbls,
    rounds = rounds, rounds_tbls = rounds_tbls,
    projects = projects, projects_tbls = projects_tbls
  )

}

#' Files for latest vinnova data in tabular format
#' @param changes results from vinnova_latest fcn, by default
#' @return table with blob data for results including file contents
#' @importFrom dplyr bind_rows tibble bind_cols
#' @importFrom tibble as_tibble
#' @importFrom purrr map map_dfr
#' @importFrom blob as_blob
#' @export
vinnova_files <- function(changes = vinnova_latest()) {

  v <- changes
  docs <- dplyr::bind_rows(v$rounds_tbls$documents, v$calls_tbls$documents)
  filez <- docs$DokumentID %>% purrr::map(vinnova_file)

  filez %>%
    purrr::map_dfr(function(x) dplyr::tibble(file = blob::as_blob(x))) %>%
    dplyr::bind_cols(docs) %>%
    as_tibble()
}
