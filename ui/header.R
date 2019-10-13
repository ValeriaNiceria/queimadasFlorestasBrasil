header = shinydashboardPlus::dashboardHeaderPlus(
  title = tagList(
    span(class = "logo-lg", "Queimadas"), 
    img(
      class="logo-mini", 
      style="width: 42px; margin-left: -10px; margin-top: 10px;", 
      src = "img/arvore.svg"
    )
  ),
  enable_rightsidebar = TRUE,
  rightSidebarIcon = "info-circle"
)