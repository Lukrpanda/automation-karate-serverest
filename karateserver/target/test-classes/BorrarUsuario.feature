Feature: Borrar usuarios - Validación Data Driven

  Background:
    * url 'https://serverest.dev'
    
    * def allResponses = read('usuarios/jsonResponse/borrar_respuesta.json')
    * def allSchemas = read('usuarios/jsonSchema/borrar_esquema.json')

  Scenario Outline: Validar borrado de usuario - Escenario: <descripcion>
    
    * def currentResponse = allResponses[<index>]
    * def currentSchema = allSchemas[<index>]

    Given path 'usuarios', idUsuario
    When method delete
    Then status <code>
    
    And match response == currentSchema
    And match response == currentResponse
    
    And def respuestaBorrado = response
    And print 'Resultado de la operacion DELETE: ', respuestaBorrado

    Examples:
      | index | code | idUsuario        | descripcion                                              |
      | 0     | 200  | 8Jzo05lflB2u38Pr | "Positivo - Borrar usuario exitosamente"                 |
      | 1     | 200  | idFalso123456789 | "Positivo - ID no existe (Nenhum registro excluido)"     |