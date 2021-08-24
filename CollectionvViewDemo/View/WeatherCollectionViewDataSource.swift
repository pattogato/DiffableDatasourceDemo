//
//  WeatherCollectionViewDataSource.swift
//  CollectionvViewDemo
//
//  Created by Bence Pattogato on 24/08/2021.
//

import Foundation
import UIKit

final class WeatherCollectionViewDataSource: UICollectionViewDiffableDataSource<WeatherViewModel.Section, AnyHashable> {
    init(collectionView: UICollectionView) {
        super.init(collectionView: collectionView) { (collectionView: UICollectionView, indexPath: IndexPath, item: AnyHashable) -> UICollectionViewCell? in
            switch item {
            case let hourEntry as HourEntry:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HourlyEntryCell", for: indexPath)
                (cell as? HourlyEntryCollectionViewCell)?.configure(with: hourEntry)
                return cell
            case let dayEntry as DayEntry:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DailyEntryCell", for: indexPath)
                (cell as? DailyEntryCollectionViewCell)?.configure(with: dayEntry)
                return cell
            default:
                let sectionType = WeatherViewModel.Section.allCases[indexPath.section]
                fatalError("Not covered section and item type combination for item: \(item) with section type: \(sectionType) position: \(indexPath)")
            }
        }
    }
}
