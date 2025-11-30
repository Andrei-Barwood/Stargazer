import Foundation
import Combine

/// ViewModel mejorado para la pantalla de inicio en Apple Watch
class HomeViewModel: ObservableObject {
    @Published var todayMandala: MandalaIdentity?
    @Published var todayAffirmation: String = ""
    @Published var currentVitals: VitalSigns?
    @Published var suggestedKriya: Kriya?
    @Published var suggestionReason: String = ""
    @Published var lastDiaryEntry: DiaryEntry?
    @Published var isLoading: Bool = false
    
    private let mandalaManager: MandalaManager
    private let diaryStore: DiaryStore
    private let kriyaCatalog: KriyaCatalogLoader
    
    init(mandalaManager: MandalaManager, diaryStore: DiaryStore, kriyaCatalog: KriyaCatalogLoader) {
        self.mandalaManager = mandalaManager
        self.diaryStore = diaryStore
        self.kriyaCatalog = kriyaCatalog
        loadTodayData()
    }
    
    /// Carga datos del día (mandala, afirmación, kriya sugerida)
    func loadTodayData() {
        isLoading = true
        todayMandala = mandalaManager.mandalaForToday()
        todayAffirmation = AppConstants.affirmations.randomElement() ?? ""
        lastDiaryEntry = diaryStore.entries.sorted { $0.timestamp > $1.timestamp }.first
        
        // Cargar kriyas y sugerir
        kriyaCatalog.loadDefaultKriyas()
        if let vitals = currentVitals {
            let (kriya, reason) = SuggestionEngine.suggestKriya(from: kriyaCatalog.kriyas, with: vitals)
            suggestedKriya = kriya
            suggestionReason = reason
        }
        
        isLoading = false
    }
    
    /// Actualiza vitales actuales y recalcula sugerencias
    func updateCurrentVitals(_ vitals: VitalSigns) {
        currentVitals = vitals
        loadTodayData()
    }
    
    /// Recarga todos los datos
    func refresh() {
        loadTodayData()
    }
}
