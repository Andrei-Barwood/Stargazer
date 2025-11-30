import Foundation
import Combine

/// ViewModel mejorado para catálogo de kriyas en Mac
class KriyaCatalogViewModel: ObservableObject {
    @Published var allKriyas: [Kriya] = []
    @Published var filteredKriyas: [Kriya] = []
    @Published var selectedCategory: String = "all"
    @Published var selectedIntensity: String = "all"
    @Published var searchText: String = ""
    @Published var sortBy: String = "name" // name, duration, intensity
    @Published var availableCategories: [String] = []
    @Published var availableIntensities: [String] = []
    
    private let kriyaCatalog: KriyaCatalogLoader
    
    init(kriyaCatalog: KriyaCatalogLoader) {
        self.kriyaCatalog = kriyaCatalog
        loadKriyas()
    }
    
    /// Carga kriyas del catálogo
    func loadKriyas() {
        kriyaCatalog.loadDefaultKriyas()
        allKriyas = kriyaCatalog.kriyas
        updateAvailableFilters()
        applyFilters()
    }
    
    /// Aplica filtros de búsqueda y categoría
    func applyFilters() {
        var result = allKriyas
        
        if selectedCategory != "all" {
            result = result.filter { $0.category == selectedCategory }
        }
        
        if selectedIntensity != "all" {
            result = result.filter { $0.intensity == selectedIntensity }
        }
        
        if !searchText.isEmpty {
            result = result.filter { kriya in
                kriya.name.localizedCaseInsensitiveContains(searchText) ||
                kriya.description.localizedCaseInsensitiveContains(searchText)
            }
        }
        
        // Aplicar ordenamiento
        switch sortBy {
        case "duration":
            result.sort { $0.recommendedDuration < $1.recommendedDuration }
        case "intensity":
            result.sort { $0.intensity < $1.intensity }
        default: // name
            result.sort { $0.name < $1.name }
        }
        
        filteredKriyas = result
    }
    
    /// Actualiza filtros disponibles
    private func updateAvailableFilters() {
        availableCategories = Array(Set(allKriyas.map { $0.category })).sorted()
        availableIntensities = Array(Set(allKriyas.map { $0.intensity })).sorted()
    }
    
    /// Obtiene detalles de un kriya específico
    func getKryaDetails(_ kriya: Kriya) -> String {
        var details = "📖 \(kriya.name)\n"
        details += "⏱️ Duración: \(kriya.recommendedDuration) min\n"
        details += "💪 Intensidad: \(kriya.intensity)\n"
        details += "🎯 Categoría: \(kriya.category)\n"
        details += "✨ Beneficio: \(kriya.benefit)\n"
        details += "📝 Descripción: \(kriya.description)"
        return details
    }
    
    /// Recommienda kriyas según categoría
    func recommendedKriyas(for category: String) -> [Kriya] {
        return allKriyas.filter { $0.category == category }
    }
}
