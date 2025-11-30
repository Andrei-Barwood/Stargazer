import Foundation
import Combine

/// ViewModel para el dashboard principal de Mac
class MainViewModel: ObservableObject {
    @Published var selectedTab: Int = 0
    @Published var todayMandala: MandalaIdentity?
    @Published var recentEntries: [DiaryEntry] = []
    @Published var averagePh: Double = 7.36
    @Published var totalKriyas: Int = 0
    
    private let mandalaManager: MandalaManager
    private let diaryStore: DiaryStore
    private let phStore: PhStore
    
    init(mandalaManager: MandalaManager, diaryStore: DiaryStore, phStore: PhStore) {
        self.mandalaManager = mandalaManager
        self.diaryStore = diaryStore
        self.phStore = phStore
        loadDashboardData()
    }
    
    /// Carga datos para el dashboard
    func loadDashboardData() {
        todayMandala = mandalaManager.mandalaForToday()
        recentEntries = Array(diaryStore.entries.sorted { $0.timestamp > $1.timestamp }.prefix(5))
        updateStatistics()
    }
    
    /// Actualiza estadísticas
    private func updateStatistics() {
        if !phStore.entries.isEmpty {
            averagePh = phStore.entries.map { $0.value }.reduce(0, +) / Double(phStore.entries.count)
        }
        totalKriyas = diaryStore.entries.count
    }
}
