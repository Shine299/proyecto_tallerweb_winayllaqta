# Guía de Sustentación para Examen de Programación Web
## Proyecto: Wiñay Llaqta - Compañía de Danzas

Esta guía resume todo el código desarrollado en **HTML5** y **CSS3** para el proyecto **Wiñay Llaqta** (Avance APF2), explicando qué se hizo, por qué se hizo y cómo defenderlo ante el docente.

---

## 1. Ficha Técnica y Comparativa (APF1 vs. APF2)

| Aspecto | Avance Inicial (APF1) | Avance Actual (APF2) | Justificación Técnica |
| :--- | :--- | :--- | :--- |
| **Cabecera** | Solo logo y enlaces dentro de un `div`. | **Top-bar** (contactos/redes) + **`<nav>` semántico** + cabecera `position: sticky`. | Mejora accesibilidad (SEO/lectores de pantalla) y mantiene la navegación visible en todo momento. |
| **Portada (Hero)** | Imagen estática en layout de 2 columnas. | **Video HTML5 en loop** con capa de texto flotante (`position: absolute`). | Impacto visual profesional con reproducción continua y sin sonido para cumplir políticas del navegador. |
| **Multimedia** | Imágenes estándar. | **Video HTML5 nativo** con controles + **iframe de YouTube** en modo responsivo y carga diferida (`loading="lazy"`). | Variedad de fuentes de contenido audiovisual optimizadas en rendimiento (WPO). |
| **Tarifas** | Lista/texto plano. | **Tabla semántica accesible** (`table`, `thead`, `tbody`, `tfoot`, `caption`) en contenedor deslizable (`overflow-x: auto`). | Estructuración tabular de datos y adaptabilidad a dispositivos móviles. |
| **Formulario** | Solo datos de contacto estáticos. | **Formulario interactivo completo** con campos validados (`required`), tipos semánticos (`email`, `tel`), `select` y diseño en grilla Flexbox. | Captura de clientes potenciales con validación nativa sin necesidad de JavaScript inicial. |
| **UX y Navegación** | Desplazamiento brusco. | **Botón flotante "Volver arriba"** (`position: fixed`) y `scroll-behavior: smooth`. | Experiencia de usuario (UX) fluida al saltar entre secciones. |
| **Optimización** | Formatos convencionales. | Imágenes en formato moderno **`.webp`**, videos comprimidos y atributos `width`/`height`. | Reducción de peso (+80%) y prevención de saltos bruscos en pantalla (Cumulative Layout Shift - CLS). |

---

## 2. Defensa del Código HTML5 (`index.html`)

### A. Estructura Semántica Global
El documento cumple con el estándar de marcado semántico de HTML5:
* **`<!DOCTYPE html>`**: Define la especificación moderna de HTML5 para que el navegador renderice en modo estándar.
* **`<html lang="es">`**: Indica el idioma del documento (fundamental para motores de búsqueda y sintetizadores de voz).
* **`<head>`**:
  * `<meta charset="UTF-8">`: Soporte de caracteres en español (tildes, eñes).
  * `<meta name="viewport" content="width=device-width, initial-scale=1.0">`: Habilita el Responsive Design adaptando el ancho lógico al dispositivo físico.
  * Etiquetas `<link>`: Conexión con `styles.css`, Google Fonts (Josefin Sans y Figtree con `preconnect`) y FontAwesome (iconografía).
* **`<header>`**: Contiene la navegación y datos de contacto de cabecera.
* **`<nav>`**: Envuelve el menú principal. Indica a motores de búsqueda y lectores que su contenido es una zona de navegación principal.
* **`<main>`**: Identifica el contenido central único de la página (no se repite entre páginas).
* **`<section>` y `<article>`**: 
  * Cada bloque temático (`#inicio`, `#servicios`, `#tarifas`, etc.) es una `<section>`.
  * Los elementos autónomos e independientes dentro de las secciones (servicios individuales, miembros del elenco, testimonios) son etiquetas `<article>`.
* **`<footer>`**: Pie de página semántico con enlaces de navegación secundaria, marca, redes sociales y copyright.

