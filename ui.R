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
      title = "Tab 1",
      icon = "desktop",
      active = TRUE,
      sliderInput(
        "obs",
        "Number of observations:",
        min = 0, max = 1000, value = 500
      )
    ),
    rightSidebarTabContent(
      id = 2,
      title = "Tab 2",
      textInput("caption", "Caption", "Data Summary")
    ),
    rightSidebarTabContent(
      id = 3,
      icon = "paint-brush",
      title = "Tab 3",
      numericInput("obs", "Observations:", 10, min = 1, max = 100)
    )
  )
)