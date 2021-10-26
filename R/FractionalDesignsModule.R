
# Fractional designs module -----------------------------------------------

FractionalDesignsUI <- function(id) {
  tagList(
    numericInput(NS(id, "nfactors"), "Number of factors", value = 3),
    numericInput(NS(id, "rep"), "Replications", value = 1),
    numericInput(NS(id, "res"), "Resolution", value = 3),
    numericInput(NS(id, "ncenter"), "Number of center points", value = 0),
    selectInput(
      NS(id, "rand"), 
      "Randomize treatments", 
      choices = c("Yes" = "TRUE", "No" = "FALSE")
      )
  )
}

FractionalDesignsServer <- function(id) {
  moduleServer(id, function(input, output, session) {
    as.data.frame(
      frac_design(
        nfactors = input$nfactors,
        replications = input$rep,
        resolution = input$res, 
        ncenter = input$ncenter, 
        randomize = as.logical(input$rand)
      ))
  })
}
