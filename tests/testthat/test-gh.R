# gh_dir_ls ----
test_that("`gh_dir_ls()` basically works", {
  expect_identical(yay::gh_dir_ls(path = "README.md",
                                  owner = "salim-b",
                                  name = "pal"),
                   character())

  expect_identical(yay::gh_dir_ls(path = "tests",
                                  owner = "salim-b",
                                  name = "pal",
                                  recurse = FALSE,
                                  incl_dirs = FALSE),
                   "tests/testthat.R")

  expect_identical(yay::gh_dir_ls(path = "tests",
                                  owner = "salim-b",
                                  name = "pal",
                                  recurse = FALSE,
                                  incl_files = FALSE),
                   "tests/testthat")
})
