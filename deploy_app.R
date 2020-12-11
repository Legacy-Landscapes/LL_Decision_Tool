
# Set the account info from secret variables
rsconnect::setAccountInfo(name = Sys.getenv("SHINYAPPSIO_NAME"),
                          token = Sys.getenv("SHINYAPPSIO_TOKEN"),
                          secret = Sys.getenv("SHINYAPPSIO_SECRET"))

# Deploy the app
rsconnect::deployApp(appDir = "legacy_landscapes_dst")
