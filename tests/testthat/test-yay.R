# Extending other R packages ----
## str_replace_file ----
test_that("`str_replace_file()` basically works", {

  before <- c('"Tulips are not durable, ',
              ' not scarce, ',
              ' not programmable, ',
              ' not fungible, ',
              ' not verifiable, ',
              ' not divisible, ',
              ' and hard to transfer. ',
              ' But tell me more about your analogy..." ',
              '',
              '-[Naval Ravikant](https://twitter.com/naval/status/939316447318122496)')

  after <- c('"Tulips are TULIPS \U0001F911, ',
             ' TULIPS \U0001F911, ',
             rep(" TUUULIPS \U0001F92A, ",
                 times = 4L),
             ' and TULIPS \U0001F911. ',
             ' But go home already..." ',
             '',
             '-Nobody')

  pattern = c("(not (scarce|durable)|hard to transfer)" = "TULIPS \U0001F911",
              " not \\w+?[^r][ai]ble(?=, )" = " TUUULIPS \U0001F92A",
              "tell me more about your analog(y)" = "go home alread\\1",
              "\\Q[Naval Ravikant](https://twitter.com/naval/status/939316447318122496)" = "Nobody")

  withr::local_file(.file = list(
    "test_file_1.txt" = {
      readr::write_lines(x = before,
                         file = "test_file_1.txt")
      str_replace_file(path = "test_file_1.txt",
                       pattern = pattern,
                       process_line_by_line = TRUE,
                       verbose = FALSE)},
    "test_file_2.txt" = {
      readr::write_lines(x = before,
                         file = "test_file_2.txt")
      str_replace_file(path = "test_file_2.txt",
                       pattern = pattern,
                       process_line_by_line = FALSE,
                       verbose = FALSE)}))

  expect_identical(readr::read_lines("test_file_1.txt"),
                   after)
  expect_identical(readr::read_lines("test_file_2.txt"),
                   after)
})
