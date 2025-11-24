dep <- c("rsconnect" ,"shiny","mlogit" ,"MASS" ,"AER" ,
         "mcmc","bayesm",
         "abind","bayesboot","bibtex" ,
         "BMA","car","carData","cellranger" ,"clipr",
         "coda","DT","Formula",
         "Matrix" ,"matrixcalc","RcppEigen",
         "Rdpack","rhandsontable" ,"statmod", "truncnorm"  ,
         "stringr","dma",'dlm',"bvartools","stochvol","bayesforecast","ggpubr","latex2exp")

ip <- rownames(installed.packages())

## 1) Instalar TODOS los demás desde CRAN
needed <- dep[!dep %in% ip]

if (length(needed) > 0) {
  install.packages(needed)
}

## 2) Instalar ivbma desde el tarball
if (!"ivbma" %in% ip) {
  install.packages(
    "https://cran.r-project.org/src/contrib/Archive/ivbma/ivbma_1.05.tar.gz",
    repos = NULL, type = "source"
  )
}

## 3) Instalar SIEMPRE versión corregida de MCMCpack
install.packages(
  "https://github.com/BESmarter-consultancy/BSTApp/raw/master/MCMCpack_1.7-1.tar.gz",
  repos = NULL, type = "source"
)


