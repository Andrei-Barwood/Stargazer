import Foundation

/// Representa una práctica o ejercicio de Kundalini Yoga con estructura para guía y registro
struct Kriya: Identifiable, Codable, Equatable {
    let id: UUID
    var name: String
    var benefit: String
    var category: String
    var recommendedDuration: Int // En minutos
    var intensity: String // "Baja", "Media", "Alta"
    var description: String
    var steps: [String]
    var notes: String?
    var link: String?

    init(
        name: String,
        benefit: String,
        category: String,
        recommendedDuration: Int,
        intensity: String,
        description: String,
        steps: [String],
        notes: String? = nil,
        link: String? = nil
    ) {
        self.id = UUID()
        self.name = name
        self.benefit = benefit
        self.category = category
        self.recommendedDuration = recommendedDuration
        self.intensity = intensity
        self.description = description
        self.steps = steps
        self.notes = notes
        self.link = link
    }
}
