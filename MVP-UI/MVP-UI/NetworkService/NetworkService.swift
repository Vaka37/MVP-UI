// NetworkService.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Работа с запросами
final class NetworkService {
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

    var component = URLComponents()
    var scheme = "https"
    var host = "api.edamam.com"
    var path = "/api/recipes/v2"
    var urlQueryItems: [URLQueryItem] = [
        .init(name: "type", value: "public"),
        .init(name: "app_id", value: "a726fb9c"),
        .init(name: "app_key", value: "2412c4c0d52ca924f6d6a486c1aa1ab6"),
        .init(name: "dishType", value: DishType.salad.rawValue)
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
