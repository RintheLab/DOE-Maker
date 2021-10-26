
# Full factorial designs module -------------------------------------------

FullFactorialUI <- function(id) {
  tagList(
    numericInput(NS(id, "nfactors"), "Number of factors", value = 3),
    numericInput(NS(id, "nlevels"), "Number of levels", value = 2),
    numericInput(NS(id, "rep"), "Replications", value = 1),
    selectInput(
      NS(id, "rand"), 
      "Randomize treatments", 
      choices = c("Yes" = "TRUE", "No" = "FALSE")
      ),
    numericInput(NS(id, "blocks"), "Number of blocks", value = 1)
  )
}

FullFactorialServer <- function(id) {
  moduleServer(id, function(input, output, session) {
    as.data.frame(
      full_design(
        nfactors = input$nfactors,
        nlevels = input$nlevels,
        replications = input$rep,
        randomize = as.logical(input$rand),
        blocks = input$blocks
      )
    )
  })
}