---

### B. Elementos Multimedia y Video
#### 1. Video de portada (Fondo Hero):
```html
<video class="hero-video" autoplay muted loop playsinline poster="assets/img/portada-poster.jpg">
    <source src="assets/video/portada-winay.mp4" type="video/mp4">
</video>
```
* **`autoplay`**: Inicia el video automáticamente al cargar la página.
* **`muted`**: **Clave de examen**. Los navegadores modernos bloquean por política de seguridad y UX el `autoplay` si el video tiene sonido. Poner `muted` es obligatorio para que arranque solo.
* **`loop`**: Hace que el video se repita en bucle infinito.
* **`playsinline`**: Obliga al video a reproducirse dentro del contenedor en navegadores móviles (especialmente Safari/iOS), evitando que se fuerce la pantalla completa nativa.
* **`poster`**: Imagen estática que se muestra mientras el archivo de video termina de descargarse o si la conexión falla.

#### 2. Video Institucional y YouTube:
* **Video local (`<video controls preload="metadata">`)**:
  * `controls`: Activa los botones nativos de play, pausa, volumen y pantalla completa.
  * `preload="metadata"`: Solo descarga la duración y dimensiones iniciales del video, ahorrando datos de ancho de banda hasta que el usuario dé clic en reproducir.
* **Video incrustado (`<iframe>`)**:
  * Utiliza el dominio de privacidad mejorada `https://www.youtube-nocookie.com/embed/...`.
  * `loading="lazy"`: Carga diferida; el navegador no solicita el iframe hasta que el usuario se desplaza cerca de la sección.

---

### C. Tabla de Servicios y Tarifas (`<table>`)
```html
<div class="table-responsive">
    <table class="tbl-tarifas">
        <caption class="visually-hidden">Servicios de Wiñay Llaqta y opciones de cotización</caption>
        <thead>
            <tr>
                <th scope="col">Descripción del servicio</th>
                <th scope="col">Ideal para</th>
                <th scope="col">Precio <sup>*</sup></th>
            </tr>
        </thead>
        <tbody>
            <tr>...</tr>
        </tbody>
        <tfoot>
            <tr>
                <td colspan="3">(*) Para conocer tarifas y disponibilidad...</td>
            </tr>
        </tfoot>
    </table>
</div>
```
* **`<caption>` + `.visually-hidden`**: Da un título accesible a la tabla sin alterar el diseño visual.
* **`<th scope="col">`**: Define formalmente que esa celda es el encabezado de toda la columna (accesibilidad pura).
* **`<tfoot>` y `colspan="3"`**: Agrupa notas al pie de la tabla, y `colspan="3"` fusiona las tres columnas en una sola fila continua.
* **`<div class="table-responsive">`**: Contenedor envolvente con `overflow-x: auto` en CSS para permitir deslizamiento horizontal en celulares sin romper la pantalla.

---

### D. Formulario de Contacto Accesible y Validado (`<form>`)
* **Asociación `<label for="id_input">`**: Cada etiqueta se conecta con su control correspondiente mediante el atributo `for` que coincide con el `id` del campo. Permite que al dar clic al texto, el cursor se posicione en el input.
* **Campos especializados**:
  * `type="email"`: Valida estructura con arroba y dominio.
  * `type="tel"`: Abre el teclado numérico en teléfonos móviles.
  * `autocomplete="name | email | tel"`: Permite al navegador autocompletar la información guardada del usuario.
* **Restricciones nativas**: `required` impide que el formulario se envíe con campos vacíos.

---

## 3. Defensa del Código CSS3 (`styles.css`)

### A. Custom Properties / Variables CSS (`:root`)
```css
:root {
    --color-primary: #142b45;     /* Azul institucional */
    --color-secondary: #d6ad55;   /* Dorado festivo */
    --color-background: #faf6ed;  /* Crema suave */
    --color-white: #ffffff;
    --color-text: #535b64;
    --color-border: #e6dfcd;
    --color-footer-text: #c8d4e2;
    --font-title: "Josefin Sans", serif;
    --font-body: "Figtree", sans-serif;
}
```
* **Ventaja**: Facilita el mantenimiento. Si se actualiza la identidad visual, solo se cambia el valor en `:root` y se refleja en todos los selectores automáticamente.

