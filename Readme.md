# Legacy Landscapes Decision Tool


## Setup


### System wide dependencies

On **Fedora 31** you can install the system dependencies using:

```bash
dnf install gdal gdal-devel jq-devel protobuf-devel v8-devel udunits2-devel geos geos-devel proj proj-devel sqlite-devel
```

For other operating systems the following lists might be helpful, but are not tested:

**Ubuntu**:

```bash
apt install gdal-bin libgdal-dev libjq-dev libprotobuf-dev libudunits2-dev libnode-dev libgeos-dev
```

**macOS**:

You can probably use `brew` to install these, likely incomplete, dependencies:
```bash
v8 protobuf jq udunits
```


### R dependencies

The R-package dependencies are managed using [renv](https://rstudio.github.io/renv/index.html)
and you can either install the required packages using the [install script](install_dependencies.R)
by running:

```bash
Rscript install_dependencies.R
```

or install the dependencies yourself using `renv::restore()`.

