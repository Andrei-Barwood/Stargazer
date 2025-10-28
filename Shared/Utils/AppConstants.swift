import Foundation

/// Constantes globales y utilitarias para configuración, textos, colores y límites de la app
struct AppConstants {
    // Categorías principales para Kriyas
    static let kriyaCategories: [String] = [
        "Balance físico y rejuvenecimiento",
        "Sistema emocional y mental",
        "Sistema digestivo y restauración interna",
        "Circulación y corazón",
        "Sistema hormonal y longevidad",
        "Sistema inmune y defensa",
        "Vitalidad y juventud",
        "Respiración y pulmones"
    ]

    // Rangos ideales para signos vitales (pueden adaptarse por edad/género individual)
    static let idealHRVRange: ClosedRange<Double> = 42...85
    static let idealPhRange: ClosedRange<Double> = 7.35...7.45
    static let idealHeartRateRange: ClosedRange<Double> = 55...90
    static let idealBreathingRateRange: ClosedRange<Double> = 12...18
    static let idealOxygenLevel: Double = 96.0

    // Colores pastel recomendados (hex)
    static let pastelColors: [String] = [
        "#A2D6F9", "#FCD6E6", "#FFE5A5", "#B0EACD", "#F3B7D1", "#C4F1BE", "#E5C7FF", "#BEE4F2"
    ]

    // Frases de afirmación para rotación diaria
    static let affirmations: [String] = [
        "las nubes… a veces el viento sopla y eso las afecta",
        "toda forma depende del tiempo y del espacio, piérdela ahora!",
        "las palabras ganan impacto",
        "las acciones ganan impacto",
        "revelando imagen personal en 3… 2… 1…",
        "hora de comer dulces! (No en serio medita un poquito)",
        "la voluntad de estar viva es pertenencia De Dios, la voluntad de disfrutar y viajar hacia el sol se obtiene haciendo yoga",
        "No hay límite en la conciencia creativa",
        "alguien muy especial confía en ti",
        "no hay conflicto que el yoga no cure y regenere",
        "tu ego es de algodón, tu sangre de acero liquido",
        "armonía significa que no hay conflicto",
        "lo material no tiene valor",
        "bebidas…",
        "angel of thunders, please, erase them all"
    ]

    // Configuración de tests, timers, UI, etc.
    static let kriyaStepDefaultDuration: Int = 60 // segundos por paso, sugerido
    static let journalMaxCharacters: Int = 400
}
