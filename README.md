# PruebaTecnicaAPISofka
Repositorio con la prueba tecnica para el Rol de QA en Sofka

Descripción
-----------
Suite de pruebas automatizadas para la API pública "Swagger PetStore" usando Karate DSL.
Incluye features para crear, actualizar y buscar mascotas, datos de prueba en /data y runners para ejecución local/CI.

Tecnologías / versiones recomendadas
-----------------------------------
- Java: 17
- Maven: 3.6+
- Karate: 1.5.0
- JUnit 5 (Karate JUnit5)
- (Opcional para mocks) WireMock: 2.35.0
- IDE recomendado: IntelliJ IDEA

Estructura del proyecto
-----------------------
/ (raíz del proyecto)
├─ pom.xml
├─ .gitignore
├─ .github/
│   └─ workflows/karate-ci.yml        # (workflow CI opcional)
├─ src/
│   └─ test/
│       ├─ java/
│       │   └─ com/                    # runners Java (TestRunner, PetRunner si aplica)
│       └─ resources/
│           └─ com/
│               └─ petstore/
│                   ├─ data/           # JSON de request (create_modify_pet_request.json ...)
│                   ├─ create_pet.feature
│                   ├─ search_pet.feature
│                   └─ update_pet.feature
└─ target/
└─ karate-reports/karate-summary.html

Pasos para ejecutar localmente (rápido)
---------------------------------------
1. Clonar el repo:
   git clone https://github.com/hernandomolina/pruebaTecnicaAPISofka.git
   

2. Ejecutar todos los tests (Maven):
   mvn clean test

    - Los reportes HTML se generan en:
      target/karate-reports/karate-summary.html
    - Abre ese archivo en tu navegador para ver el reporte visual.

3. Ejecutar un feature específico:
   mvn test -Dkarate.options="classpath:com/petstore/create_pet.feature"

4. Ejecutar desde IntelliJ:
    - Importa el proyecto Maven.
    - Ejecuta la clase `com.TestRunner` (o la clase runner que tengas) con clic derecho → Run.
    - O correr una sola clase runner `PetRunner` (si la usas).

5. Ejecutar con paralelismo (desde runner Java):
    - El runner `TestRunner` usa `.parallel(n)`; ajusta `n` según tu CPU.

Ejecución en CI / GitHub Actions
--------------------------------
- Coloca el workflow en: `.github/workflows/karate-ci.yml`
- Ejemplo básico: (el workflow ejecutará `mvn clean test` y publicará los reportes a GitHub Pages si está configurado)
- Tras la ejecución, puedes descargar los reportes desde los artifacts del job o verlos mediante GitHub Pages si publicaste `target/karate-reports/`.

Buenas prácticas / notas
------------------------
- Evita IDs estáticos al probar contra la API pública: genera IDs únicos (Math.random() o timestamp).
- Para suites estables en CI, usa WireMock (mock server) o Testcontainers para no depender de la API pública.
- Mantén los payloads JSON en `src/test/resources/.../data/` y carga con: `read('data/create_modify_pet_request.json')`.
- Usa `call`/`callonce` para setup reutilizable entre features (crear datos iniciales).

