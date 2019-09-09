#' Return the paths to built in stock images.
#'
#' @export
example_images <- function() {
  imgs <- normalizePath(dir(system.file("stock-images", package = "lightbox2"), full.names = TRUE))
  names(imgs) <- c("Giraffes", "Leopard", "Tigers", "Flamingos", "Elephants")
  imgs
}

#' Run an example \code{\link{lightbox2}} widget
#'
#' Using the stock images in \code{\link{example_images}} launch a
#' \code{\link{lightbox2}} widget.
#'
#' @param ... Named parameters passed to \code{\link{lightbox2}} to test
#'   different stylings.
#' @export
example_lightbox2 <- function(...) {
  imgs <- normalizePath(dir(system.file("stock-images", package = "lightbox2"), full.names = TRUE))
  titles <- c("Three giraffes", "Leopard close up", "Tiger and cub",
              "Flamingos with black background", "Elephant and calf")
  lightbox2(images = imgs, thumbnailImages = imgs, titles = titles, ...)
}
