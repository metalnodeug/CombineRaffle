//
//  audioPlayer.swift
//  CombineRaffle
//
//  Created by MeTaLnOdEuG on 17/03/2021.
//

import Foundation
import AVFoundation
import Combine

final class AudioPlayer {
    private var player: AVPlayer!

    func play(_ sound: Sound) {
        guard let url = Bundle.main.url(forResource: sound.rawValue, withExtension: "wav") else { return }

        do {
            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
            try AVAudioSession.sharedInstance().setActive(true)
        } catch let error {
            print("Failed setting session: \(error.localizedDescription)")
        }

        player = AVPlayer(url: url)
        player.volume = 1
        player.play()
    }

    func playPublisher(_ sound: Sound) -> AnyPublisher<Void, Never> {
        play(sound)
        return NotificationCenter.default
            .publisher(for: .AVPlayerItemDidPlayToEndTime)
            .map {_ in }
            .eraseToAnyPublisher()
    }
}

extension AudioPlayer {
    enum Sound: String {
        case drumroll
        case tada
    }
}
