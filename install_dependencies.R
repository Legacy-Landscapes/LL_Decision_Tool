# This script helps to automatically set up the 
# required R packages.

# install required packages 'remotes' and 'renv'
if (!requireNamespace("renv"))
  install.packages("renv")

# restore packages from lockfile
renv::restore()