---

### B. Reseteo y Modelo de Caja (`box-sizing`)
```css
* {
    margin: 0;
    padding: 0;
    box-sizing: border-box;
}
```
* **`box-sizing: border-box`**: Por defecto (`content-box`), cuando a un elemento de 300px le agregas `padding: 20px`, su tamaño total crece a 340px. Con `border-box`, el `padding` y el `border` se absorben **hacia adentro**, manteniendo el ancho exacto declarado y evitando desbordamientos no deseados.

---

### C. Normalización de Elementos Multimedia
```css
img, video, iframe {
    display: block;
    max-width: 100%;
    height: auto;
}
```
* Por defecto, las imágenes y videos son elementos en línea (`inline`), lo que genera un espacio en blanco fantasma inferior de 3px a 4px. Con `display: block` eliminamos ese espacio.
* `max-width: 100%` y `height: auto` hacen que cualquier medio se adapte automáticamente al ancho de su elemento padre sin salirse de la pantalla.

---

### D. Los 4 Tipos de Posicionamiento (`position`) Usados en el Proyecto

Esta es una de las preguntas teóricas y prácticas más frecuentes:

1. **`position: relative` + `position: absolute` (Posicionamiento Anidado)**:
   * **En la portada (`.hero` y `.hero-texto`)**: El contenedor padre `.hero` tiene `position: relative`. La caja con el texto y botones `.hero-texto` tiene `position: absolute; bottom: 48px; left: 5%;`, lo que permite que el texto flote exactamente encima del video de fondo.
   * **En la insignia (`.badge` de "23 AÑOS EN ESCENA")**: `.about-image-container` tiene `position: relative`, y `.badge` tiene `position: absolute; bottom: 16px; left: 16px;` para encimarse en la esquina de la fotografía.
2. **`position: sticky` (Cabecera fija inteligente)**:
   * En `.header`: Se comporta como posición estática mientras la página está al inicio, pero al hacer scroll hacia abajo y llegar a `top: 0`, se "pega" en la parte superior de la ventana.
   * Se acompaña con `scroll-margin-top: 70px;` en las etiquetas `section` para que la barra fija no tape los títulos de las secciones al navegar mediante anclas (`#servicios`, `#contacto`, etc.).
3. **`position: fixed` (Botón flotante "Volver arriba")**:
   * En `.scroll-up`: Está anclado a la ventana del navegador (`bottom: 25px; right: 25px;`). Se mantiene fijo en esa coordenada sin importar cuánto scroll haga el usuario.
   * `z-index: 1000`: Asegura que el botón se dibuje por encima de cualquier otro elemento visual.

---

### E. Maquetación con Flexbox
El proyecto utiliza Flexbox en múltiples niveles:
* **Dirección y alineación (`top-bar-flex`, `header-container`)**:
  ```css
  display: flex;
  justify-content: space-between;
  align-items: center;
  ```
  Distribuye los elementos hijos a los extremos opuestos y los centra verticalmente.
* **Múltiples filas fluidas (`.gallery-container`, `.stats-container`, `.form-flex`)**:
  ```css
  display: flex;
  flex-wrap: wrap; /* Permite que los elementos bajen a la siguiente fila si no caben */
  justify-content: space-between;
  ```
* **Columnas de formulario con `gap` y `flex`**:
  ```css
  .form-flex {
      display: flex;
      flex-wrap: wrap;
      gap: 20px;
  }
  .form-col-50 {
      flex: 1 1 calc(50% - 10px); /* Ocupa la mitad menos el espaciado */
  }
  .form-col-100 {
      flex: 100%;                 /* Ocupa el ancho completo */
  }
  ```

---

