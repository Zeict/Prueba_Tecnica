# Prueba Tecnica

Es un sistema Frontend/Backend que cuenta con los siguientes modulos:
- Login
  - Validación de usuario
- Menu (Solo se muestra una vez que se valida el usuario)
  - Inicio
  - Consultar Alumnos
  - Agregar Alumnos
  - LogOut

## Instalación

Se requiere Visual Studio(Asp.NET/C#) y MSSQL Express Version 13.0
- Restaurar base de datos en MSSQL `dbAlumnos.bak`
- En Visual Studio -> Abrir -> Sitio Web y buscamos la carpeta contenedora del proyecto y la seleccionamos. (Prueba_Tecnica).
- Buscar archivo `Web.Config` donde se editara la siguiente cadena de conexión a base de datos.
```bash
<add name="Connection" connectionString="Data Source= ;Initial Catalog=dbAlumnos;Integrated Security=True; User ID=sa;Password=123" providerName="System.Data.SqlClient"/>
```
## Uso
- Cuando el proyecto ya se ha abierto en Visual Studio y la base de datos ya este restaurada buscamos archivo `Login.aspx` en el explorador de soluciones, lo establecemos como pagina inicial y proseguimos a depurar el proyecto.

### Login
- Una vez depurado el proyecto aparecerá el login el cual cuenta con validación de usuario y roles de usuario para el acceso al siguiente menú.
    - Usuario para acceder: `zeict` y su contraseña: `2210`. El sistema cuenta con encriptación de contraseña.
### Menú principal
- Al acceder nos muestra una pagina de inicio donde nos da la bienvenida, un navbar a la izquierda que tiene como opciones agregar, consultar o cerrar sesión, también podemos ocultar este menú y 2 opciones para ir al modulo de agregar alumnos o consultar alumnos.

### Agregar Alumnos
- En este apartado tenemos un formulario el cual nos permitirá añadir a nuevos alumnos a nuestra base de datos, cada uno de los campos son requeridos para poder registrar a un nuevo alumno, en caso de faltar o tener un formato incorrecto, el sistema mostrara una advertencia.
- Una vez que se agregan nuevos alumnos a la base de datos, este nos mostrara automáticamente a los alumnos registrados en la tabla que se muestra a la derecha del formulario. Esta tabla puede imprimirse, exportarse a PDF o buscar alumnos por cualquier campo.
- Si seleccionamos al alumno en la tabla, nos pasara los datos nuevamente hacia el formulario para así poder editar o actualizar al alumno en caso de error. También podemos eliminar al alumno seleccionándolo en la tabla.

### Consultar Alumnos
- En esta opción del menú nos mostrara una tabla con todos los alumnos que ya hayan sido registrados anteriormente y de igual forma podemos realizar búsquedas por campo, exportar a excel, PDF o imprimir la tabla.

### LogOut
- Este campo nos permite cerrar sesión del usuario y volvemos al login inicial.
