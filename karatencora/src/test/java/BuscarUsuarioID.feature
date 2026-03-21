Feature: Buscar usuario por ID - Validación Data Driven

  Background:
    * url 'https://serverest.dev'
    
    
    * def allResponses = read('usuarios/jsonResponse/buscar_id_respuesta.json')
    * def allSchemas = read('usuarios/jsonSchema/buscar_id_esquema.json')

  Scenario Outline: Validar busqueda por ID - Escenario: <descripcion>
    
    * def currentResponse = allResponses[<index>]
    * def currentSchema = allSchemas[<index>]

    Given path 'usuarios', idUsuario
    When method get
    Then status <code>
    
    And match response == currentSchema
    And match response == currentResponse

    And print 'Resultado de la busqueda:', response

    Examples:
      | index | code | idUsuario        | descripcion                                |
      | 0     | 200  | 1JkAEyjWfRwojXnD | Positivo - Usuario encontrado exitosamente |
      | 1     | 400  | idFalso123456789 | Negativo - Usuario no encontrado           |