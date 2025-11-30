import Foundation
import Combine

/// ViewModel para registro de signos vitales en Watch
class VitalViewModel: ObservableObject {
    @Published var heartRate: Double = 72
    @Published var hrv: Double = 48
    @Published var breathingRate: Double = 14
    @Published var temperature: Double = 36.5
    @Published var oxygenLevel: Double = 98.0
    @Published var phLevel: Double = 7.36
    @Published var mood: String = "normal"
    @Published var isLoading: Bool = false
    
    private let diaryStore: DiaryStore
    
    init(diaryStore: DiaryStore) {
        self.diaryStore = diaryStore
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
    
    /// Restablece valores a predeterminados
    func reset() {
        heartRate = 72
        hrv = 48
        breathingRate = 14
        temperature = 36.5
        oxygenLevel = 98.0
        phLevel = 7.36
        mood = "normal"
    }
}
