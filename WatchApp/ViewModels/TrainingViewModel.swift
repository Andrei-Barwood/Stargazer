import Foundation
import Combine

/// ViewModel para gestionar el flujo de entrenamiento guiado
class TrainingViewModel: ObservableObject {
    @Published var currentKriya: Kriya?
    @Published var currentStepIndex: Int = 0
    @Published var isTraining: Bool = false
    @Published var secondsElapsed: Int = 0
    @Published var isFinished: Bool = false
    
    private var timer: Timer?
    private let diaryStore: DiaryStore
    
    init(diaryStore: DiaryStore) {
        self.diaryStore = diaryStore
    }
    
    /// Inicia el entrenamiento guiado
    func startTraining(with kriya: Kriya) {
        currentKriya = kriya
        isTraining = true
        startTimer()
    }
    
    /// Detiene el entrenamiento
    func stopTraining() {
        isTraining = false
        timer?.invalidate()
        timer = nil
    }
    
    /// Avanza al siguiente paso
    func nextStep() {
        guard let kriya = currentKriya else { return }
        if currentStepIndex < kriya.steps.count - 1 {
            currentStepIndex += 1
        } else {
            completeTraining()
        }
    }
    
    /// Retrocede al paso anterior
    func previousStep() {
        if currentStepIndex > 0 {
            currentStepIndex -= 1
        }
    }
    
    /// Marca el entrenamiento como completo
    func completeTraining() {
        isFinished = true
        stopTraining()
    }
    
    /// Inicia cronómetro
    private func startTimer() {
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { [weak self] _ in
            self?.secondsElapsed += 1
        }
    }
}
