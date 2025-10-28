import Foundation

/// Representa un registro de signos vitales en un momento determinado
struct VitalSigns: Identifiable, Codable, Equatable {
    let id: UUID
    var timestamp: Date
    var heartRate: Double         // Latidos por minuto
    var hrv: Double               // Heart Rate Variability (ms)
    var breathingRate: Double     // Respiraciones por minuto
    var temperature: Double       // Celsius
    var oxygenLevel: Double       // En porcentaje (ej: 98.0)
    var phLevel: Double?          // Ingreso manual, opcional
    var mood: String              // "feliz", "triste", "enérgica", etc.
    var emotionalScore: Double?   // Opcional, cuantificación emocional
    var sexualBalanceScore: Double? // Opcional, indicador indirecto

    init(
        timestamp: Date = Date(),
        heartRate: Double,
        hrv: Double,
        breathingRate: Double,
        temperature: Double,
        oxygenLevel: Double,
        phLevel: Double? = nil,
        mood: String,
        emotionalScore: Double? = nil,
        sexualBalanceScore: Double? = nil
    ) {
        self.id = UUID()
        self.timestamp = timestamp
        self.heartRate = heartRate
        self.hrv = hrv
        self.breathingRate = breathingRate
        self.temperature = temperature
        self.oxygenLevel = oxygenLevel
        self.phLevel = phLevel
        self.mood = mood
        self.emotionalScore = emotionalScore
        self.sexualBalanceScore = sexualBalanceScore
    }
}
