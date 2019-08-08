# lightbox2

Use the [lightbox2 javascript library](https://lokeshdhakar.com/projects/lightbox2/) to render image files in an `htmlwidget`.

There is a shiny binding, but it doesn't seem to work since the images aren't copied along with the webpage.

## TODO

Works in an R Markdown document that is knitted to an HTML document. This is the primary use case. ~~If we could figure out how to bundle the images with the page, the R Markdown HTML output would benefit as well since it could then be emailed and the plots would stay.~~ The images stay bundled with the R Markdown HTML document even when they are moved to a new location.

Just need to figure out why the interactive use and the shiny binding don't work.

## Example

It is probably best to give the full file paths to your images when using R Markdown.

The R code chunk in R Markdown does **not** have `results='asis'`.

```r
images <- normalizePath(dir("my-images", pattern = "\\.(png|jpg)", full.names = TRUE))
library(lightbox2)
lightbox2(images)
```