### F. Responsive Design (`@media (max-width: 640px)`)
Para pantallas de teléfonos móviles (menores o iguales a 640 píxeles):
1. **Formulario fluido**:
   ```css
   .form-col-50, .form-col-100 {
       flex-basis: 100%;
   }
   ```
   Pasa los campos de dos columnas a una sola columna vertical para facilitar la escritura con una mano.
2. **Bloque de contacto**:
   ```css
   .contact-content {
       flex-direction: column;
   }
   .contact-content div {
       width: 100%;
   }
   ```
   Las dos columnas de información de contacto se apilan verticalmente.
3. **Tabla desplazable**:
   El contenedor `.table-responsive` permite deslizar horizontalmente la tabla de tarifas gracias a `overflow-x: auto`, evitando que la tabla se comprima de forma ilegible.

---

## 4. Banco de Preguntas Típicas del Docente (Simulacro Oral)

### P1: ¿Por qué usaron `object-fit: cover` en las imágenes y videos?
> **Respuesta:** *"Porque queremos que el contenido visual rellene exactamente las dimensiones de la caja asignada sin deformarse. `object-fit: cover` escala la imagen o video manteniendo su relación de aspecto original y recorta los sobrantes, tal como lo hace `background-size: cover` en fondos CSS."*

### P2: ¿Qué diferencia hay entre `position: absolute` y `position: fixed`?
> **Respuesta:** *"Un elemento con `position: absolute` se posiciona con respecto a su ancestro posicionado más cercano (que tenga `position: relative`, por ejemplo). Si hacemos scroll, se mueve junto con ese ancestro. En cambio, `position: fixed` se posiciona siempre respecto a la ventana del navegador (`viewport`) y se queda congelado en la pantalla aunque nos desplacemos."*

### P3: ¿Para qué sirve la clase `.visually-hidden`?
> **Respuesta:** *"Es una técnica de accesibilidad web (A11y). Oculta visualmente un elemento en la pantalla (como el `<caption>` de la tabla) reduciendo sus dimensiones a 1px y ocultando el desborde, pero lo mantiene accesible para que los lectores de pantalla de personas con discapacidad visual puedan leerlo."*

### P4: ¿Por qué la cabecera usa `sticky` en lugar de `fixed`?
> **Respuesta:** *"Porque encima de la cabecera tenemos una barra superior (`#top-bar`). Si usáramos `fixed`, la cabecera se superpondría al `top-bar` desde el inicio. Con `sticky`, la cabecera respeta su lugar en el flujo normal al inicio de la página y recién se 'pega' arriba cuando el usuario hace scroll hacia abajo."*

### P5: ¿Cómo garantizan que al saltar con un enlace `#` la cabecera fija no tape el título?
> **Respuesta:** *"En las etiquetas `section` colocamos la propiedad `scroll-margin-top: 70px;`. Esto añade un margen virtual superior al momento del salto, compensando la altura de la cabecera fija para que el título quede visible y no quede oculto detrás de ella."*

### P6: ¿Por qué usaron `html { scroll-behavior: smooth; }`?
> **Respuesta:** *"Para que todos los enlaces internos hacia IDs de la misma página (como el menú de navegación y el botón volver arriba) realicen una transición de desplazamiento suave en lugar de un salto brusco e instantáneo."*

---

## 5. Rendimiento y Buenas Prácticas (El punto para sacar 20)

Si el profesor pregunta qué criterios de calidad adicionales se aplicaron:
1. **Formato WebP**: Todas las imágenes fueron convertidas de JPG/PNG a `.webp` (mediante el script `optimizar-imagenes.sh`), reduciendo su peso drásticamente conservando alta fidelidad.
2. **Dimensiones explícitas (`width` y `height` en etiquetas `<img>`)**: Se declararon las dimensiones nativas para que el navegador reserve el espacio antes de renderizar la imagen, evitando el salto de diseño (CLS).
3. **Carga diferida (`loading="lazy"`)**: Aplicada en el `iframe` de YouTube para que no consuma memoria ni red en la carga inicial.
4. **Validación HTML y CSS**: Sintaxis limpia, organizada por bloques comentados y sin estilos en línea dentro de las etiquetas HTML.
