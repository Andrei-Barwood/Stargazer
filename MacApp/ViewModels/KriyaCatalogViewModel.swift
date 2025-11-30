import Foundation
import Combine

/// ViewModel para catálogo de kriyas en Mac
class KriyaCatalogViewModel: ObservableObject {
    @Published var allKriyas: [Kriya] = []
    @Published var filteredKriyas: [Kriya] = []
    @Published var selectedCategory: String = "all"
    @Published var searchText: String = ""
    
    private let kriyaCatalog: KriyaCatalogLoader
    
    init(kriyaCatalog: KriyaCatalogLoader) {
        self.kriyaCatalog = kriyaCatalog
        loadKriyas()
    }
    
    /// Carga kriyas del catálogo
    func loadKriyas() {
        kriyaCatalog.loadDefaultKriyas()
        allKriyas = kriyaCatalog.kriyas
        applyFilters()
    }
    
    /// Aplica filtros de búsqueda y categoría
    func applyFilters() {
        var result = allKriyas
        
        if selectedCategory != "all" {
            result = result.filter { $0.category == selectedCategory }
        }
        
        if !searchText.isEmpty {
            result = result.filter { kriya in
                kriya.name.localizedCaseInsensitiveContains(searchText) ||
                kriya.description.localizedCaseInsensitiveContains(searchText)
            }
        }
        
        filteredKriyas = result
    }
    
    /// Obtiene categorías únicas
    func getCategories() -> [String] {
        var categories = Set(allKriyas.map { $0.category })
        return Array(categories).sorted()
    }
}
