import Foundation
import Combine

/// ViewModel mejorado para el dashboard principal de Mac
class MainViewModel: ObservableObject {
    @Published var selectedTab: Int = 0
    @Published var todayMandala: MandalaIdentity?
    @Published var recentEntries: [DiaryEntry] = []
    @Published var averagePh: Double = 7.36
    @Published var totalKriyas: Int = 0
    @Published var favoriteEntries: [DiaryEntry] = []
    @Published var weeklyStreak: Int = 0
    @Published var lastSyncDate: Date?
    
    private let mandalaManager: MandalaManager
    private let diaryStore: DiaryStore
    private let phStore: PhStore
    private let syncManager: SyncManager
    
    init(mandalaManager: MandalaManager, diaryStore: DiaryStore, phStore: PhStore, syncManager: SyncManager) {
        self.mandalaManager = mandalaManager
        self.diaryStore = diaryStore
        self.phStore = phStore
        self.syncManager = syncManager
        loadDashboardData()
    }
    
    /// Carga datos para el dashboard
    func loadDashboardData() {
        todayMandala = mandalaManager.mandalaForToday()
        recentEntries = Array(diaryStore.entries.sorted { $0.timestamp > $1.timestamp }.prefix(5))
        favoriteEntries = diaryStore.entries.filter { $0.isFavorite }
        updateStatistics()
        lastSyncDate = syncManager.lastSyncDate
    }
    
    /// Actualiza estadísticas
    private func updateStatistics() {
        if !phStore.entries.isEmpty {
            averagePh = phStore.entries.map { $0.value }.reduce(0, +) / Double(phStore.entries.count)
        }
        totalKriyas = diaryStore.entries.count
        weeklyStreak = calculateWeeklyStreak()
    }
    
    /// Calcula racha semanal de prácticas
    private func calculateWeeklyStreak() -> Int {
        let calendar = Calendar.current
        let now = Date()
        var streak = 0
        
        for i in 0..<7 {
            let date = calendar.date(byAdding: .day, value: -i, to: now) ?? now
            let hasEntry = diaryStore.entries.contains { calendar.isDate($0.timestamp, inSameDayAsDate: date) }
            if hasEntry {
                streak += 1
            } else {
                break
            }
        }
        
        return streak
    }
    
    /// Sincroniza con iCloud
    func syncWithCloud() {
        syncManager.syncDiaryEntries(diaryStore.entries)
    }
}
