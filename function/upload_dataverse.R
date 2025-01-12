#' Upload data to dataverse
#'
#' @param pref_code number of prefecture code
#' @param pref_name name of prefecture
#'
#' @return no return value
#'
#' @concept uploaddata
#'
#' @importFrom dplyr %>%
#'
#' @export
#'

upload_dataverse <- function(pref_code, pref_name){

    Sys.setenv("DATAVERSE_KEY" = "20cccb27-d4ed-44a3-9ad1-4ac845900f67")
    Sys.setenv("DATAVERSE_SERVER" = "dataverse.harvard.edu")

    # Upload rules
    add_dataset_file(
        file=here::here(paste(
            "analyses/",
            stringr::str_pad(pref_code, 2, pad = "0"),
            "_",
            as.character(pref_name),
            "/",
            stringr::str_pad(pref_code, 2, pad = "0"),
            "_",
            as.character(pref_name),
            "_hr_2020_doc.html",
            sep = "")),
        dataset="doi:10.7910/DVN/Z9UKSH"
    )

    # Upload map files
    add_dataset_file(
        file=here::here(paste(
            "data-out/maps/",
            as.character(pref_code),
            "_",
            as.character(pref_name),
            "_hr_2020_map_0.rds",
            sep = "")),
        dataset="doi:10.7910/DVN/Z9UKSH"
    )

    add_dataset_file(
        file=here::here(paste(
            "data-out/maps/",
            as.character(pref_code),
            "_",
            as.character(pref_name),
            "_hr_2020_map_1.rds",
            sep = "")),
        dataset="doi:10.7910/DVN/Z9UKSH"
    )

    # Upload plan files
    add_dataset_file(
        file=here::here(paste(
            "data-out/plans/",
            as.character(pref_code),
            "_",
            as.character(pref_name),
            "_hr_2020_plans_0.rds",
            sep = "")),
        dataset="doi:10.7910/DVN/Z9UKSH"
    )

    add_dataset_file(
        file=here::here(paste(
            "data-out/plans/",
            as.character(pref_code),
            "_",
            as.character(pref_name),
            "_hr_2020_plans_1.rds",
            sep = "")),
        dataset="doi:10.7910/DVN/Z9UKSH"
    )

    # Upload summary statistics (csv)
    add_dataset_file(
        file= here::here(paste(
            "data-out/plans/",
            as.character(pref_code),
            "_",
            as.character(pref_name),
            "_hr_2020_stats_0.csv",
            sep = "")),
        dataset="doi:10.7910/DVN/Z9UKSH"
    )

    # Pause execution
    Sys.sleep(30)

    add_dataset_file(
        file= here::here(paste(
            "data-out/plans/",
            as.character(pref_code),
            "_",
            as.character(pref_name),
            "_hr_2020_stats_1.csv",
            sep = "")),
        dataset="doi:10.7910/DVN/Z9UKSH"
    )

}
