import Foundation
import Combine

/// ViewModel para gestión de pH en Mac
class PhViewModel: ObservableObject {
    @Published var entries: [PhHistoryEntry] = []
    @Published var currentValue: Double = 7.36
    @Published var suggestion: String = ""
    @Published var averagePh: Double = 7.36
    @Published var trend: String = "stable"
    
    private let phStore: PhStore
    
    init(phStore: PhStore) {
        self.phStore = phStore
        loadData()
    }
    
    /// Carga historial de pH
    func loadData() {
        entries = phStore.entries.sorted { $0.date > $1.date }
        updateStatistics()
    }
    
    /// Añade nuevo registro
    func addEntry(value: Double) {
        phStore.add(value: value, date: Date())
        currentValue = value
        updateSuggestion(for: value)
        loadData()
    }
    
    /// Actualiza sugerencia según pH
    private func updateSuggestion(for ph: Double) {
        if ph < 7.35 {
            suggestion = "Sangre ácida: consume más vegetales verdes, limones, naranjas y brotes."
        } else if ph > 7.45 {
            suggestion = "Tendencia alcalina: mantén dieta balanceada y observa tu bienestar."
        } else {
            suggestion = "pH óptimo: continúa con tu dieta saludable y práctica de yoga."
        }
    }
    
    /// Actualiza estadísticas
    private func updateStatistics() {
        if !entries.isEmpty {
            averagePh = entries.map { $0.value }.reduce(0, +) / Double(entries.count)
            determineTrend()
        }
    }
    
    /// Determina tendencia (subiendo/bajando/estable)
    private func determineTrend() {
        guard entries.count >= 3 else {
            trend = "insufficient_data"
            return
        }
        let recent = entries.prefix(3).map { $0.value }
        let avg = recent.reduce(0, +) / Double(recent.count)
        if recent.first ?? 0 > avg {
            trend = "rising"
        } else if recent.first ?? 0 < avg {
            trend = "falling"
        } else {
            trend = "stable"
        }
    }
}
