#' Create a lightbox2 gallery of image files
#'
#' Use \href{https://lokeshdhakar.com/projects/lightbox2/}{lightbox2} to display
#' image files.
#' @param images Vector of paths to image files. Full file paths are
#'   probably recommended.
#' @param titles Vector of title/alt names to use for the <img> tag. Should be
#'   the same length as \code{images}.
#' @param thumbnailWidth String denoting the width of the images when they are
#'   displayed as thumbnails. Usually in the format "Npx".
#' @param thumbnailHeight String denoting the height of the images when they are
#'   displayed as thumbnails. Usually in the format "Npx".
#' @inheritParams htmlwidgets::createWidget
#' @import htmlwidgets
#' @export
lightbox2 <- function(images, titles = images, thumbnailWidth = "100px", thumbnailHeight = "100px",
                      width = NULL, height = NULL, elementId = NULL) {
  if(length(images) != length(titles)) stop("`images` and `titles` must be the same length.")
  # if images is a named vector use those names for titles
  if (all(titles == images) && !is.null(names(images))) titles <- names(images)

  x = list(
    images = unname(images), # cannot give named vectors to jsonlite
    titles = titles,
    thumbnailWidth = thumbnailWidth,
    thumbnailHeight = thumbnailHeight
  )

  htmlwidgets::createWidget(
    name = 'lightbox2',
    x,
    width = width,
    height = height,
    package = 'lightbox2',
    elementId = elementId
  )
}

#' Shiny bindings for lightbox2
#'
#' Output and render functions for using lightbox2 within Shiny
#' applications and interactive Rmd documents.
#'
#' @param outputId output variable to read from
#' @param width,height Must be a valid CSS unit (like \code{'100\%'},
#'   \code{'400px'}, \code{'auto'}) or a number, which will be coerced to a
#'   string and have \code{'px'} appended.
#' @param expr An expression that generates a lightbox
#' @param env The environment in which to evaluate \code{expr}.
#' @param quoted Is \code{expr} a quoted expression (with \code{quote()})? This
#'   is useful if you want to save an expression in a variable.
#' @name lightbox2-shiny
#' @export
lightbox2Output <- function(outputId, width = '100%', height = '400px'){
  htmlwidgets::shinyWidgetOutput(outputId, 'lightbox2', width, height, package = 'lightbox2')
}

#' @rdname lightbox2-shiny
#' @export
renderLightbox2 <- function(expr, env = parent.frame(), quoted = FALSE) {
  if (!quoted) { expr <- substitute(expr) } # force quoted
  htmlwidgets::shinyRenderWidget(expr, lightbox2Output, env, quoted = TRUE)
}
