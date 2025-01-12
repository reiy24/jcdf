#' Modify Column of Prefecture Shapefile with the Population of Japanese Nationals
#' Note: the Japanese census data randomly merges some areas together in their data collection process,
#' so there are some inconsistencies (i.e. areas with '0' population)
#'
#'
#' @param pref an sf object with cleaned, collated version of the census data
#' @param age_pops csv containing population by age + foreigner population
#'
#' @return a dataframe similar to pref, with an additional KOKUMIN column containing the number of Japanese nationals
#'
#'
#' @concept calculate
#'
#' @export
#'

calc_kokumin <- function(pref, age_pops){

  # select relevant columns and rename
  age_pops <- age_pops[which(age_pops[, 3] == 2), c(1, 2, 11, 41)]
  names(age_pops) <- c("code", "KIHON1", "JINKO", "foreign")

  # adding padded zeros to match the pref shapefile format
  age_pops$KIHON1 <- sprintf("%04d", age_pops$KIHON1)

  # reformat the total population numbers
  age_pops$JINKO <- as.numeric(age_pops$JINKO)
  age_pops$JINKO[is.na(age_pops$JINKO)] <- 0

  # reformat the foreigner numbers
  age_pops$foreign <- as.numeric(age_pops$foreign)
  age_pops$foreign[is.na(age_pops$foreign)] <- 0

  # calculate number of Japanese nationals
  age_pops$pop_national <- (age_pops$JINKO - age_pops$foreign)
  age_pops <- age_pops %>%
              dplyr::filter(age_pops$KIHON1 != "0000", ) %>%
              dplyr::select(code, KIHON1, pop_national)

  # left join with original pref shapefile to format properly.
  pref_new <- dplyr::left_join(pref, age_pops, by = c("code", "KIHON1"))

  # return result
  return(pref_new)

}
