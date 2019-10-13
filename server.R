server <- function(input, output, server) {
  
  queimadas_anos <- reactive({
      dados %>% 
      group_by(year) %>% 
      summarise(total_queimadas = sum(number)) 
  })
  
  output$graf_queimadas_anos <- renderHighchart({
    queimadas_anos() %>% 
      hchart(type = "line", name = "Total queimadas durante o ano", hcaes(x = year, y = total_queimadas)) %>% 
      hc_xAxis(title = list(text = "Ano")) %>% 
      hc_yAxis(title = list(text = "Total de queimadas")) %>% 
      hc_colors(c("#9b0000"))
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
  
  output$graf_queimadas_ano_selected <- renderHighchart({
    queimadas_ano_selecionado() %>% 
      hchart(type = "line", name = "Total queimadas durante o mês", hcaes(x = month, y = total)) %>% 
      hc_xAxis(title = list(text = "Mês")) %>% 
      hc_yAxis(title = list(text = "Total de queimadas")) %>% 
      # hc_title(text = "Queimadas durante o ano") %>% 
      hc_colors(c("#9b0000"))
  })

  
  queimadas_estados_total <- reactive({
    
    if (input$select_ano_queimada_estado != "Geral") {
      dados <- dados %>% 
        filter(year == input$select_ano_queimada_estado)
    }

    dados %>% 
      left_join(uf_state) %>% 
      group_by(UF) %>% 
      summarise(total = sum(number)) %>% 
      mutate(UF = as.character(UF))
  })
  
  output$graf_map_queimadas_totais <- renderHighchart({
    queimadas_estados_total <- queimadas_estados_total()
    hcmap("countries/br/br-all", data = queimadas_estados_total, value = "total",
          joinBy =  c("hc-a2", "UF"), name= "Total de queimadas",
          dataLabels = list(enabled = TRUE, format = '{point.code}'),
          tooltip = list(valueDecimals = 2, valuePrefix = "")) %>%
      hc_colorAxis(minColor = "#FEE4D7", maxColor = "#9b0000") %>% 
      hc_credits(enabled = FALSE)
  })
  
  output$graf_queimadas_estado_ano_selected <- renderHighchart({
    queimadas_estados_total() %>% 
      left_join(uf_state) %>% 
      arrange(desc(total)) %>% 
      hchart(type = "bar", name = "Total queimadas durante", hcaes(x = state, y = total)) %>% 
      hc_xAxis(title = list(text = "Estado")) %>% 
      hc_yAxis(title = list(text = "Total de queimadas")) %>% 
      hc_colors(c("#9b0000"))
  })
  
  
}