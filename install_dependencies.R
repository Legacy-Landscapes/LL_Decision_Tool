# This script helps to automatically set up the 
# required R packages.

# install required packages 'remotes' and 'renv'
if (!requireNamespace("remotes"))
  install.packages("remotes")

remotes::install_github("rstudio/renv")  ## Error 'install of package KernSmooth failed'

# restore packages from lockfile
renv::restore()


