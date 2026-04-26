# IMS (Inventory Management System)

IMS is a web application for tracking devices, assignments, issues, and reports in one place.

## Project Name
- IMS
- Meaning: Inventory Management System

## SysAdmin Credentials
- Username: 24RP07206
- Password: 24RP02943

## Project Structure Highlights
- `src/main/java`: Spring Boot application code (controllers, services, models, repositories)
- `src/main/resources/templates`: Thymeleaf UI pages
- `src/main/resources/application.properties`: app and database configuration
- `ims.sql`: database seed file for SysAdmin account
- `data/`: local H2 file database storage

## Setup Instructions
1. Install Java 17+ and Maven (or use the included Maven wrapper files).
2. From the project root, run:
   - Windows PowerShell: `./mvnw.cmd spring-boot:run`
3. Open browser:
   - `http://localhost:8080/`

If port 8080 is busy, run on another port:
- `./mvnw.cmd spring-boot:run "-Dspring-boot.run.arguments=--server.port=8081"`
- Then open `http://localhost:8081/`

## How To Navigate IMS
1. Open the login page (`/login`) and sign in with the SysAdmin credentials above.
2. Dashboard (`/dashboard`): view overview metrics.
3. Devices (`/devices`): register, view, edit, search, and filter devices.
4. Assignments (`/assignments`): assign devices, track active assignments, and returns.
5. Issues (`/issues`): report, view, filter, and resolve issues.
6. Reports (`/reports`): open device, assignment, issue, inventory status, and audit reports.

## Database Seed Notes
- The application seeds the SysAdmin account at startup through application initialization.
- You can also apply `ims.sql` manually on an H2 database to insert/update the SysAdmin record.

## Submission Requirements Coverage
- Live app login credentials are fixed to: `24RP07206` / `24RP02943`
- Developer details are displayed on the landing/login page and dashboard footer.

## Deploy To Azure App Service (Public URL)
These steps publish your app and produce a public domain such as:
- `https://ims-demo-xxxxx.azurewebsites.net`

### 1) Build the app
- `./mvnw.cmd clean package -DskipTests`

### 2) Install and sign in to Azure CLI
- Install: https://learn.microsoft.com/cli/azure/install-azure-cli-windows
- Login: `az login`

### 3) Create resource group and App Service (free/basic dev-friendly setup)
Replace names with your own unique values.

- `az group create --name ims-rg --location eastus`
- `az appservice plan create --name ims-plan --resource-group ims-rg --sku B1 --is-linux`
- `az webapp create --resource-group ims-rg --plan ims-plan --name ims-demo-UNIQUE123 --runtime "JAVA|17-java17"`

### 4) Deploy the jar
- `az webapp deploy --resource-group ims-rg --name ims-demo-UNIQUE123 --src-path target/ims-0.0.1-SNAPSHOT.jar --type jar`

### 5) Open and copy live URL for submission
- `https://ims-demo-UNIQUE123.azurewebsites.net/login`

### Optional: Attach your own custom domain
If you bought a domain, map it in App Service:
- Azure Portal -> your Web App -> Custom domains -> Add custom domain

For lecturer submission, the default Azure domain (`*.azurewebsites.net`) is already a valid public URL.
