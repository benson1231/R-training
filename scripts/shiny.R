install.packages("shiny")
library(shiny)

# 定義 UI
ui <- fluidPage(
  titlePanel("📊 簡單的 Shiny 互動範例"),
  sidebarLayout(
    sidebarPanel(
      sliderInput("obs", "選擇樣本數：", 
                  min = 10, max = 1000, value = 100),
      selectInput("dist", "選擇分佈：", 
                  choices = c("Normal" = "rnorm", 
                              "Uniform" = "runif",
                              "Exponential" = "rexp"))
    ),
    mainPanel(
      plotOutput("distPlot"),
      verbatimTextOutput("summary")
    )
  )
)

# 定義 Server 邏輯
server <- function(input, output) {
  data <- reactive({
    func <- match.fun(input$dist)
    func(input$obs)
  })
  
  output$distPlot <- renderPlot({
    hist(data(), col = "skyblue", border = "white", main = "資料分佈")
  })
  
  output$summary <- renderPrint({
    summary(data())
  })
}

# 啟動 Shiny App
shinyApp(ui, server)
