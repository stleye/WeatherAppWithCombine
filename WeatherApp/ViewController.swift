//
//  ViewController.swift
//  WeatherApp
//
//  Created by Sebastian Tleye on 22/02/2020.
//  Copyright © 2020 HumileAnts. All rights reserved.
//

import UIKit
import Combine

class ViewController: UIViewController {

    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var cityTextField: UITextField!

    private var webService = Webservice()
    private var cancellable: AnyCancellable?

    override func viewDidLoad() {
        super.viewDidLoad()

        self.setupPublishers()

//        self.cancellable = self.webService.fetchWeather(city: "Villa General Belgrano")
//            .catch { _ in Just(Weather.placeHolder) }
//            .map({ weather in
//                if let temp = weather.temp {
//                    return "\(temp)"
//                }
//                return "Could not find termperature"
//            })
//            .assign(to: \.text, on: temperatureLabel)

    }

    private func setupPublishers() {
        let publisher = NotificationCenter.default.publisher(for: UITextField.textDidChangeNotification, object: self.cityTextField)

        self.cancellable = publisher.compactMap {
            ($0.object as! UITextField).text?.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)
        }.debounce(for: .milliseconds(500), scheduler: RunLoop.main)
            .flatMap { city in
                return self.webService.fetchWeather(city: city)
                    .catch { _ in Just(Weather.placeHolder) }
                    .map { $0 }
        }.sink {
            if let temp = $0.temp {
                self.temperatureLabel.text = "\(temp) ℉"
            } else {
                self.temperatureLabel.text = ""
            }
        }
    }

}

