import Foundation

/// Perfil personal del usuario, configuraciones y preferencias para customización y coaching
struct UserProfile: Identifiable, Codable, Equatable {
    let id: UUID
    var name: String
    var age: Int
    var hairType: String
    var identityScore: Double                  // Opcional, para tracking espiritual
    var preferences: Preferences

    init(
        name: String,
        age: Int,
        hairType: String,
        identityScore: Double = 0.0,
        preferences: Preferences = Preferences()
    ) {
        self.id = UUID()
        self.name = name
        self.age = age
        self.hairType = hairType
        self.identityScore = identityScore
        self.preferences = preferences
    }
}

/// Preferencias personalizables para mandalas, notificaciones, historial y playlist
struct Preferences: Codable, Equatable {
    var characterMandalaSelection: [String]      // Nombres/ref. visuales de personajes
    var notificationSchedule: [Reminder]         // Horario y textos de recordatorio
    var playlistHistory: [Playlist]              // Historial de playlists usadas

    init(
        characterMandalaSelection: [String] = [],
        notificationSchedule: [Reminder] = [],
        playlistHistory: [Playlist] = []
    ) {
        self.characterMandalaSelection = characterMandalaSelection
        self.notificationSchedule = notificationSchedule
        self.playlistHistory = playlistHistory
    }
}
