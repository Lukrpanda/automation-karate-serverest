Feature: Listar usuarios - Validación Data Driven

  Background:
    * url 'https://serverest.dev'
    * path '/usuarios'
    
    
    * def allParams = read('usuarios/jsonBody/listar_params.json')
    * def allResponses = read('usuarios/jsonResponse/listar_respuesta_esperada.json')
    * def allSchemas = read('usuarios/jsonSchema/listar_esquema_esperado.json')

  Scenario Outline: Validar busqueda de usuarios - Escenario: <descripcion>
    
    * def currentParams = allParams[<index>]
    * def currentResponse = allResponses[<index>]
    * def currentSchema = allSchemas[<index>]

    Given params currentParams
    When method get
    Then status <code>
    
    And match response == currentSchema
    And match response == currentResponse
    
    And print 'Usuarios encontrados (Cantidad): ', response.quantidade

    Examples:
      | index | code | descripcion                                      |
      | 0     | 200  | "Positivo - Busqueda con multiples filtros exactos"|
      | 1     | 200  | "Positivo - Busqueda sin resultados (quantidade: 0)" |
      | 2     | 200  | "Positivo - Busqueda general (Solo Administradores)" |