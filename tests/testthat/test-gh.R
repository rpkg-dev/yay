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

test_that("`gh_dir_ls()` properly errors", {

  expect_error(yay::gh_dir_ls(owner = "rpkg-dev",
                              name = "notpal"),
                   "not resolve .+rpkg-dev/notpal")
})

# gh_text_file ----
test_that("`gh_text_file()` properly errors", {

  expect_error(yay::gh_text_file(owner = "rpkg-dev",
                                 name = "notpal",
                                 path = "pal.Rproj"),
               "not resolve .+rpkg-dev/notpal")
})
