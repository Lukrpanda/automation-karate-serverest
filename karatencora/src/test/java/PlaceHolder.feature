Feature:

Scenario Outline: listar usuarios 
    Given url 'https://jsonplaceholder.typicode.com' 
    And path '/users/2'
    When method get
    Then status <code>
    And def authToken = response;
    And print 'Se capturo el token: ' ,authToken

    Examples:

        | code |
        | 200  |

Scenario Outline: crear usuarios
    Given url "https://jsonplaceholder.typicode.com"
    And  path "/posts"
    And request
    """
        {
         "userId": 87345345,
         "title": "te quiero melisa",
         "body": "todo todo todo "
        }
        
    """
    When method post
    Then status <code>
    And def respuesta = response;
    And print 'Se creo el usuario: ',respuesta

    Examples:

        | code |
        | 201   |

