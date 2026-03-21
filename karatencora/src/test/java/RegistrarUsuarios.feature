Feature: Registrar Usuarios - Validación de API REST

Background:
    * url "https://serverest.dev"
    * path "/usuarios"
    
   
    * def allRequests = read('usuarios/jsonBody/usuario_body.json')
    * def allResponses = read('usuarios/jsonResponse/respuesta_esperada.json')
    * def allSchemas = read('usuarios/jsonSchema/esquema_esperado.json')

  Scenario Outline: Validar creacion de usuario - Escenario: <descripcion>
    
    
    * def currentRequest = allRequests[<index>]
    * def currentResponse = allResponses[<index>]
    * def currentSchema = allSchemas[<index>]
    
    Given request currentRequest
    When method post
    Then status <code>
    
   
    And match response == currentSchema
    
   
    And match response == currentResponse
    
   
    And print 'Respuesta del servidor:', response

    Examples:
      | index | code | descripcion                                      | 
      | 0     | 201  | "Positivo - Crear usuario valido"                |
      | 1     | 400  | "Negativo - Correo ya utilizado (Duplicado)"     |
      | 2     | 400  | "Negativo - Falta campo obligatorio (Email)"     |