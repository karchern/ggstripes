
# background stripes for ggplot2

Often times in large plots with discrete x/y axis, it is difficult to
see which row belongs to which sample. A typical solution are
alternating background shades to help the reader.

This package implements these. Credit goes to the
[ggforestplot](https://github.com/nightingalehealth/ggforestplot)
package whose code I used as a starting point.

# Installation

The package can be can be installed via
`devtools::install_github('https://github.com/karchern/ggstripes/tree/main')`

# Usage

The package provides a single function `geom_stripes` which can be used
like any other geom in ggplot2.

It only works if the scale is discrete.

``` r
library(ggplot2)
library(ggstripes)
mtcars$car <- rownames(mtcars)
```

``` r
ggplot(data = mtcars
, aes(x = car, y = mpg)) +
    geom_stripes_vertical(odd = "#33333333", even = "#00000000")  +
    geom_point()
```

    ## Warning: Using the `size` aesthetic with geom_rect was deprecated in ggplot2 3.4.0.
    ## ℹ Please use the `linewidth` aesthetic instead.
    ## This warning is displayed once every 8 hours.
    ## Call `lifecycle::last_lifecycle_warnings()` to see where this warning was generated.

![](README_files/figure-gfm/unnamed-chunk-2-1.png)<!-- -->

``` r
ggplot(data = mtcars 
, aes(x = mpg, y = car)) +
    geom_stripes_horizontal(odd = "#33333333", even = "#00000000") +
    geom_point()
```

![](README_files/figure-gfm/unnamed-chunk-3-1.png)<!-- -->

It also works with faceting:

``` r
mtcars$group <- as.factor(sample(c('a', 'b', 'c'), size = nrow(mtcars), replace = TRUE))
ggplot(data = mtcars
, aes(x = mpg, y = car)) +
    geom_stripes_horizontal(odd = "#33333333", even = "#00000000", along = "x") +
    geom_point() +
    facet_grid(group ~ .)
```

    ## Warning in geom_stripes_horizontal(odd = "#33333333", even = "#00000000", :
    ## Ignoring unknown parameters: `along`

![](README_files/figure-gfm/unnamed-chunk-4-1.png)<!-- -->
