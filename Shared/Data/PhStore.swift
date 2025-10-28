import Foundation
import Combine

/// Gestor para el historial y registro de pH sanguíneo, con soporte de persistencia y actualizaciones
class PhStore: ObservableObject {
    @Published var entries: [PhHistoryEntry] = []

    init() {
        // cargar aquí desde persistencia local o nube
        // loadEntriesFromDiskOrCloud()
    }

    /// Añade un nuevo registro de pH
    func add(value: Double, date: Date = Date()) {
        let entry = PhHistoryEntry(date: date, value: value)
        entries.append(entry)
        // Guarda en disco, nube, etc. si se implementa persistencia
        // saveEntriesToDiskOrCloud()
    }

    /// Elimina un registro específico
    func delete(entry: PhHistoryEntry) {
        entries.removeAll { $0.id == entry.id }
        // saveEntriesToDiskOrCloud()
    }

    /// Permite editar o actualizar un registro
    func update(entry: PhHistoryEntry) {
        if let index = entries.firstIndex(where: { $0.id == entry.id }) {
            entries[index] = entry
            // saveEntriesToDiskOrCloud()
        }
    }

    /// Carga el historial desde persistencia (UserDefaults, CoreData, CloudKit...)
    func loadEntriesFromDiskOrCloud() {
        // Implementar según la estrategia elegida
    }

    /// Guarda todo el historial actual
    func saveEntriesToDiskOrCloud() {
        // Implementar según la estrategia elegida
    }
}
