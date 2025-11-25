library(dma)
library(ggplot2)
library(reshape2)

DBMA <- function(y, X, models, lambda = 0.99, delta = 0.99){

  T0 <- 0
  dma.test <- dma::dma(
    X, y,
    models.which = models,
    lambda = lambda,
    gamma = delta,
    initialperiod = T0
  )

  PMP  <- dma.test[["pmp"]]
  BetasBMAmean <- dma.test[["thetahat.ma"]]
  BetasBMAsd   <- dma.test[["Vtheta.ma"]]^0.5
  ForecastsMean <- dma.test[["yhat.ma"]]

  # --------------------
  # NEW GGLOT PLOT HERE
  # --------------------
  Plot <- function(PMP){

    # Add model names if missing
    if (is.null(colnames(PMP))) {
      colnames(PMP) <- paste("Model", seq_len(ncol(PMP)))
    }

    # Convert matrix → long format for ggplot
    df <- data.frame(Time = 1:nrow(PMP), PMP)
    df_long <- reshape2::melt(df, id.vars = "Time",
                              variable.name = "Model",
                              value.name   = "PMP")

    # ggplot
    p <- ggplot(df_long, aes(x = Time, y = PMP, color = Model)) +
      geom_line(linewidth = 0.8, alpha = 0.9) +
      labs(
        title = "Posterior model probabilities",
        x = "Time",
        y = "PMP"
      ) +
      theme_minimal(base_size = 14) +
      theme(
        plot.title = element_text(hjust = 0.5, face = "bold"),
        legend.title = element_blank()
      )

    return(p)
  }

  PlotPMP <- Plot(PMP)

  return(list(
    PMP = PMP,
    BetasBMAmean = BetasBMAmean,
    BetasBMAsd = BetasBMAsd,
    ForecastsMean = ForecastsMean,
    PlotPMP = PlotPMP
  ))
}
