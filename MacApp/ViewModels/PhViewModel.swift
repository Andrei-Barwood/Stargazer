import Foundation
import Combine

/// ViewModel mejorado para gestión de pH en Mac
class PhViewModel: ObservableObject {
    @Published var entries: [PhHistoryEntry] = []
    @Published var currentValue: Double = 7.36
    @Published var suggestion: String = ""
    @Published var averagePh: Double = 7.36
    @Published var trend: String = "stable"
    @Published var maxPh: Double = 7.36
    @Published var minPh: Double = 7.36
    @Published var monthlyAverage: Double = 7.36
    
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
            suggestion = "⚠️ Sangre ácida: consume más vegetales verdes (espinaca, kale, brócoli), limones, naranjas, zanahoria y remolacha en jugo. Evita carnes fritas y alimentos procesados."
        } else if ph > 7.45 {
            suggestion = "🌿 Tendencia alcalina: mantén dieta balanceada, incorpora más frutas frescas y observa tu nivel de energía. Considera aumentar proteína vegetal (legumbres)."
        } else {
            suggestion = "✅ pH óptimo: continúa con tu dieta saludable, práctica de yoga y meditación. ¡Estás en el camino correcto!"
        }
    }
    
    /// Actualiza estadísticas
    private func updateStatistics() {
        guard !entries.isEmpty else { return }
        
        averagePh = entries.map { $0.value }.reduce(0, +) / Double(entries.count)
        maxPh = entries.map { $0.value }.max() ?? 7.36
        minPh = entries.map { $0.value }.min() ?? 7.36
        
        determineTrend()
        calculateMonthlyAverage()
    }
    
    /// Determina tendencia (subiendo/bajando/estable)
    private func determineTrend() {
        guard entries.count >= 3 else {
            trend = "insufficient_data"
            return
        }
        let recent = Array(entries.prefix(3)).map { $0.value }
        let avg = recent.reduce(0, +) / Double(recent.count)
        if let first = recent.first {
            if first > avg {
                trend = "rising"
            } else if first < avg {
                trend = "falling"
            } else {
                trend = "stable"
            }
        }
    }
    
    /// Calcula promedio mensual
    private func calculateMonthlyAverage() {
        let calendar = Calendar.current
        let now = Date()
        let startOfMonth = calendar.date(from: calendar.dateComponents([.year, .month], from: now)) ?? now
        
        let monthlyEntries = entries.filter { $0.date >= startOfMonth }
        monthlyAverage = monthlyEntries.isEmpty ? averagePh : monthlyEntries.map { $0.value }.reduce(0, +) / Double(monthlyEntries.count)
    }
}
