import Foundation

/// Entrada del diario personal asociada a una práctica, signos vitales y coaching
struct DiaryEntry: Identifiable, Codable, Equatable {
    let id: UUID
    var timestamp: Date
    var kriyaName: String
    var notes: String
    var mood: String
    var coachingMessage: String
    var beforeVitals: VitalSigns
    var afterVitals: VitalSigns
    var photoAttachment: String?      // Ruta/URL imagen opcional
    var rating: Int?                  // Valoración opcional (1-5 estrellas)
    var isFavorite: Bool              // Marcar entrada como especial

    init(
        timestamp: Date = Date(),
        kriyaName: String,
        notes: String,
        mood: String,
        coachingMessage: String,
        beforeVitals: VitalSigns,
        afterVitals: VitalSigns,
        photoAttachment: String? = nil,
        rating: Int? = nil,
        isFavorite: Bool = false
    ) {
        self.id = UUID()
        self.timestamp = timestamp
        self.kriyaName = kriyaName
        self.notes = notes
        self.mood = mood
        self.coachingMessage = coachingMessage
        self.beforeVitals = beforeVitals
        self.afterVitals = afterVitals
        self.photoAttachment = photoAttachment
        self.rating = rating
        self.isFavorite = isFavorite
    }
}
