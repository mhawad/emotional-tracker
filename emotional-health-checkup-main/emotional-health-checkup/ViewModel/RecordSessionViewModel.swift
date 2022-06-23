//
//  SessionViewModel.swift
//  happy-tracker
//
//  Created by Patrick Fuller on 3/28/22.
//

import SwiftUI
import Combine
import Firebase

class RecordSessionViewModel: ObservableObject {
    
    @Published var frame: CGImage?
    @Published var cameraError: CameraError?
    @Published var stopwatchCounter = 0
    
    var frameManager = FrameManager.shared
    var cameraManager = CameraManager.shared
    var stopwatch = Stopwatch()
    
    var predictionCounter = PredictionCounter()
    
    private var cancellables = Set<AnyCancellable>()
    
    @Published var status = Status.notStarted
    
    enum Status {
        case notStarted
        case isRecording
        case gettingText
        case done
    }
    
    
    init() {
        setUpBaseSubscriptions()
    }
    
    // MARK: - Session activity
    
    func startSession() {
        // view will show timerView
        self.status = .isRecording
        // start adding / set up subscription
        
        DispatchQueue.main.async {
            self.frameManager.$current
                .sink { cvpBuffer in
                    // send cvpBuffer to predictionCounter
                    self.predictionCounter.addBuffer(cvpBuffer: cvpBuffer)
                }
            // STORE SUBSCRIPTION IN CANCELLABLES
                .store(in: &self.cancellables)
            // start stopwatch
            self.stopwatch.startStop()
        }
    }
    
    func stopSession() {
        // stop stopwatch
        stopwatch.startStop()
        // stop adding / cancel subscriptions by removing old reference
        cancellables = Set<AnyCancellable>()
        // view will show text window
        self.status = .gettingText
    }
    
    func submitSession(comment: String) {
        // view will hide text window & show thank you done window
        self.status = .done
        // persist sessionEntry
        
        // Create Record Model and do firestore upload recordModel
        guard let userID = Auth.auth().currentUser?.uid else { return }
        
        let (hConf, sConf) = predictionCounter.getTotalHappyAndSad()
        
        let sessionRecord = RecordModel(
            userID: userID,
            timestamp: Timestamp(date: .now),
            happyConf: hConf,
            sadConf: sConf,
            comment: comment)
        
        SessionService.uploadSession(session: sessionRecord)
    }
    
    func resetSession() {
        // View will revert to beginnig
        self.status = .notStarted
        
        // Reset session
        self.predictionCounter = PredictionCounter()
    }
    
    // MARK: - Visual Activity
    
    func startCamera() {
        if cameraManager.status == .unconfigured {
            cameraManager.configure()
        }
        cameraManager.session.startRunning()
    }
    
    func stopCamera() {
        cameraManager.session.stopRunning()
    }
    
    func setUpBaseSubscriptions() {
        
        /// set up stopwatch subscription
        stopwatch.$time
            .assign(to: &$stopwatchCounter)
        
        /// Pass along any camera errors from camera manager
        cameraManager.$error
            .receive(on: RunLoop.main)
            .assign(to: &$cameraError)
        
        /// Pass along visual stream as cgimage for frame view
        frameManager.$current
            .receive(on: RunLoop.main)
            .compactMap { cvpBuffer in
                return CGImage.create(from: cvpBuffer)
            }
            .assign(to: &$frame)
    }
}
