import os

ARCHIVO_DATOS = "registro_residuos.txt"

# Funciones

def mostrar_menu():
    print("\n===== EcoRegistro - Reciclaje =====")
    print("1. Registrar residuo")
    print("2. Ver historial")
    print("3. Ver estadísticas")
    print("4. Borrar historial")
    print("5. Salir")
    print("==================================")

# para guardar datos de un residuo en el archivo
def registrar_residuo():
    print("\n--- Registrar un residuo ---")
    print("1. Plástico")
    print("2. Papel / Cartón")
    print("3. Vidrio")
    print("4. Orgánico")
    print("5. Otros")

    try:
        op = int(input("Opción (1-5): "))
    except ValueError:
        print("Opción inválida.")
        return

    categorias = {
        1: "Plástico",
        2: "Papel/Cartón",
        3: "Vidrio",
        4: "Orgánico",
        5: "Otros"
    }

    if op not in categorias:
        print("Categoría inválida.")
        return

    cat = categorias[op]

    try:
        cant = float(input(f"Ingrese cantidad en kg de {cat}: "))
    except ValueError:
        print("Debe ingresar un número.")
        return

    with open(ARCHIVO_DATOS, "a", encoding="utf-8") as f:
        f.write(f"{cat},{cant}\n")

    print(f"Registro guardado: {cant} kg de {cat}")

# para mostrar lo que tenemos guardado
def ver_historial():
    print("\n--- Historial ---")
    if not os.path.exists(ARCHIVO_DATOS):
        print("No hay registros todavía.")
        return

    with open(ARCHIVO_DATOS, "r", encoding="utf-8") as f:
        lineas = f.readlines()

    if not lineas:
        print("No hay registros para mostrar.")
        return

    print(f"Registros totales: {len(lineas)}")
    for linea in lineas:
        cat, cant = linea.strip().split(",")
        print(f"- {cant} kg de {cat}")

# para hacer calculos con lo que guardamos
def ver_estadisticas():
    print("\n--- Estadísticas ---")
    if not os.path.exists(ARCHIVO_DATOS):
        print("Todavía no hay datos.")
        return

    totales = {}
    total_general = 0

    with open(ARCHIVO_DATOS, "r", encoding="utf-8") as f:
        for linea in f:
            cat, cant = linea.strip().split(",")
            cant = float(cant)
            totales[cat] = totales.get(cat, 0) + cant
            total_general += cant

    if total_general == 0:
        print("Nada para mostrar.")
        return

    for cat, cant in totales.items():
        porc = (cant / total_general) * 100
        print(f"{cat}: {cant:.2f} kg ({porc:.1f}%)")

    print(f"Total registrado: {total_general:.2f} kg")

# para vaciar todo el archivo
def borrar_historial():
    if not os.path.exists(ARCHIVO_DATOS):
        print("No hay historial para borrar.")
        return
    
    seguro = input("¿Seguro que desea borrar todo? (S/N): ").strip().lower()
    if seguro == "s":
        open(ARCHIVO_DATOS, "w").close()
        print("Historial borrado.")
    else:
        print("Operación cancelada.")

# Programa Principal

def main():
    while True:
        mostrar_menu()
        op = input("Seleccione una opción: ")

        if op == "1":
            registrar_residuo()
        elif op == "2":
            ver_historial()
        elif op == "3":
            ver_estadisticas()
        elif op == "4":
            borrar_historial()
        elif op == "5":
            print("Gracias por usar EcoRegistro.")
            break
        else:
            print("Opción inválida.")

if __name__ == "__main__":
    main()