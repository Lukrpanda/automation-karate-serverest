Feature: Actualizar usuarios - Validación Data Driven

  Background:
    * url "https://serverest.dev"
    
    * def allRequests = read('usuarios/jsonBody/actualizar_body.json')
    * def allResponses = read('usuarios/jsonResponse/actualizar_respuesta.json')
    * def allSchemas = read('usuarios/jsonSchema/actualizar_esquema.json')

  Scenario Outline: Validar actualizacion de usuario - <descripcion>
    
    * def currentRequest = allRequests[<index>]
    * def currentResponse = allResponses[<index>]
    * def currentSchema = allSchemas[<index>]

    Given path 'usuarios', idUsuario
    And request currentRequest
    When method put 
    Then status <code> 
    

    And match response == currentSchema
    And match response == currentResponse
    
    And print 'Respuesta de actualizacion:', response

    Examples:
      | index | code | idUsuario          | descripcion                                              | 
      | 0     | 200  | zaWDqzWrSQ6uTTOi   | "Positivo - Modificar usuario existente"                 |
      | 1     | 201  | idInventado12345   | "Positivo - Crear usuario por PUT si ID no existe"       |
      | 2     | 400  | idInventado12346   | "Negativo - Intento de actualizar con email ya en uso"   |

