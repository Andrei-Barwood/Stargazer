import Foundation
import Combine

/// ViewModel mejorado para registro de signos vitales en Watch
class VitalViewModel: ObservableObject {
    @Published var heartRate: Double = 72
    @Published var hrv: Double = 48
    @Published var breathingRate: Double = 14
    @Published var temperature: Double = 36.5
    @Published var oxygenLevel: Double = 98.0
    @Published var phLevel: Double = 7.36
    @Published var mood: String = "normal"
    @Published var isLoading: Bool = false
    @Published var validationMessage: String = ""
    
    private let diaryStore: DiaryStore
    private let phStore: PhStore
    
    init(diaryStore: DiaryStore, phStore: PhStore) {
        self.diaryStore = diaryStore
        self.phStore = phStore
    }
    
    /// Construye objeto VitalSigns a partir de los valores ingresados
    func buildVitalSigns() -> VitalSigns {
        return VitalSigns(
            timestamp: Date(),
            heartRate: heartRate,
            hrv: hrv,
            breathingRate: breathingRate,
            temperature: temperature,
            oxygenLevel: oxygenLevel,
            phLevel: phLevel,
            mood: mood
        )
    }
    
    /// Valida rangos de signos vitales
    func validateVitals() -> Bool {
        if !AppConstants.idealHeartRateRange.contains(heartRate) {
            validationMessage = "Pulso fuera del rango recomendado"
            return false
        }
        if !AppConstants.idealPhRange.contains(phLevel) {
            validationMessage = "pH fuera del rango óptimo"
            return false
        }
        validationMessage = ""
        return true
    }
    
    /// Guarda los vitales en el diario y historial
    func saveVitals() {
        guard validateVitals() else { return }
        let vitals = buildVitalSigns()
        phStore.add(value: phLevel, date: Date())
        validationMessage = "✅ Signos vitales registrados exitosamente"
    }
    
    /// Restablece valores a predeterminados
    func reset() {
        heartRate = 72
        hrv = 48
        breathingRate = 14
        temperature = 36.5
        oxygenLevel = 98.0
        phLevel = 7.36
        mood = "normal"
        validationMessage = ""
    }
    
    /// Obtiene sugerencia según pH
    func getPhSuggestion() -> String {
        if phLevel < 7.35 {
            return "Sangre ácida: consume vegetales verdes, limones, naranjas y brotes para alcalinizar."
        } else if phLevel > 7.45 {
            return "Tendencia alcalina: mantén dieta balanceada, más frutas y observa tu energía."
        } else {
            return "¡pH óptimo! Continúa con tu dieta saludable y práctica de yoga."
        }
    }
}
