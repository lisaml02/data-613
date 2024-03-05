library(tidyverse)
library(dplyr)
diamonds

diamonds %>%
    select(x, y, z) %>%
    head(n = 30)
