import Foundation
import Combine

/// Gestor de almacenamiento de entradas del diario, incluye sincronización y notificaciones
class DiaryStore: ObservableObject {
    @Published var entries: [DiaryEntry] = []

    init() {
        // Carga desde persistencia local o nube si es necesario
        // loadEntriesFromDiskOrCloud()
    }

    /// Añade una entrada nueva al diario
    func addEntry(_ entry: DiaryEntry) {
        entries.append(entry)
        // Guardar en disco, nube, etc. si es necesario
        // saveEntriesToDiskOrCloud()
        // Notificar si quieres feedback visual/háptico
    }

    /// Elimina una entrada específica
    func deleteEntry(_ entry: DiaryEntry) {
        entries.removeAll { $0.id == entry.id }
        // saveEntriesToDiskOrCloud()
    }

    /// Permite editar/actualizar una entrada
    func updateEntry(_ updated: DiaryEntry) {
        if let index = entries.firstIndex(where: { $0.id == updated.id }) {
            entries[index] = updated
            // saveEntriesToDiskOrCloud()
        }
    }

    /// Permite cargar entradas desde fuente persistente (opcional implementación)
    func loadEntriesFromDiskOrCloud() {
        // Implementar si usas UserDefaults, CoreData, CloudKit, etc.
    }

    /// Guarda todas las entradas actuales (opcional implementación)
    func saveEntriesToDiskOrCloud() {
        // Implementar si usas UserDefaults, CoreData, CloudKit, etc.
    }
}
