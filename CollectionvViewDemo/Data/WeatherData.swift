//
//  WeatherData.swift
//  CollectionvViewDemo
//
//  Created by Bence Pattogato on 24/08/2021.
//

import Foundation

enum WeatherData {
    static let sample: [DayEntry] = (0...20).map({
        DayEntry(
            name: Constants.days[$0 % 6],
            icon: .random(),
            minTemp: "\(Int.random(in: 12...18))°",
            maxTemp: "\(Int.random(in: 19...34))°",
            hours: makeRandomHourEntriesForADay()
        )
    })

    private static func makeRandomHourEntriesForADay() -> [HourEntry] {
        (0...23).map({
            HourEntry(
                time: "\($0):00",
                icon: .random(),
                temperature: "\(Int.random(in: 12...34))°"
            )
        })
    }
}

extension WeatherViewModel {
    init(days: [DayEntry]) {
        self.init(sections: [
            .daily: days,
            .hourly: days.first!.hours
        ],
        title: "London"
        )
    }
}

enum Constants {
    static let days: [String] = [
        "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday"
    ]
}
