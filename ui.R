source("./ui/header.R")
source("./ui/sidebar.R")
source("./ui/body.R")


ui <- dashboardPagePlus(
  title = "Queimadas nas Florestas",
  header,
  sidebar,
  body,
  
  rightsidebar = shinydashboardPlus::rightSidebar(
    background = "dark",
    rightSidebarTabContent(
      id = 1,
      title = "Dataset",
      icon = "database",
      active = TRUE,
      p(style="font-style: italic", "Os dados utilizados nesse dashboad foram encontrados no site",
        a(href="https://www.kaggle.com/gustavomodelli/forest-fires-in-brazil", "kaggle"), "."),
    )
  )
)