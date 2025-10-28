import Foundation

/// Utilidad para generar mensajes de coaching adaptativos según los resultados del usuario
struct CoachingGenerator {
    static func generate(
        kriya: Kriya,
        beforeVitals: VitalSigns,
        afterVitals: VitalSigns
    ) -> String {
        var improvements: [String] = []

        if afterVitals.hrv > beforeVitals.hrv {
            improvements.append("¡Tu variabilidad cardíaca ha mejorado, indica mayor resiliencia y vitalidad!")
        }
        if let beforePH = beforeVitals.phLevel, let afterPH = afterVitals.phLevel, afterPH > beforePH {
            improvements.append("Tu pH sanguíneo se está alcalinizando, cuidando tu energía y elasticidad.")
        }
        if afterVitals.heartRate < beforeVitals.heartRate {
            improvements.append("Tu corazón late con mayor armonía y calma.")
        }
        if afterVitals.breathingRate < beforeVitals.breathingRate {
            improvements.append("Tu respiración se ha profundizado, reflejando paz interna.")
        }
        if afterVitals.mood == "feliz" && beforeVitals.mood != "feliz" {
            improvements.append("Lograste transformar tu ánimo hacia la dicha y la serenidad.")
        }

        var baseMessage = ""
        switch kriya.category {
            case "Balance físico y rejuvenecimiento":
                baseMessage = "Has potenciado tu energía vital y te acercas más a tu mejor versión física."
            case "Sistema emocional y mental":
                baseMessage = "Tu paz mental se refleja en tu bienestar corporal y emocional."
            case "Sistema digestivo y restauración interna":
                baseMessage = "Tu sistema digestivo se fortalece y tu cuerpo agradece cada movimiento consciente."
            // Agregar más categorías según sea necesario
            default:
                baseMessage = "Tu práctica de hoy genera beneficios profundos en tu cuerpo y mente."
        }

        let changes = improvements.joined(separator: " ")
        return "\(baseMessage) \(changes)"
    }
}
