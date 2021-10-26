
# Box-Behnken design module -----------------------------------------------

BoxBehnkenUI <- function(id) {
  tagList(
    numericInput(NS(id, "nfac"), "Number of factors", value = 3), 
    numericInput(NS(id, "cp"), "Number if center points", value = 4),
    selectInput(
      NS(id, "rnd"), 
      "Randomize", 
      choices = c("Yes" = "TRUE", "No" = "FALSE")
    )
  )
}

BoxBehnkenServer <- function(id) {
  moduleServer(id, function(input, output, session) {
    ds <- as.data.frame(
      bb_design(
        nfactors = input$nfac,
        ncenter = input$cp,
        randomize = input$rnd
      )
    )
    ds <- dplyr::select(ds, -run.order, -std.order)
    colnames(ds) <- LETTERS[1:ncol(ds)]
    ds
  })
}
