
library(shiny)
library(bslib)

# --------------------------------------------------
# CONFIGURACION GENERAL
# --------------------------------------------------

ui <- page_sidebar(
  
  title = div(
    class = "brand",
    span(class = "brand-icon", "🌱"),
    span("Raíz")
  ),
  
  theme = bs_theme(
    version = 5,
    bg = "#FBF8F0",
    fg = "#514638",
    primary = "#C54F2D",
    secondary = "#94B38A",
    success = "#657E50",
    base_font = font_google("Nunito"),
    heading_font = font_google("Quicksand")
  ),
  
  sidebar = sidebar(
    width = "255px",
    open = "always",
    
    div(
      class = "sidebar-heading",
      "MENU PRINCIPAL"
    ),
    
    actionButton(
      "inicio", "Inicio",
      icon = icon("house"),
      class = "menu-button active"
    ),
    
    actionButton(
      "cultivos", "Mis cultivos",
      icon = icon("seedling"),
      class = "menu-button"
    ),
    
    actionButton(
      "terreno", "Mi terreno",
      icon = icon("map-pin"),
      class = "menu-button"
    ),
    
    actionButton(
      "clima", "Clima y agua",
      icon = icon("cloud-sun"),
      class = "menu-button"
    ),
    
    actionButton(
      "rotaciones", "Rotaciones",
      icon = icon("chart-line"),
      class = "menu-button"
    ),
    
    hr(),
    
    div(
      class = "sidebar-footer",
      "Una agricultura más sostenible comienza con mejores decisiones."
    )
  ),
  
  tags$head(
    tags$link(
      rel = "stylesheet",
      type = "text/css",
      href = "styles.css"
    )
  ),
  
  uiOutput("contenido")
)


# --------------------------------------------------
# SERVIDOR
# --------------------------------------------------

