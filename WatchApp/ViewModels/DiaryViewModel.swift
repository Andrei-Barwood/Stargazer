import Foundation
import Combine

/// ViewModel mejorado para gestionar la visualización del diario en Watch
class DiaryViewModel: ObservableObject {
    @Published var entries: [DiaryEntry] = []
    @Published var selectedEntry: DiaryEntry?
    @Published var filteredEntries: [DiaryEntry] = []
    @Published var searchText: String = ""
    @Published var favoriteCount: Int = 0
    @Published var thisMonthCount: Int = 0
    
    private let diaryStore: DiaryStore
    
    init(diaryStore: DiaryStore) {
        self.diaryStore = diaryStore
        loadEntries()
    }
    
    /// Carga todas las entradas del diario
    func loadEntries() {
        entries = diaryStore.entries.sorted { $0.timestamp > $1.timestamp }
        updateStatistics()
        applyFilter()
    }
    
    /// Aplica filtro de búsqueda
    func applyFilter() {
        if searchText.isEmpty {
            filteredEntries = entries
        } else {
            filteredEntries = entries.filter { entry in
                entry.kriyaName.localizedCaseInsensitiveContains(searchText) ||
                entry.notes.localizedCaseInsensitiveContains(searchText) ||
                entry.mood.localizedCaseInsensitiveContains(searchText)
            }
        }
    }
    
    /// Marca una entrada como favorita
    func toggleFavorite(for entry: DiaryEntry) {
        var updated = entry
        updated.isFavorite.toggle()
        diaryStore.updateEntry(updated)
        loadEntries()
    }
    
    /// Elimina una entrada
    func delete(_ entry: DiaryEntry) {
        diaryStore.deleteEntry(entry)
        loadEntries()
    }
    
    /// Actualiza estadísticas del diario
    private func updateStatistics() {
        favoriteCount = entries.filter { $0.isFavorite }.count
        
        let calendar = Calendar.current
        let now = Date()
        let startOfMonth = calendar.date(from: calendar.dateComponents([.year, .month], from: now)) ?? now
        thisMonthCount = entries.filter { calendar.isDate($0.timestamp, inSameDayAsDate: now) || $0.timestamp >= startOfMonth }.count
    }
}
