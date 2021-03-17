//
//  ViewController.swift
//  CombineRaffle
//
//  Created by MeTaLnOdEuG on 17/03/2021.
//

import UIKit
import Combine

class ViewController: UIViewController {
    @IBOutlet weak var button: UIButton!
    @IBOutlet weak var label: UILabel!

    private var subscriptions = [AnyCancellable]()
    private let player = AudioPlayer()

    @IBAction func raffle(_ sender: Any) {
        button.isEnabled = false
        Timer
            .publish(every: 0.1, on: .main, in: .common)
            .autoconnect()
            .map { _ in emojis.randomElement() ?? "" }
            .prefix(untilOutputFrom: player.playPublisher(.drumroll))
            .append(names.randomElement() ?? "")
            .handleEvents(receiveCompletion: { [weak self] _ in
                self?.player.play(.tada)
                self?.button.isEnabled = true
            })
            .assign(to: \.text, on: label)
            .store(in: &subscriptions)
    }
}

