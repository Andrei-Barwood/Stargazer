import Foundation
import Combine

/// ViewModel para la pantalla de inicio en Apple Watch
class HomeViewModel: ObservableObject {
    @Published var todayMandala: MandalaIdentity?
    @Published var todayAffirmation: String = ""
    @Published var currentVitals: VitalSigns?
    
    private let mandalaManager: MandalaManager
    private let diaryStore: DiaryStore
    
    init(mandalaManager: MandalaManager, diaryStore: DiaryStore) {
        self.mandalaManager = mandalaManager
        self.diaryStore = diaryStore
        loadTodayData()
    }
    
    /// Carga datos del día (mandala, afirmación)
    func loadTodayData() {
        todayMandala = mandalaManager.mandalaForToday()
        todayAffirmation = AppConstants.affirmations.randomElement() ?? ""
    }
    
    /// Actualiza vitales actuales
    func updateCurrentVitals(_ vitals: VitalSigns) {
        currentVitals = vitals
    }
}
