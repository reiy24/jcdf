#' Merge Municipalities to Group Together To Avoid Creating Enclaves
#'
#' @param pref sf object of cleaned, collated, census data for a prefecture
#' @param merge_codes an array of codes for municipalities to group together so as to avoid creating enclaves
#'
#' @return an sf object with the chosen municipalities grouped together
#'
#' @concept getdata
#'
#' @export
#'

avoid_enclave <- function(pref, merge_codes){

  #except for the designated municipalities, the sf object remains intact
  pref_intact <- pref[pref$code %in% merge_codes == FALSE, ]

  #prepare dataframe to work with
  pref_to_group <- setdiff(pref, pref_intact)

  #re-code the municipalities to group together
  pref_code <- merge_codes[1] %/% 1000
  num <- rep(pref_code*1000 + 1, times = length(merge_codes))
  #re-coded as prefecture_code * 1000

  while(sum(pref_n$code == num[1]) > 0) {num <- num + 1}

  pref_to_group$code <- num

  #group together the designated municipalities
  pref_grouped <- pref_to_group %>%
    group_by(code) %>%
    summarise(geometry = sf::st_union(geometry), pop = sum(pop))

  #bind together the shapefiles
  bound <- dplyr::bind_rows(pref_intact, pref_grouped)

  return(bound)

}




