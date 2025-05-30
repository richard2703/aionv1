# AION Business 

Una breve descripción de lo que hace tu proyecto. 

## Requisitos

### Backend (Laravel 11)
- PHP >= 8.0
- Composer
- MySQL 
- Extensiones de PHP: `curl`, `fileinfo`, `gd`, `gettext`, `mbstring`, `exif`, `mysqli`, `pdo_mysql`, `pdo_sqlite`, `zip`.
- Node.js >= 14.x

### Frontend (Vue.js)
- Node.js >= 18.x
- NPM >= 6.x 
- Vue 3
- Inertia.js 
- PrimeVue 

## Instalación local
### Clonar el repositorio

```bash
git clone https://github.com/richard2703/aion.git
cd aion
```
### Configuración del Backend
Instalar dependencias de PHP:
```bash
composer install
```
Copiar el archivo de configuración .env.example a .env:
```bash
cp .env.example .env
```
importar la base de datos del archivo dump en raiz del proyecto "ams_aion.sql"

Configurar las variables de entorno en el archivo .env (base de datos, servidor de correos, etc.).

Generar la clave de la aplicación:
```bash
php artisan key:generate
```

Generar un enlace simbólico al almacenamiento de la aplicación:
```bash
php artisan storage:link
```
### Configuración del Frontend
Instalar dependencias de NPM:
```bash
npm install

```
## Ejecutar en modo desarrollo
Compilar los assets del frontend y ejecutar el backend de laravel:
```bash
npm run serve-all

```
