
# Central-composite designs module ----------------------------------------

CentralCompositeUI <- function(id) {
  tagList(
    numericInput(NS(id, "nfac"), "Number of factors", value = 3),
    numericInput(NS(id, "cp"), "Number of center points", value = 4),
    selectInput(
      NS(id, "alpha"), 
      "Alpha",
      choices = c("orthogonal", "rotatable", "spherical", "faces")
    ),
    selectInput(
      NS(id, "rnd"),
      "Randomize", 
      choices = c("Yes" = "TRUE", "No" = "FALSE")
    )
  )
}

CentralCompositeServer <- function(id) {
  moduleServer(id, function(input, output, session) {
    ds <- as.data.frame(
      cc_design(
        nfactors = input$nfac,
        ncenter = input$cp,
        alpha = input$alpha,
        randomize = input$rnd
      )
    )
    ds <- dplyr::select(ds, -run.order, -std.order)
    colnames(ds) <- LETTERS[1:ncol(ds)]
    round(ds, 2)
  })
}
