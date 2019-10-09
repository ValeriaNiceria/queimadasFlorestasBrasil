body = shinydashboard::dashboardBody(
  tags$head(
    tags$link(rel="stylesheet", type="text/css", href="css/style.css")
  ),
  tags$script(
    HTML('
      $(document).ready(function() {
        $("body").addClass("sidebar-collapse");
      })
    ')
  )
)
