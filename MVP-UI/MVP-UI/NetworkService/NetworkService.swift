// NetworkService.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Работа с запросами
final class NetworkService {
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

    enum DishType: String {
        case salad
        case soup
        case chicken
        case meat
        case fish
        case sideDish
        case pancake
        case drinks
        case desserts
    }

    private var component = URLComponents()
    private let scheme = Constants.scheme
    private let host = Constants.host
    private let path = Constants.path
    private let urlQueryItems: [URLQueryItem] = [
        .init(name: Constants.componentsTypeKey, value: Constants.type),
        .init(name: Constants.identefire, value: Constants.appId),
        .init(name: Constants.componnentsAppKey, value: Constants.appKey),
        .init(name: Constants.componentsDishTypeKey, value: DishType.salad.rawValue)
    ]

    func getRecipe(completionHandler: @escaping (Result<RecipesStorage, Error>) -> Void) {
        component.scheme = scheme
        component.host = host
        component.queryItems = urlQueryItems
        component.path = path
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
                    print(resultDetailsDTO)
                } catch {
                    print(error.localizedDescription)
                }
            }
        }.resume()
    }

    func getDetail(uri: String, completionHandler: @escaping (Result<RecipeDetail, Error>) -> Void) {
        let urlQueryItemsDetail: [URLQueryItem] = [.init(name: uri, value: "")]
        component.scheme = scheme
        component.host = host
        component.queryItems = urlQueryItems
        component.path = path
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
                    let resultDetailsDTO = try JSONDecoder().decode(RecipeRetailDTO.self, from: data)
                    print(resultDetailsDTO)
                } catch {
                    print(error.localizedDescription)
                }
            }
        }.resume()
    }
}
