// NetworkService.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Протокол коммуникации с NetworkService
protocol NetworkServiceProtocol {}

/// Сервис  для работы с сетевыми запросами
final class NetworkService {
    // MARK: - Constants

    private enum Constants {
        static let scheme = "https"
        static let host = "api.edamam.com"
        static let path = "/api/recipes/v2"
        static let componentsTypeKey = "type"
        static let identefire = "app_id"
        static let componnentsAppKey = "app_key"
        static let componentsDishTypeKey = "dishType"
        static let type = "public"
        static let appKey = "2412c4c0d52ca924f6d6a486c1aa1ab6"
        static let appId = "a726fb9c"
        static let dishType = "dishType"
    }

    // MARK: - DishType

    /// Категории рецептов
    enum DishType: String {
        /// Салат
        case salad
        /// Суп
        case soup
        /// Курица
        case chicken
        /// Мясо
        case meat
        /// Рыба
        case fish
        /// Гарниры
        case sideDish
        /// Блины
        case pancake
        /// Напитки
        case drinks
        /// Десерты
        case desserts
    }

    private var component = URLComponents()
    private let scheme = Constants.scheme
    private let host = Constants.host
    private let path = Constants.path
    private var urlQueryItems: [URLQueryItem] {
        createURLQueryItems()
    }

    func createURLQueryItems() -> [URLQueryItem] {
        [
            URLQueryItem(name: Constants.componentsTypeKey, value: Constants.type),
            URLQueryItem(name: Constants.identefire, value: Constants.appId),
            URLQueryItem(name: Constants.componnentsAppKey, value: Constants.appKey),
            URLQueryItem(name: Constants.componentsDishTypeKey, value: DishType.salad.rawValue)
        ]
    }

    func createURLComponents() {
        component.scheme = scheme
        component.host = host
        component.queryItems = urlQueryItems
        component.path = path
    }

    func getRecipe(completionHandler: @escaping (Result<RecipeCommonInfo, Error>) -> Void) {
        createURLComponents()
        guard let url = component.url else { return }
        let request = URLRequest(url: url)
        URLSession.shared.dataTask(with: request) { data, _, error in
            if let error = error {
                completionHandler(.failure(error))
                return
            }
            if let data = data {
                do {
                    let resultDetailsDTO = try JSONDecoder().decode(RecipeResponseDTO.self, from: data)
                    for item in resultDetailsDTO.hits {
                        completionHandler(.success(RecipeCommonInfo(dto: item.recipe)))
                    }
                } catch {}
            }
        }.resume()
    }

    func getDetail(uri: String, completionHandler: @escaping (Result<RecipeDetail, Error>) -> Void) {
        let urlQueryItemsDetail: [URLQueryItem] = [.init(name: uri, value: "")]
        createURLComponents()
        component.queryItems?.append(contentsOf: urlQueryItemsDetail)
        guard let url = component.url else { return }
        let request = URLRequest(url: url)
        URLSession.shared.dataTask(with: request) { data, _, error in
            if let error = error {
                completionHandler(.failure(error))
                return
            }
            if let data = data {
                do {
                    let recipeDetailsDTO = try JSONDecoder().decode(RecipeDetailDTO.self, from: data)
                    let ricepe = recipeDetailsDTO.hits
                    for item in ricepe {
                        completionHandler(.success(RecipeDetail(dto: item.recipe)))
                    }
                } catch {}
            }
        }.resume()
    }
}

// MARK: - Extension + NetworkServiceProtocol

extension NetworkService: NetworkServiceProtocol {}