server <- function(input, output, session) {
  
  pagina_actual <- reactiveVal("inicio")
  
  # Navegacion entre paginas
  
  observeEvent(input$inicio, {
    pagina_actual("inicio")
  })
  
  observeEvent(input$cultivos, {
    pagina_actual("cultivos")
  })
  
  observeEvent(input$terreno, {
    pagina_actual("terreno")
  })
  
  observeEvent(input$clima, {
    pagina_actual("clima")
  })
  
  observeEvent(input$rotaciones, {
    pagina_actual("rotaciones")
  })
  
  
  # Actualizar contenido
  
  output$contenido <- renderUI({
    
    switch(
      
      pagina_actual(),
      
      # ------------------------------------------
      # INICIO
      # ------------------------------------------
      
      inicio = div(
        class = "main-content",
        
        div(
          class = "welcome-banner",
          
          div(
            class = "welcome-text",
            
            span(
              class = "eyebrow",
              "BIENVENIDO A RAÍZ"
            ),
            
            h1(
              "Cultiva un futuro más sostenible."
            ),
            
            p(
              "Conoce las condiciones de tu terreno y descubre nuevas posibilidades para tus cultivos."
            ),
            
            actionButton(
              "comenzar",
              "Comenzar mi análisis",
              icon = icon("arrow-right"),
              class = "primary-button"
            )
          ),
          
          div(
            class = "welcome-decoration",
            "🌾"
          )
        ),
        
        h3("Explora tu campo"),
        
        p(
          class = "section-description",
          "Encuentra las herramientas que necesitas."
        ),
        
        div(
          class = "feature-grid",
          
          div(
            class = "feature-card",
            icon("seedling", class = "feature-icon"),
            h4("Mis cultivos"),
            p("Consulta las características de los cultivos de Sinaloa.")
          ),
          
          div(
            class = "feature-card",
            icon("map-location-dot", class = "feature-icon"),
            h4("Mi terreno"),
            p("Registra las condiciones de tu parcela.")
          ),
          
          div(
            class = "feature-card",
            icon("cloud-sun", class = "feature-icon"),
            h4("Clima y agua"),
            p("Explora las condiciones ambientales de tu región.")
          ),
          
          div(
            class = "feature-card",
            icon("chart-line", class = "feature-icon"),
            h4("Rotaciones"),
            p("Compara diferentes estrategias para tus cultivos.")
          )
        ),
        
        div(
          class = "info-banner",
          h4("Cada terreno es diferente."),
          
          p(
            "Raíz utiliza información agrícola y ambiental para ayudarte a explorar alternativas que favorezcan la salud del suelo y la resiliencia de tu producción."
          )
        )
      ),
      
      
      # ------------------------------------------
      # CULTIVOS
      # ------------------------------------------
      
      cultivos = div(
        class = "main-content",
        
        h1("Mis cultivos"),
        
        p(
          class = "section-description",
          "Explora los cultivos registrados para el estado de Sinaloa."
        ),
        
        div(
          class = "search-container",
          
          textInput(
            "buscar_cultivo",
            label = NULL,
            placeholder = "Buscar un cultivo..."
          )
        ),
        
        uiOutput("catalogo")
      ),
      
      
      # ------------------------------------------
      # TERRENO
      # ------------------------------------------
      
      terreno = div(
        class = "main-content",
        
        h1("Mi terreno"),
        
        p(
          class = "section-description",
          "Registra la información de tu parcela para personalizar el análisis."
        ),
        
        div(
          class = "form-card",
          
          h3("Información general"),
          
          textInput(
            "municipio",
            "Municipio de Sinaloa",
            placeholder = "Ej. Culiacán"
          ),
          
          numericInput(
            "superficie",
            "Superficie de la parcela (hectáreas)",
            value = 1,
            min = 0
          ),
          
          selectInput(
            "tipo_suelo",
            "Tipo de suelo",
            choices = c(
              "Seleccionar",
              "Arenoso",
              "Arcilloso",
              "Limoso",
              "Franco",
              "Franco-arenoso",
              "Franco-arcilloso",
              "Otro"
            )
          ),
          
          selectInput(
            "riego",
            "Disponibilidad de agua",
            choices = c(
              "Seleccionar",
              "Abundante",
              "Moderada",
              "Limitada"
            )
          ),
          
          actionButton(
            "guardar_terreno",
            "Guardar información",
            class = "primary-button"
          )
        )
      ),
      
      
      # ------------------------------------------
      # CLIMA
      # ------------------------------------------
      
      clima = div(
        class = "main-content",
        
        h1("Clima y agua"),
        
        p(
          class = "section-description",
          "Consulta las condiciones ambientales de tu región."
        ),
        
        div(
          class = "empty-state",
          
          icon("cloud-sun", class = "empty-icon"),
          
          h3("Información ambiental"),
          
          p(
            "Aquí mostraremos temperatura, precipitación, humedad del suelo y tendencias climáticas utilizando datos de NASA."
          )
        )
      ),
      
      
      # ------------------------------------------
      # ROTACIONES
      # ------------------------------------------
      
      rotaciones = div(
        class = "main-content",
        
        h1("Estrategias de rotación"),
        
        p(
          class = "section-description",
          "Explora diferentes alternativas para mejorar la salud de tu suelo."
        ),
        
        div(
          class = "empty-state",
          
          icon("sprout", class = "empty-icon"),
          
          h3("Descubre nuevas posibilidades"),
          
          p(
            "Aquí podrás comparar tu rotación actual con dos estrategias alternativas."
          )
        )
      )
    )
  })
  
  
  # Accion del boton principal
  
  observeEvent(input$comenzar, {
    pagina_actual("terreno")
  })
  
  
  # Guardar terreno (provisional)
  
  observeEvent(input$guardar_terreno, {
    
    showNotification(
      "Información capturada. La conexión con la base de datos se implementará después.",
      type = "message"
    )
    
  })
  
  
  # Catalogo provisional
  
  cultivos_demo <- c(
    "Maíz",
    "Trigo",
    "Garbanzo",
    "Soya",
    "Frijol",
    "Tomate",
    "Chile",
    "Sorgo"
  )
  
  output$catalogo <- renderUI({
    
    busqueda <- input$buscar_cultivo
    
    cultivos_filtrados <- cultivos_demo
    
    if (!is.null(busqueda) && nzchar(busqueda)) {
      cultivos_filtrados <- cultivos_demo[
        grepl(
          busqueda,
          cultivos_demo,
          ignore.case = TRUE
        )
      ]
    }
    
    if (length(cultivos_filtrados) == 0) {
      
      return(
        div(
          class = "empty-state",
          "No se encontraron cultivos."
        )
      )
      
    }
    
    div(
      class = "crop-grid",
      
      lapply(cultivos_filtrados, function(cultivo) {
        
        div(
          class = "crop-card",
          
          div(
            class = "crop-placeholder",
            icon("leaf")
          ),
          
          h4(cultivo),
          
          p("Consultar información"),
          
          actionButton(
            paste0(
              "cultivo_",
              make.names(cultivo)
            ),
            "Ver detalles",
            class = "secondary-button"
          )
        )
        
      })
    )
    
  })
  
}


# --------------------------------------------------
# EJECUTAR APLICACION
# --------------------------------------------------

shinyApp(ui = ui, server = server)
