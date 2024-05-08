## ----include = FALSE----------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)

## ----message = FALSE, warning = FALSE-----------------------------------------
library("dplyr")
library("tidylog", warn.conflicts = FALSE)
library("bench")
library("knitr")

## ----message = FALSE----------------------------------------------------------
bench::mark(
    dplyr::filter(mtcars, cyl == 4),
    tidylog::filter(mtcars, cyl == 4), iterations = 100
) %>%
    dplyr::select(expression, min, median, n_itr) %>%
    kable()

## ----message = FALSE----------------------------------------------------------
df <- tibble(x = rnorm(100000))

bench::mark(
    dplyr::filter(df, x > 0),
    tidylog::filter(df, x > 0), iterations = 100
) %>%
    dplyr::select(expression, min, median, n_itr) %>%
    kable()

## ----message = FALSE----------------------------------------------------------
bench::mark(
    dplyr::mutate(mtcars, cyl = as.factor(cyl)),
    tidylog::mutate(mtcars, cyl = as.factor(cyl)), iterations = 100
) %>%
    dplyr::select(expression, min, median, n_itr) %>%
    kable()

## ----message = FALSE----------------------------------------------------------
df <- tibble(x = round(runif(10000) * 10))

bench::mark(
    dplyr::mutate(df, x = as.factor(x)),
    tidylog::mutate(df, x = as.factor(x)), iterations = 100
) %>%
    dplyr::select(expression, min, median, n_itr) %>%
    kable()

## ----message = FALSE----------------------------------------------------------
bench::mark(
    dplyr::inner_join(band_members, band_instruments, by = "name"),
    tidylog::inner_join(band_members, band_instruments, by = "name"), iterations = 100
) %>%
    dplyr::select(expression, min, median, n_itr) %>%
    kable()

## ----message = FALSE----------------------------------------------------------
N <- 1000
df1 <- tibble(x1 = rnorm(N), key = round(runif(N) * 10))
df2 <- tibble(x2 = rnorm(N), key = round(runif(N) * 10))

bench::mark(
    dplyr::inner_join(df1, df2, by = "key"),
    tidylog::inner_join(df1, df2, by = "key"), iterations = 100
) %>%
    dplyr::select(expression, min, median, n_itr) %>%
    kable()

