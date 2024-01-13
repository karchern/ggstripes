library(ggplot2)
library(tidyverse)
library(ggstripes)

p <- ggplot(data = mtcars 
    %>% mutate(car = rownames(.))
, aes(x = mpg, y = car)) +
    geom_point() +
    geom_stripes(odd = "#33333333", even = "#00000000")

p
