test_that("getting changes from last three days works", {
  skip("skipping for now")
  skip_on_ci()
  # new stuff from vinnova
  v <- vinnova_latest(from_date = Sys.Date() - 3)
  entities <- c("calls", "programmes", "rounds", "projects")
  is_valid <- all(names(v) %in% c(entities, paste0(entities, "_tbls"))) &
    v[entities] %>% purrr::map_int(nrow) %>% sum() > 0
  expect_true(is_valid)
})

test_that("changes since three days for specific coordinating org works", {

  skip("skipping for now")
  skip_on_ci()

  # new stuff from vinnova
  v <- vinnova_latest(from_date = Sys.Date() - 3)

  dnrs <- v$projects %>% dplyr::filter(grepl("Kungliga", KoordinatorOrg)) %>%
    dplyr::select(dplyr::starts_with("Diarie"))

  # NOTE: if more than 20 ids, batching needs to be done (?)
  dnrs <- dnrs %>% dplyr::slice(1:20)
  rounds <- vinnova("rounds", id = dnrs$DiarienummerAnsokningsomgang)
  calls <- vinnova("proposals", id = dnrs$DiarienummerUtlysning)
  programmes <- vinnova("programmes", id = dnrs$DiarienummerProgram)
  projects <- vinnova("projects", id = dnrs$Diarienummer)

  has_data <- function(x) nrow(x) > 10 & ncol(x) > 1

  is_valid <- list(rounds, calls, programmes, projects) %>% purrr::map_lgl(has_data) %>% all()
  expect_true(is_valid)

})

#' @importFrom blob as_blob
test_that("downloading files works", {

  skip("skipping for now")
  skip_on_ci()

  downloads <- vinnova_files()
  has_data <- function(x) nrow(x) > 10 & ncol(x) > 1
  is_valid <- list(downloads) %>% purrr::map_lgl(has_data) %>% all()
  expect_true(is_valid)

})

