# Check if files are correctly formatted

# check root directory
files <- list.files(pattern = ".R$")
lints <- lapply(files, lintr::lint)

# check app directory
append(lints, lintr::lint_dir("legacy_landscapes_dst/"))

# stop if there are lints
n_errors <- sum(unlist(lapply(lints, length)))
if(n_errors > 0)
  stop("Found formatting errors.")
