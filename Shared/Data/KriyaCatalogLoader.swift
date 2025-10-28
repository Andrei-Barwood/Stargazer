import Foundation

/// Gestor para cargar, guardar y actualizar el catálogo de kriyas desde datos locales, remotos o assets
class KriyaCatalogLoader {
    private var filename: String?

    // Catálogo en memoria
    private(set) var kriyas: [Kriya] = []

    /// Inicializa con un archivo, url o tipo de fuente si es necesario
    init(filename: String? = nil) {
        self.filename = filename
        // Si tienes un archivo local, puedes cargarlo aquí
        if let file = filename {
            loadKriyasFromFile(named: file)
        }
    }

    /// Carga el catálogo desde un archivo local (Bundle, Documents, etc.)
    func loadKriyasFromFile(named file: String) {
        guard let url = Bundle.main.url(forResource: file, withExtension: "json") else { return }
        do {
            let data = try Data(contentsOf: url)
            let decoded = try JSONDecoder().decode([Kriya].self, from: data)
            kriyas = decoded
        } catch {
            print("Error al cargar Kriyas desde archivo: \(error.localizedDescription)")
        }
    }

    /// Carga el catálogo desde datos embebidos (por ejemplo, hardcode o asset inicial)
    func loadDefaultKriyas() {
        kriyas = [
            Kriya(
                name: "Healing for Aging",
                benefit: "Revitaliza y rejuvenece.",
                category: "Balance físico y rejuvenecimiento",
                recommendedDuration: 11,
                intensity: "Media",
                description: "Serie para estimular la energía vital.",
                steps: ["Siéntate recto", "Respira y contrae abdomen", "Repite 15 segundos por ciclo"],
                notes: "Respiración consciente.",
                link: nil
            ),
            // ...agrega más cuando completes el catálogo
        ]
    }

    /// Permite actualizar el catálogo (desde web, archivo o edición manual)
    func updateKriyas(newKriyas: [Kriya]) {
        kriyas = newKriyas
        // Agrega lógica para guardar si es necesario (en disco, nube, etc.)
    }
}
