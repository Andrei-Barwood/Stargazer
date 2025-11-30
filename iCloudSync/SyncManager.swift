import Foundation
import CloudKit
import Combine

/// Gestor central de sincronización con iCloud usando CloudKit
class SyncManager: NSObject, ObservableObject {
    @Published var isSyncing: Bool = false
    @Published var syncError: NSError?
    @Published var lastSyncDate: Date?
    
    private let container = CKContainer.default()
    private let privateDatabase: CKDatabase
    
    override init() {
        self.privateDatabase = container.privateCloudDatabase
        super.init()
    }
    
    /// Sincroniza entradas del diario a iCloud
    func syncDiaryEntries(_ entries: [DiaryEntry]) {
        isSyncing = true
        var records: [CKRecord] = []
        
        for entry in entries {
            let record = CKRecord(recordType: "DiaryEntry")
            record["timestamp"] = entry.timestamp as NSDate
            record["kriyaName"] = entry.kriyaName
            record["notes"] = entry.notes
            record["mood"] = entry.mood
            record["coachingMessage"] = entry.coachingMessage
            record["rating"] = entry.rating ?? 0
            record["isFavorite"] = entry.isFavorite as NSNumber
            records.append(record)
        }
        
        let operation = CKModifyRecordsOperation(recordsToSave: records, recordIDsToDelete: nil)
        operation.qualityOfService = .userInitiated
        operation.completionBlock = { [weak self] in
            DispatchQueue.main.async {
                self?.isSyncing = false
                self?.lastSyncDate = Date()
            }
        }
        
        privateDatabase.add(operation)
    }
    
    /// Descarga entradas del diario desde iCloud
    func fetchDiaryEntriesFromCloud(completion: @escaping ([DiaryEntry]?, NSError?) -> Void) {
        isSyncing = true
        let query = CKQuery(recordType: "DiaryEntry", predicate: NSPredicate(value: true))
        
        privateDatabase.perform(query, inZoneWith: nil) { [weak self] records, error in
            DispatchQueue.main.async {
                self?.isSyncing = false
                if let error = error {
                    self?.syncError = error as NSError
                    completion(nil, error as NSError)
                } else {
                    // Convertir registros a DiaryEntry
                    let entries = records?.compactMap { self?.recordToDiaryEntry($0) } ?? []
                    self?.lastSyncDate = Date()
                    completion(entries, nil)
                }
            }
        }
    }
    
    /// Convierte un CKRecord a DiaryEntry
    private func recordToDiaryEntry(_ record: CKRecord) -> DiaryEntry? {
        guard
            let timestamp = record["timestamp"] as? NSDate as Date?,
            let kriyaName = record["kriyaName"] as? String,
            let notes = record["notes"] as? String,
            let mood = record["mood"] as? String,
            let coachingMessage = record["coachingMessage"] as? String
        else { return nil }
        
        let beforeVitals = VitalSigns(
            heartRate: 72, hrv: 48, breathingRate: 14,
            temperature: 36.5, oxygenLevel: 98.0, mood: mood
        )
        let afterVitals = VitalSigns(
            heartRate: 68, hrv: 52, breathingRate: 12,
            temperature: 36.5, oxygenLevel: 98.5, mood: mood
        )
        
        return DiaryEntry(
            timestamp: timestamp,
            kriyaName: kriyaName,
            notes: notes,
            mood: mood,
            coachingMessage: coachingMessage,
            beforeVitals: beforeVitals,
            afterVitals: afterVitals,
            rating: record["rating"] as? Int,
            isFavorite: (record["isFavorite"] as? NSNumber)?.boolValue ?? false
        )
    }
}
