import Foundation
import CloudKit

/// Gestor de almacenamiento persistente en iCloud y local
class CloudStorage {
    private let fileManager = FileManager.default
    private let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
    
    /// Guarda un array de DiaryEntry localmente (en Documents)
    func saveDiaryEntriesLocally(_ entries: [DiaryEntry]) throws {
        let fileURL = documentsDirectory.appendingPathComponent("diary_entries.json")
        let data = try JSONEncoder().encode(entries)
        try data.write(to: fileURL, options: .atomic)
    }
    
    /// Carga DiaryEntry guardadas localmente
    func loadDiaryEntriesLocally() -> [DiaryEntry]? {
        let fileURL = documentsDirectory.appendingPathComponent("diary_entries.json")
        guard let data = try? Data(contentsOf: fileURL) else { return nil }
        return try? JSONDecoder().decode([DiaryEntry].self, from: data)
    }
    
    /// Guarda historial de pH localmente
    func savePhHistoryLocally(_ entries: [PhHistoryEntry]) throws {
        let fileURL = documentsDirectory.appendingPathComponent("ph_history.json")
        let data = try JSONEncoder().encode(entries)
        try data.write(to: fileURL, options: .atomic)
    }
    
    /// Carga historial de pH localmente
    func loadPhHistoryLocally() -> [PhHistoryEntry]? {
        let fileURL = documentsDirectory.appendingPathComponent("ph_history.json")
        guard let data = try? Data(contentsOf: fileURL) else { return nil }
        return try? JSONDecoder().decode([PhHistoryEntry].self, from: data)
    }
    
    /// Elimina archivo local
    func deleteLocalFile(named filename: String) throws {
        let fileURL = documentsDirectory.appendingPathComponent(filename)
        try fileManager.removeItem(at: fileURL)
    }
    
    /// Obtiene tamaño total de almacenamiento usado
    func getStorageUsage() -> Int64? {
        do {
            let attributes = try fileManager.attributesOfFileSystem(forPath: NSHomeDirectory())
            return attributes[.systemFreeSize] as? Int64
        } catch {
            return nil
        }
    }
}
