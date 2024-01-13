
# Currently only works with discrete axis

library(ggplot2)
library(tidyverse)
load_all()
library(ggstripes)

p <- ggplot(data = mtcars 
    %>% mutate(car = rownames(.))
, aes(x = mpg, y = car)) +
    geom_point() +
    

p <- ggplot(data = mtcars 
    %>% mutate(car = rownames(.))
, aes(x = car, y = mpg)) +
    geom_point() +
    geom_stripes_vertical(odd = "#33333333", even = "#00000000")

p <- ggplot(data = mtcars %>% 
    mutate(car = rownames(.)) %>%
        mutate(group = sample(c("a", "b", "c"), size = nrow(.), replace = TRUE)) %>%
        mutate(group = as.factor(group))
, aes(x = mpg, y = car)) +
    geom_point() +
    geom_stripes_horizontal(odd = "#33333333", even = "#00000000", along = "x") +
    facet_grid(group ~ .)

p
