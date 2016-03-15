basurl <- function() {
  "http://api.planetos.com/v1/datasets"
  }

datasets <- function(name = "water_u") {
  "hycom_glbu0.08_91.1_global_0.08d"
}

qtype <- function(){
  "point?"
  }
lonlat <- function(lon, lat = 49.5) {
  sprintf("lon=%f&lat=%f", lon, lat)

    }
key <- function() {
  sprintf("&apikey=%s", getOption("rplanetos_apikey"))
}


#' Title
#'
#' @param x
#' @param y
#'
#' @return
#' @export
#'
#' @examples
bqu <- function(x  = -50.5, y = 49.5) {
  paste0(file.path(basurl(), datasets(), qtype()), lonlat(x, y), key())
}


#' Title
#'
#' @param x
#' @param y
#'
#' @return
#' @export
#'
#' @examples
submit <- function(x, y) {
  parsejson(readLines(bqu(x, y), warn = FALSE))
}

#' importFrom jsonlite fromJSON
parsejson <- function(x) {
  jsonlite::fromJSON(x)
}

#' Title
#'
#' @param x
#' @param y
#'
#' @return
#' @export
#'
#' @examples
collateentries <- function(x, y) {
  jj <- vector("list", length(x))
  for (i in seq_along(x)) {
    jj[[i]] <- submit(x[i], y[i])$entries
  }
  jj
}

