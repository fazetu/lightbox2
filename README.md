
<!-- README.md is generated from README.Rmd. Please edit that file -->

# lightbox2

Use the [lightbox2 javascript
library](https://lokeshdhakar.com/projects/lightbox2/) to render image
files in an `htmlwidget`.

## Installation

``` r
devtools::install_github("fazetu/lightbox2")
```

## Examples

``` r
library(lightbox2)
```

Get file paths to some image files.

``` r
images <- example_images()
```

Note there is also `example_lightbox2()`.

These examples are **not** interactive, but demonstrate the different
styling options available.

This R code chunk in R Markdown does **not** have `results='asis'`.

<!-- Webshot not working so just take manual screen captures for now -->

``` r
lightbox2(images)
```

![4-1](man/figures/README-4-1.png)

Change thumbnail size.

``` r
lightbox2(images, thumbnailHeight = "50px", thumbnailWidth = "auto")
```

![5-1](man/figures/README-5-1.png)

Change thumbnail
alignment.

``` r
lightbox2(images, thumbnailHeight = "50px", thumbnailWidth = "auto", thumbnailAlign = "left")
```

![6-1](man/figures/README-6-1.png)

Make it so we get a scroll bar by adjusting thumbnail height and max
height of the
widget.

``` r
lightbox2(images, thumbnailHeight = "200px", thumbnailWidth = "auto", maxHeight = "200px")
```

![7-1](man/figures/README-7-1.png)

Adjust the size of the overall widget.

``` r
lightbox2(images, width = "50%")
```

![8-1](man/figures/README-8-1.png)

Don’t center within the page.

``` r
lightbox2(images, width = "50%", margin = "none")
```

![9-1](man/figures/README-9-1.png)
