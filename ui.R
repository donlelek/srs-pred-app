library(shiny)

shinyUI(fluidPage(
  titlePanel("Predicción de falla de tratamiento"),
  
  sidebarLayout(
    sidebarPanel(
      helpText("Esta aplicación le ayudara a obtener una predicción de probabilidad de falla de tratamiento basada en el modelo publicado en el articulo adjunto"),
      
      selectInput("product", 
                  label = "Elija uno de los principios activos",
                  choices = c("Florfenicol", "Oxytetracycline"),
                  selected = "Florfenicol"),
      
      sliderInput("mortality", 
                  label = "Mortalidad semanal promedio ultimas 3 semanas",
                  min = 0, max = 5, value = 0.1, step = 0.01),
      
      sliderInput("weight", 
                  label = "Peso promedio de los peces al inicio del tratamiento",
                  min = 0.1, max = 4, value = 1, step = 0.1),
      
      sliderInput("temperature", 
                  label = "Temperatura promedio del agua al inicio del tratamiento",
                  min = 5, max = 20, value = 10, step = 0.5)
      ),
    
    mainPanel(
      tableOutput("text1"),
      p("Este modelo predice la probabilidad de que un tratamiento contra piscirickettsiosis
        falle, es decir que el promedio de la mortalidad de las 3 semanas después de terminado el 
        tratamiento esté por sobre un 0.1%."),
        
      strong("Notas:"),
      
      p("Las predicciones aquí calculadas corresponden a la porción fija del modelo publicado 
        por Price et al. (2016),
        por lo que son específicas para el centro para el cual se está ingresando datos.
        En el caso de Odds ratio, esto quiere decir que siempre el resultado es relativo a 
        una jaula del mismo centro, con una mortalidad semanal promedio de 0.085% 
        en las anteriores 3 semanas,
        con peces de 1.82 kg, temperatura promedio semanal de agua de 11.5°C
        y tratada con florfenicol."),
      
      p("En el caso de la probabilidad la interpretación no es relativa a otras jaulas pero si se asume
        que el centro tiene un desempeño sanitario igual al promedio del desempeño de los centros del estudio."),
        
      p("Las predicciones son aplicables al primer tratamiento de un centro en el que se 
        cultiva salmon del Atlántico"),
        
      p("En los datos con los cuales se entrenó el modelo, no existen tratamientos con oxitetraciclina
        por sobre los 2.5 kg por lo que se recomienda no utilizar el modelo en peces de mayor peso si 
        el producto a utilizar es oxitetraciclina."),
      
      h2("Bibliografía"),  
      a(href = "http://www.int-res.com/abstracts/dao/v118/n3/p227-235/", 
        "Price D, Stryhn H, Sánchez J, Ibarra R, Tello A, St-Hilaire S (2016) 
        Retrospective analysis of antibiotic treatments against piscirickettsiosis in farmed Atlantic 
        salmon Salmo salar in Chile. Dis Aquat Org 118:227-235"),
      p(""),
      a(href = "mailto:dprice@upei.ca", "Solicite el artículo"),
      p(""),
      a(href = "https://github.com/donlelek/srs-pred-app/issues", "Algo no funciona?, Deje un comentario en la web de desarrollo del proyecto")
      
    )
  )
))
