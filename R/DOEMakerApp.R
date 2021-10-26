library(shiny)

DOEMaker <- function() {
  ui <- fluidPage(
    titlePanel("DOE Maker"),
    sidebarLayout(
      sidebarPanel(
        selectInput("doe_type", "Type of desing:", choices = design_type),
        tabsetPanel(
          id = "arguments",
          type = "hidden",
          tabPanel("full_f", FullFactorialUI("full_f")),
          tabPanel("frac", FractionalDesignsUI("frac")),
          tabPanel("bbd", BoxBehnkenUI("bbd")),
          tabPanel("ccd", CentralCompositeUI("ccd"))
        )
      ),
      mainPanel(
        dataTableOutput("design_output"),
        textInput("file_name", "File name:", value = "DESIGN_01"),
        downloadButton("download", "Download as CSV file")
      )
    )
  )
  
  server <- function(input, output) {
    
    observeEvent(input$doe_type, {
      updateTabsetPanel(inputId = "arguments", selected = input$doe_type)
    })
    
    design_table <- reactive({
      if (input$doe_type == "full_f") FullFactorialServer("full_f")
      else if (input$doe_type == "frac") FractionalDesignsServer("frac")
      else if (input$doe_type == "bbd") BoxBehnkenServer("bbd")
      else if (input$doe_type == "ccd") CentralCompositeServer("ccd")
    })
    
    output$design_output <- renderDataTable(
      design_table(), 
      options = list(
        ordering = FALSE, searching = FALSE, 
        lengthChange = FALSE, pageLength = 10, autoWidth = FALSE
      )
    )
    
    output$download <- downloadHandler(
      filename = function() {
        paste0(input$file_name, ".csv")
      },
      content = function(file) {
        readr::write_csv(design_table(), file)
      }
    )
  }
  
  # Run the application 
  shinyApp(ui = ui, server = server)
  
}
