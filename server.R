server <- function(input, output, server) {
  
  output$ui_graf_queimadas_anos = renderUI({

    if (input$select_tipo_plot == "highcharter") {
      highchartOutput('graf_highchart_queimadas_anos')
    } else {
      plotlyOutput('graf_ggplot_queimadas_anos')
    }
    
  })
  
  queimadas_anos <- reactive({
      dados %>% 
      group_by(year) %>% 
      summarise(total_queimadas = sum(number)) 
  })
  
  output$graf_highchart_queimadas_anos <- renderHighchart({
    queimadas_anos() %>% 
      hchart(type = "column", name = "Total queimadas durante o ano", hcaes(x = year, y = total_queimadas)) %>% 
      hc_xAxis(title = list(text = "Ano")) %>% 
      hc_yAxis(title = list(text = "Total de queimadas")) %>% 
      hc_colors(c("#9b0000"))
    
    
  })
  
  output$graf_ggplot_queimadas_anos <- renderPlotly({
    plot <- 
    queimadas_anos() %>% 
    ggplot(aes(year, total_queimadas)) +
      geom_col(aes(fill=total_queimadas)) +
      scale_x_continuous(breaks = seq(from = 1998, to = 2017, by = 1)) +
      scale_y_continuous(breaks = seq(from = 0, to = 50000, by = 5000)) +
      labs(x = "Ano", y = "Número de queimadas", title = "Número total de queimadas por ano") +
      scale_fill_gradientn(colors = c("#f9020e", "#9b0000"))
    
    ggplotly(plot)
  })
  
}