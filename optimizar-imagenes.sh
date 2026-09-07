#!/usr/bin/env bash

set -euo pipefail

# ==========================
# CONFIGURACIÓN
# ==========================

MAX_KB=200
MAX_BYTES=$((MAX_KB * 1024))

INITIAL_WIDTH=1600
MIN_WIDTH=600

INITIAL_QUALITY=82
MIN_QUALITY=45
QUALITY_STEP=5

WIDTH_STEP=200

# ==========================
# VALIDACIONES
# ==========================

if ! command -v magick >/dev/null 2>&1; then
    echo "Error: ImageMagick no está instalado."
    echo "Instálalo con:"
    echo "sudo pacman -S imagemagick"
    exit 1
fi

if [[ $# -ne 1 ]]; then
    echo "Uso:"
    echo "$0 /ruta/a/la/carpeta"
    exit 1
fi

INPUT_DIR="$1"

if [[ ! -d "$INPUT_DIR" ]]; then
    echo "Error: '$INPUT_DIR' no es una carpeta válida."
    exit 1
fi

OUTPUT_DIR="$INPUT_DIR/optimizadas"

mkdir -p "$OUTPUT_DIR"

echo "Carpeta de entrada:"
echo "$INPUT_DIR"
echo
echo "Las imágenes optimizadas se guardarán en:"
echo "$OUTPUT_DIR"
echo

# ==========================
# FUNCIÓN DE OPTIMIZACIÓN
# ==========================

optimizar_imagen() {
    local input="$1"

    local filename
    local basename
    local output

    filename="$(basename "$input")"
    basename="${filename%.*}"

    output="$OUTPUT_DIR/${basename}.webp"

    local width=$INITIAL_WIDTH
    local quality=$INITIAL_QUALITY

    echo "-------------------------------------------"
    echo "Procesando: $filename"

    while true; do

        magick "$input" \
            -auto-orient \
            -strip \
            -resize "${width}x${width}>" \
            -quality "$quality" \
            "$output"

        local size
        size=$(stat -c%s "$output")

        local size_kb
        size_kb=$((size / 1024))

        echo "  ${width}px | calidad ${quality} | ${size_kb} KB"

        # Ya cumple con el límite
        if (( size <= MAX_BYTES )); then
            echo "✓ Final: ${size_kb} KB"
            break
        fi

        # Primero intentamos bajar la calidad
        if (( quality > MIN_QUALITY )); then

            quality=$((quality - QUALITY_STEP))

            if (( quality < MIN_QUALITY )); then
                quality=$MIN_QUALITY
            fi

        # Si la calidad ya es demasiado baja,
        # reducimos la resolución
        elif (( width > MIN_WIDTH )); then

            width=$((width - WIDTH_STEP))

            if (( width < MIN_WIDTH )); then
                width=$MIN_WIDTH
            fi

            quality=$INITIAL_QUALITY

        else

            echo "⚠ No fue posible alcanzar ${MAX_KB} KB sin bajar de:"
            echo "  Resolución: ${MIN_WIDTH}px"
            echo "  Calidad: ${MIN_QUALITY}"
            echo "  Resultado actual: ${size_kb} KB"

            break
        fi
    done
}

# ==========================
# BUSCAR Y PROCESAR IMÁGENES
# ==========================

found=0

while IFS= read -r -d '' img; do

    found=1
    optimizar_imagen "$img"

done < <(
    find "$INPUT_DIR" \
        -maxdepth 1 \
        -type f \
        \( \
            -iname "*.jpg" \
            -o -iname "*.jpeg" \
            -o -iname "*.png" \
            -o -iname "*.webp" \
        \) \
        -print0
)

echo
echo "==========================================="

if (( found == 0 )); then
    echo "No se encontraron imágenes."
else
    echo "✓ Optimización terminada."
    echo "Resultados:"
    echo "$OUTPUT_DIR"
fi