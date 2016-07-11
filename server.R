library(shiny)

# model coeficients
int    <- -0.06
lnpre  <-  1.44
lnpre2 <- -0.41
wt     <-  0.67
temp   <-  0.23
prod   <- -2.01
prXlnp <-  1.07
prXwt  <- -2.01

# centering values
avg_lnpre <- -2.460663
avg_wt    <-  1.818396
avg_temp  <- 11.48808


shinyServer(
  function(input, output) {
    
    
    output$text1 <- renderTable({ 

      oxy  <- as.numeric(ifelse(input$product == "Oxytetracycline", 1, 0))
      pred <- int + 
        (lnpre  * (log(input$mortality) - avg_lnpre)) +
        (lnpre2 * (log(input$mortality) - avg_lnpre) ^ 2) + 
        (wt * (input$weight - avg_wt)) + 
        (temp * (input$temperature - avg_temp)) + 
        (prod * oxy) + 
        (prXlnp * oxy * (log(input$mortality) - avg_lnpre)) + 
        (prXwt * oxy * (input$weight - avg_wt))
    
      or <- exp(pred)
    
      prob <- (or / (1 + or)) * 100
      
      tab <- data.frame(Scale = c("Logit", "Odds ratio", "Probabilidad"),
                        Value = c(pred, or, prob))
      tab
    })
    
  }
)
