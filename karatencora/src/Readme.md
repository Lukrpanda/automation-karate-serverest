# Automatización de API REST - ServeRest (Karate DSL)

Este repositorio contiene la automatización de pruebas E2E (End-to-End) para la API REST simulada [ServeRest](https://serverest.dev/). El proyecto cubre el flujo completo CRUD (Crear, Leer, Actualizar y Borrar) para el módulo de **Usuarios**.

---

## ⚙️ 1. Requisitos Previos (Configuración)

Para poder ejecutar este proyecto en tu máquina local, necesitas tener instalado lo siguiente:

*   **Java Development Kit (JDK):** Versión 11 o superior.
*   **Apache Maven:** Gestor de dependencias y ejecución de ciclo de vida.
*   **IDE Recomendado:** Visual Studio Code (con la extensión de Karate/Cucumber) o IntelliJ IDEA.
*   **Git:** Para clonar el repositorio.

---

## 🚀 2. Instrucciones de Ejecución

Sigue estos pasos para ejecutar la suite de pruebas:

1.  **Clonar el repositorio:**
    ```bash
    git clone <URL_DE_TU_REPOSITORIO_AQUI>
    cd <NOMBRE_DE_LA_CARPETA>
    ```

2.  **Ejecutar todas las pruebas:**
    Desde la terminal, en la raíz del proyecto (donde se encuentra el archivo `pom.xml`), ejecuta el siguiente comando de Maven:
    ```bash
    mvn clean test
    ```

3.  **Ejecutar una prueba específica (Opcional):**
    Si deseas ejecutar un solo feature (por ejemplo, el registro de usuarios), puedes usar:
    ```bash
    mvn clean test -Dtest=KarateRunner "-Dkarate.options=classpath:usuarios/RegistrarUsuarios.feature"
    ```

4.  **Revisar los Reportes:**
    Una vez finalizada la ejecución, Karate generará un reporte HTML detallado. Puedes abrirlo en tu navegador web navegando a:
    `target/karate-reports/karate-summary.html`

---

## 📊 3. Informe de Estrategia de Automatización y Patrones

Para este proyecto, se ha diseñado una arquitectura escalable y de fácil mantenimiento centrada en la separación de responsabilidades y la reutilización de código.

### Patrón Principal: Data-Driven Testing (DDT) con JSON Arrays
Se ha implementado un enfoque fuertemente basado en **Data-Driven Testing (Pruebas Basadas en Datos)**. En lugar de quemar (*hardcodear*) los datos dentro de los archivos `.feature`, se externalizó toda la información en archivos JSON estructurados como arreglos (`[{}, {}]`).

**¿Cómo funciona?**
1.  **Archivos JSON Modulares:** Por cada endpoint, existen archivos JSON dedicados para el `Body` (Petición), la `Response` (Respuesta esperada) y el `Schema` (Contrato esperado).
2.  **Manejo por Índices:** La tabla de `Examples` en los escenarios de Karate actúa como el motor de ejecución. Se pasa un `<index>` (0, 1, 2...) que extrae dinámicamente el conjunto de datos exacto que le corresponde a ese escenario desde los arreglos JSON.

### Estrategias de Validación
*   **Validación de Contrato (Schema Validation):** Cada petición verifica estrictamente que los tipos de datos devueltos por la API (Strings, Numbers, Arrays) cumplan con la documentación OpenAPI/Swagger de ServeRest mediante Fuzzy Matchers (`#string`, `#number`).
*   **Validación Lógica (Business Rules):** Se verifica el contenido exacto de las respuestas, asegurando el manejo correcto de códigos HTTP (200, 201, 400) tanto para "Happy Paths" (creaciones exitosas) como para "Unhappy Paths" (intentos de duplicación de correos, IDs inexistentes).

### Beneficios de esta Arquitectura
1.  **Mantenibilidad:** Si la API cambia o se agregan nuevos escenarios (ej. un nuevo caso de error), **no se toca el código de Karate (`.feature`)**. Solo se agrega un nuevo objeto al arreglo JSON y una fila a la tabla de `Examples`.
2.  **Código Limpio (DRY):** El uso de `Background` permite cargar las variables de entorno y leer los archivos JSON una sola vez por feature, manteniendo el `Scenario Outline` enfocado únicamente en los pasos transaccionales HTTP.
3.  **Legibilidad:** Las tablas de `Examples` incluyen una columna de `descripcion` que documenta claramente la intención de la prueba, haciendo que los reportes generados sean comprensibles para perfiles técnicos y de negocio.