#' htmlwidget to create a lightbox2 gallery of image files
#'
#' Use \href{https://lokeshdhakar.com/projects/lightbox2/}{lightbox2} to display
#' image files.
#'
#' @param images,thumbnailImages Vector of paths to image files. Full file paths
#'   are recommended. The default is to have the main pictures in \code{images}
#'   be the thumbnail images as well and then control their sizing with
#'   \code{thumbnailWidth} and \code{thumbnailHeight}.
#' @param gallery Name of the lightbox gallery. If there are multiple lightbox2
#'   galleries on a single page it might help to name them differently.
#' @param titles Optional vector of title/alt names to use for the \code{<img>}
#'   tag. Should be the same length as \code{images}. If none are provided the
#'   file names from \code{thumbnailImages} then \code{images} is used,
#'   whichever is available in that order.
#' @param thumbnailAlign String denoting how to arrange the thunbnail images in
#'   the \code{<div>} tag. Gets passed to the \code{<div>}'s text-align style.
#'   Options are "center", "left", "right", "justify".
#' @param thumbnailWidth String denoting the width of the images in css units
#'   when they are displayed as thumbnails. The default is \code{"auto"} so the
#'   images are not stretched while their size is controlled by
#'   \code{thumbnailHeight}.
#' @param thumbnailHeight String denoting the height of the images in css units
#'   when they are displayed as thumbnails. The default is \code{"100px"}.
#' @param maxHeight The max height of the overall widget (the gallery of
#'   thumbnail images) in css units. Any overflow will cause a scroll bar to
#'   appear. The default is \code{"412px"} which allows for 4 rows of images
#'   when \code{thumbnailHeight = "100px"}. 412px and not 400px because each image
#'   gets a bottom (and right) margin of 3px.
#' @param margin The margin style used for the overall widget (the gallery of
#'   thumbnail images). Default is "auto" to center the gallery on the page.
#' @param searchable Boolean if a search box should be added to filter the
#'   images based on \code{titles}.
#' @inheritParams htmlwidgets::createWidget
#' @examples
#' library(lightbox2)
#' imgs <- example_images() # get some stock image paths
#' lightbox2(imgs)
#' @import htmlwidgets
#' @export
lightbox2 <- function(images, thumbnailImages = NULL, gallery = "lb-gallery", titles = NULL,
                      thumbnailAlign = c("center", "left", "right", "justify"),
                      thumbnailWidth = "auto", thumbnailHeight = "100px",
                      maxHeight = "412px", margin = "auto", searchable = FALSE,
                      width = "100%", height = "auto", elementId = NULL) {
  thumbnailAlign <- match.arg(thumbnailAlign)
  user_titles <- !is.null(titles)
  user_thumbnails <- !is.null(thumbnailImages)

  if (user_titles) {
    if(length(images) != length(titles)) stop("`images` and `titles` must be the same length.")
  } else {
    # must have image alt/title no matter what
    if (user_thumbnails) {
      titles <- basename(thumbnailImages)
    } else {
      titles <- basename(images)
    }
  }

  image_uris <- vapply(images, knitr::image_uri, character(1))
  if (user_thumbnails) {
    if (length(images) != length(thumbnailImages)) stop("`images` and `thumbnailImages` must be the same length.")
    thumbnail_uris <- vapply(thumbnailImages, knitr::image_uri, character(1))
  } else {
    thumbnail_uris <- image_uris
  }

  x <- list(
    images = unname(image_uris), # cannot give named vectors to jsonlite
    thumbnailImages = unname(thumbnail_uris),
    gallery = gallery,
    titles = unname(titles),
    thumbnailAlign = thumbnailAlign,
    thumbnailWidth = thumbnailWidth,
    thumbnailHeight = thumbnailHeight,
    maxHeight = maxHeight,
    margin = margin,
    searchable = searchable
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
#' @param expr An expression that generates a lightbox2
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
