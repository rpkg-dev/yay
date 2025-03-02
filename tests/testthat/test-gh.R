# gh_dir_ls ----
test_that("`gh_dir_ls()` basically works", {
  expect_identical(yay::gh_dir_ls(path = "README.md",
                                  owner = "rpkg-dev",
                                  name = "pal"),
                   character())

  expect_identical(yay::gh_dir_ls(path = "tests",
                                  owner = "rpkg-dev",
                                  name = "pal",
                                  recurse = FALSE,
                                  incl_dirs = FALSE),
                   "tests/testthat.R")

  expect_identical(yay::gh_dir_ls(path = "tests",
                                  owner = "rpkg-dev",
                                  name = "pal",
                                  recurse = FALSE,
                                  incl_files = FALSE),
                   "tests/testthat")
})
