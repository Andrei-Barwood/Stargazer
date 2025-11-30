#!/bin/zsh

# Script para analizar estructura del repositorio Stargazer
# Uso: chmod +x jerarquia.sh && ./jerarquia.sh

OUTPUT_FILE="stargazer_structure_$(date +%Y%m%d_%H%M%S).log"

{
    echo "========================================"
    echo "ANÁLISIS DE ESTRUCTURA: Stargazer"
    echo "Fecha: $(date '+%Y-%m-%d %H:%M:%S')"
    echo "Ubicación: $(pwd)"
    echo "========================================"
    echo ""
    
    echo "--- README.md (Propósito del Proyecto) ---"
    if [ -f "README.md" ]; then
        cat README.md
    else
        echo "[No se encontró README.md]"
    fi
    echo ""
    echo ""
    
    echo "--- ESTRUCTURA DE DIRECTORIOS Y ARCHIVOS ---"
    echo ""
    tree -a --charset ascii -L 5 2>/dev/null || find . -not -path '*/\.*' -type f | head -100
    echo ""
    echo ""
    
    echo "--- CONTEO DE ARCHIVOS POR EXTENSIÓN ---"
    echo ""
    find . -not -path '*/\.*' -type f | sed 's/.*\.//' | sort | uniq -c | sort -rn
    echo ""
    echo ""
    
    echo "--- ARCHIVOS VACÍOS (0 BYTES) ---"
    echo ""
    find . -not -path '*/\.*' -type f -empty -exec ls -lh {} \; | awk '{print $9}'
    echo ""
    echo ""
    
    echo "--- ESTRUCTURA JERÁRQUICA COMPLETA ---"
    echo ""
    find . -not -path '*/\.*' -type f -o -type d | sort | sed 's|^\./||' | awk '
    BEGIN { FS="/" }
    {
        depth = NF - 1
        for (i=0; i<depth; i++) printf "  "
        print "├── " $NF
    }'
    echo ""
    echo ""
    
    echo "--- INFORMACIÓN DE GIT ---"
    if [ -d ".git" ]; then
        echo "Branch actual: $(git branch --show-current 2>/dev/null || echo 'N/A')"
        echo "Commits totales: $(git rev-list --count HEAD 2>/dev/null || echo 'N/A')"
        echo "Último commit: $(git log -1 --format='%H %s' 2>/dev/null || echo 'N/A')"
    else
        echo "[No es un repositorio git]"
    fi
    echo ""
    
    echo "========================================"
    echo "Análisis completado: $(date '+%Y-%m-%d %H:%M:%S')"
    echo "========================================"
    
} | tee "$OUTPUT_FILE"

echo ""
echo "✅ Log guardado en: $OUTPUT_FILE"
