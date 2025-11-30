import Foundation
import Combine

/// ViewModel para diario en Mac con opciones avanzadas
class DiaryMacViewModel: ObservableObject {
    @Published var entries: [DiaryEntry] = []
    @Published var selectedEntry: DiaryEntry?
    @Published var filteredEntries: [DiaryEntry] = []
    @Published var searchText: String = ""
    @Published var filterByMood: String = "all"
    @Published var filterByKriya: String = "all"
    
    private let diaryStore: DiaryStore
    
    init(diaryStore: DiaryStore) {
        self.diaryStore = diaryStore
        loadEntries()
    }
    
    /// Carga entradas
    func loadEntries() {
        entries = diaryStore.entries.sorted { $0.timestamp > $1.timestamp }
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
        
        filteredEntries = result
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
}
