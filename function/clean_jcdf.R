#' Download JCDF (Japan Census Data File)
#'
#' @param pref_raw raw prefecture shapefile data downloaded using download_shp function
#'
#' @return a sf object with cleaned, collated version of the census data
#'
#' @concept getdata
#'
#' @export
#'

clean_jcdf <- function(pref_raw) {

  # validate the pref_raw data to bypass sf-related errors
  pref_raw <- sf::st_make_valid(pref_raw)

  # initialize pref object
  pref <- NA

  # filter out water surfaces and extraneous port data
  pref <- pref_raw %>%
    dplyr::filter(pref_raw$KIHON1 != "0000" & pref_raw$HCODE != 8154, )  %>%
    dplyr::group_by(CITY, KIHON1) %>%

    # make smallest geopolitical subdivision to level 2
    dplyr::summarize(geometry = sf::st_union(geometry),
                     PREF = PREF[1],
                     JINKO = sum(JINKO),
                     CITY_NAME = CITY_NAME[1],
                     S_NAME = S_NAME[1]) %>%

    # make 5 digit municipality code
    dplyr::mutate(code = 1000*as.numeric(PREF) + as.numeric(CITY)) %>%
    dplyr::select(code, CITY_NAME, S_NAME, KIHON1, JINKO, geometry)

  # return final
  return(pref)

}

