//
//  ViewState.swift
//  MVP-UI
//
//  Created by Евгений Л on 14.03.2024.
//

import Foundation

enum ViewState<T> {
    case loading
    case data(T)
    case noData
    case error
}
