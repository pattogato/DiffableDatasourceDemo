//
//  ViewController.swift
//  CollectionvViewDemo
//
//  Created by Bence Pattogato on 23/08/2021.
//

import UIKit

struct WeatherViewModel {
    var sections: [Section: [AnyHashable]]
    let title: String

    enum Section: Int, Hashable, CaseIterable {
        case hourly
        case daily

        var order: Int {
            switch self {
            case .hourly: return 0
            case .daily: return 1
            }
        }
    }
}

class WeatherViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    private lazy var dataSource = WeatherCollectionViewDataSource(collectionView: collectionView)

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        collectionView.dataSource = dataSource
        collectionView.setCollectionViewLayout(WeatherCollectionViewLayout(), animated: false)
        self.configure(with: WeatherViewModel(days: WeatherData.sample))
    }

    private var viewModel: WeatherViewModel?

    func configure(with viewModel: WeatherViewModel) {
        self.viewModel = viewModel
        title = viewModel.title
        dataSource.apply(makeSnapshot())
    }

    private func makeSnapshot() -> NSDiffableDataSourceSnapshot<WeatherViewModel.Section, AnyHashable> {
        var snapshot = NSDiffableDataSourceSnapshot<WeatherViewModel.Section, AnyHashable>()

        viewModel?.sections.sorted(by: { $0.key.order < $1.key.order }).forEach { section, items in
            snapshot.appendSections([section])
            snapshot.appendItems(items, toSection: section)
        }

        return snapshot
    }

}

enum WeatherIcon: String, CaseIterable {
    case sunny = "☀️"
    case cloudy = "☁️"
    case rainy = "🌧"

    static func random() -> WeatherIcon {
        WeatherIcon.allCases[Int.random(in: 0...2)]
    }
}

struct DayEntry: Hashable {
    let name: String
    let icon: WeatherIcon
    let minTemp: String
    let maxTemp: String
    let hours: [HourEntry]
}

struct HourEntry: Hashable {
    let time: String
    let icon: WeatherIcon
    let temperature: String
}
