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
      geom_col(aes(fill=total_queimadas), show.legend = FALSE) +
      scale_x_continuous(breaks = seq(from = 1998, to = 2017, by = 1)) +
      scale_y_continuous(breaks = seq(from = 0, to = 50000, by = 5000)) +
      labs(x = "Ano", y = "Total de queimadas", title = "") +
      scale_fill_gradientn(colors = c("#f9020e", "#9b0000")) +
      theme_minimal()
    
    ggplotly(plot)
  })
  
  output$ui_graf_queimadas_ano_selected <- renderUI({
    if (input$select_tipo_plot == "highcharter") {
      highchartOutput('graf_highchart_queimadas_ano_selected')
    } else {
      plotlyOutput('graf_ggplot_queimadas_ano_selected')
    }
  })
  
  queimadas_ano_selecionado <- reactive({
    queimadas <-
      dados %>% 
      filter(year == input$select_ano_queimada) %>% 
      group_by(month) %>% 
      summarise(total = sum(number))
    
    # Construindo um dataframe com os meses e um número que representa esse mês
    meses <- data.frame(
      month = c("Janeiro", "Fevereiro", "Março", "Abril", "Maio", "Junho", "Julho", "Agosto", "Setembro", "Outubro", "Novembro", "Dezembro"),
      num_month = c(1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12)
    )
    
    # Juntando os dataframes pelo mês e tranformando a coluna mês no tipo caracter
    df_queimadas <- left_join(queimadas, meses, by = "month") %>% 
      mutate(month = as.character(month)) 
    
    # Ordenando os dados pelos números que representam os meses
    df_queimadas %>% arrange(num_month)
  })
  
  output$graf_highchart_queimadas_ano_selected <- renderHighchart({
    queimadas_ano_selecionado() %>% 
      hchart(type = "column", name = "Total queimadas durante o mês", hcaes(x = month, y = total)) %>% 
      hc_xAxis(title = list(text = "Mês")) %>% 
      hc_yAxis(title = list(text = "Total de queimadas")) %>% 
      hc_colors(c("#9b0000"))
  })
  
  output$graf_ggplot_queimadas_ano_selected <- renderPlotly({
    plot <-
      queimadas_ano_selecionado() %>% 
      mutate(mes = factor(month, levels = month)) %>% 
      ggplot(aes(x = mes, total)) +
        geom_col(color = "#9e0007", fill = "#c4000d", show.legend = FALSE) +
        scale_y_continuous(breaks = seq(from = 0, to = 6000, by = 500))  +
        labs(x = "Mês", y = "Total de queimadas", title = "") +
        theme_minimal()
    
    ggplotly(plot)
  })
  
}