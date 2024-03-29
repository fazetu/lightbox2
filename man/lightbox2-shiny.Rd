% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/lightbox2.R
\name{lightbox2-shiny}
\alias{lightbox2-shiny}
\alias{lightbox2Output}
\alias{renderLightbox2}
\title{Shiny bindings for lightbox2}
\usage{
lightbox2Output(outputId, width = "100\%", height = "400px")

renderLightbox2(expr, env = parent.frame(), quoted = FALSE)
}
\arguments{
\item{outputId}{output variable to read from}

\item{width, height}{Must be a valid CSS unit (like \code{'100\%'},
\code{'400px'}, \code{'auto'}) or a number, which will be coerced to a
string and have \code{'px'} appended.}

\item{expr}{An expression that generates a lightbox2}

\item{env}{The environment in which to evaluate \code{expr}.}

\item{quoted}{Is \code{expr} a quoted expression (with \code{quote()})? This
is useful if you want to save an expression in a variable.}
}
\description{
Output and render functions for using lightbox2 within Shiny
applications and interactive Rmd documents.
}
