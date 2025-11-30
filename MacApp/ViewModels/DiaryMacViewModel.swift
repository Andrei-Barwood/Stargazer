import Foundation
import Combine

/// ViewModel mejorado para diario en Mac con opciones avanzadas
class DiaryMacViewModel: ObservableObject {
    @Published var entries: [DiaryEntry] = []
    @Published var selectedEntry: DiaryEntry?
    @Published var filteredEntries: [DiaryEntry] = []
    @Published var searchText: String = ""
    @Published var filterByMood: String = "all"
    @Published var filterByKriya: String = "all"
    @Published var sortBy: String = "date_desc" // date_desc, date_asc, rating, mood
    @Published var availableMoods: [String] = []
    @Published var availableKriyas: [String] = []
    @Published var selectedMonth: Date = Date()
    
    private let diaryStore: DiaryStore
    
    init(diaryStore: DiaryStore) {
        self.diaryStore = diaryStore
        loadEntries()
    }
    
    /// Carga entradas
    func loadEntries() {
        entries = diaryStore.entries.sorted { $0.timestamp > $1.timestamp }
        updateAvailableFilters()
        applyFilters()
    }
    
    /// Aplica filtros combinados
    func applyFilters() {
        var result = entries
        
        if !searchText.isEmpty {
            result = result.filter { entry in
                entry.kriyaName.localizedCaseInsensitiveContains(searchText) ||
                entry.notes.localizedCaseInsensitiveContains(searchText)
            }
        }
        
        if filterByMood != "all" {
            result = result.filter { $0.mood == filterByMood }
        }
        
        if filterByKriya != "all" {
            result = result.filter { $0.kriyaName == filterByKriya }
        }
        
        // Aplicar ordenamiento
        switch sortBy {
        case "date_asc":
            result.sort { $0.timestamp < $1.timestamp }
        case "rating":
            result.sort { ($0.rating ?? 0) > ($1.rating ?? 0) }
        case "mood":
            result.sort { $0.mood < $1.mood }
        default: // date_desc
            result.sort { $0.timestamp > $1.timestamp }
        }
        
        filteredEntries = result
    }
    
    /// Actualiza filtros disponibles
    private func updateAvailableFilters() {
        availableMoods = Array(Set(entries.map { $0.mood })).sorted()
        availableKriyas = Array(Set(entries.map { $0.kriyaName })).sorted()
    }
    
    /// Exporta a PDF (stub)
    func exportToPDF() {
        // Implementación futura para exportar entradas seleccionadas
    }
    
    /// Elimina entrada
    func delete(_ entry: DiaryEntry) {
        diaryStore.deleteEntry(entry)
        loadEntries()
    }
    
    /// Obtiene entradas del mes seleccionado
    func getEntriesForMonth() -> [DiaryEntry] {
        let calendar = Calendar.current
        let components = calendar.dateComponents([.year, .month], from: selectedMonth)
        
        return entries.filter { entry in
            let entryComponents = calendar.dateComponents([.year, .month], from: entry.timestamp)
            return entryComponents.year == components.year && entryComponents.month == components.month
        }
    }
}
