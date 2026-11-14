// MENÚ HAMBURGUESA
const botonMenu = document.querySelector(".nav-menu-toggle");
const menu = document.querySelector(".navbar");
const iconoMenu = botonMenu.querySelector("i");

function abrirMenu() {
    menu.classList.add("active");
    botonMenu.setAttribute("aria-expanded", "true");
    iconoMenu.classList.replace("fa-bars", "fa-xmark");
}

function cerrarMenu() {
    menu.classList.remove("active");
    botonMenu.setAttribute("aria-expanded", "false");
    iconoMenu.classList.replace("fa-xmark", "fa-bars");
}

// Abre o cierra el menú al hacer click en el botón
botonMenu.addEventListener("click", function () {
    if (menu.classList.contains("active")) {
        cerrarMenu();
    } else {
        abrirMenu();
    }
});

// Cierra el menú al elegir una opción
const enlacesMenu = document.querySelectorAll(".navbar a");
for (const enlace of enlacesMenu) {
    enlace.addEventListener("click", cerrarMenu);
}

// Al volver a pantalla de escritorio, el menú regresa a su estado normal
window.addEventListener("resize", function () {
    if (window.innerWidth > 992) {
        cerrarMenu();
    }
});


// BOTÓN IR ARRIBA
const botonArriba = document.querySelector(".scroll-up");

// Muestra el botón solo después de bajar 400px
function mostrarBotonArriba() {
    if (window.scrollY <= 400) {
        botonArriba.hidden = true;
    } else {
        botonArriba.hidden = false;
    }
}

mostrarBotonArriba();
window.addEventListener("scroll", mostrarBotonArriba);

// Regresa al inicio con desplazamiento suave
botonArriba.addEventListener("click", function () {
    window.scrollTo({ top: 0, behavior: "smooth" });
});
