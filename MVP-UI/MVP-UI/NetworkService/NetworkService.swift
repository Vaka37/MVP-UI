// NetworkService.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

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

    var discription: String {
        switch self {
        case .meat, .fish, .chicken, .sideDish:
            "Main course"
        case .salad:
            "Salad"
        case .soup:
            "Soup"
        case .pancake:
            "Pancake"
        case .drinks:
            "Drinks"
        case .desserts:
            "Desserts"
        }
    }
}

/// Протокол коммуникации с NetworkService
protocol NetworkServiceProtocol {
    /// получение рецептов
    func getRecipe(type: DishType, completionHandler: @escaping (Result<[RecipeCommonInfo], Error>) -> Void)
    /// получение детальней рецепта
    func getDetail(uri: String, completionHandler: @escaping (Result<RecipeDetail, Error>) -> Void)
}

/// Сервис  для работы с сетевыми запросами
final class NetworkService: NetworkServiceProtocol {
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

    private var component = URLComponents()
    private let scheme = Constants.scheme
    private let host = Constants.host
    private let path = Constants.path
//    private var urlQueryItems: [URLQueryItem] {
//        createURLQueryItems()
//    }

    func createURLQueryItems(type: DishType) -> [URLQueryItem] {
        [
            URLQueryItem(name: Constants.componentsTypeKey, value: Constants.type),
            URLQueryItem(name: Constants.identefire, value: Constants.appId),
            URLQueryItem(name: Constants.componnentsAppKey, value: Constants.appKey),
            URLQueryItem(name: Constants.componentsDishTypeKey, value: type.discription)
        ]
    }

    func createURLComponents(type: DishType) {
        component.scheme = scheme
        component.host = host
        component.queryItems = createURLQueryItems(type: type)
        component.path = path
    }

    func getRecipe(type: DishType, completionHandler: @escaping (Result<[RecipeCommonInfo], Error>) -> Void) {
        createURLComponents(type: type)
//        let urlQueryItem = URLQueryItem(name: Constants.componentsDishTypeKey, value: type.rawValue)
//        component.queryItems?.append(urlQueryItem)

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
                    let result = resultDetailsDTO.hits.map { RecipeCommonInfo(dto: $0.recipe) }
                    completionHandler(.success(result))
                } catch {
                    completionHandler(.failure(error))
                }
            }
        }.resume()
    }

    func getDetail(uri: String, completionHandler: @escaping (Result<RecipeDetail, Error>) -> Void) {
        let urlQueryItemsDetail: [URLQueryItem] = [.init(name: uri, value: "")]
        createURLComponents(type: .salad)
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
                    guard let result = recipeDetailsDTO.hits.first else { return }
                    let detail = RecipeDetail(dto: result.recipe)
                    completionHandler(.success(detail))
                } catch {
                    completionHandler(.failure(error))
                }
            }
        }.resume()
    }
}
