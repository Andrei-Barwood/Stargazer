import Foundation

/// Motor de sugerencias para seleccionar automáticamente rutinas/kriyas basadas en signos, pH y estado emocional
struct SuggestionEngine {
    static func suggestKriya(
        from catalog: [Kriya],
        with vitals: VitalSigns
    ) -> (kriya: Kriya?, reason: String) {
        // Prioridad: HRV baja → rejuvenecimiento, pH ácido → digestivo, ánimo bajo → emocional, óptimo → mantenimiento
        if vitals.hrv < 40 {
            if let kriya = catalog.first(where: { $0.category == "Balance físico y rejuvenecimiento" }) {
                return (kriya, "Baja variabilidad cardíaca: recomendable trabajar rejuvenecimiento y resiliencia.")
            }
        }
        if let ph = vitals.phLevel, ph < 7.2 {
            if let kriya = catalog.first(where: { $0.category == "Sistema digestivo y restauración interna" }) {
                return (kriya, "Sangre ligeramente ácida: sugerimos rutina de purificación y digestión.")
            }
        }
        if vitals.mood == "triste" {
            if let kriya = catalog.first(where: { $0.category == "Sistema emocional y mental" }) {
                return (kriya, "Ánimo bajo: rutina especial para restaurar la paz emocional.")
            }
        }
        // Default: rutina de longevidad/mantenimiento
        if let kriya = catalog.first(where: { $0.category == "Sistema hormonal y longevidad" }) {
            return (kriya, "Signos óptimos: rutina para longevidad y mantenimiento.")
        }
        return (catalog.first, "Rutina sugerida por balance general.")
    }
}
