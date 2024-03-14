// RecipePresenter.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Протокол получения категории
protocol RecipesViewProtocol: AnyObject {
    /// Получение категории
    func getRecipes(recipes: [RecipeCommonInfo])
    /// Сортировка Рецептов
    func sortedRecip(recipe: [Recipe])
    /// Изменение соятояния кнопки сортировки время
    func buttonTimeState(color: String, image: String)
    /// Изменение соятояния кнопки сортировки каллорий
    func buttonCaloriesState(color: String, image: String)
    /// Меняем состояние View
    func updateStateView()
    /// Метод проверки получения данных в лист рецептов
    func emptyData()
    /// Метод проверки на ошибку при запросе к сервису
    func errorData()
}

/// Протокол рецептов
protocol RecipeProtocol: AnyObject {
    /// Получить рецепты
    func getRecipe()
    /// Метод для тапа по ячейке
    func tappedOnCell(recipe: Recipe)
    /// Сортировка рецептов
    func sortedRecipe(category: [Recipe])
    /// Парсит рецепты
    func parseRecipes()
}

/// Презентер экрана рецептов
final class RecipePresenter {
    // MARK: - Constants

    enum Constants {
        static let buttonSortedPressed = "buttonSortedPressed"
        static let backgroundDescription = "backgroundDescription"
        static let fitredLow = "fitredLow"
        static let sortedHigh = "sortedHigh"
        static let filterIcon = "filterIcon"
    }

    // MARK: - Private Properties

    private weak var detailsRecipeCoordinator: RecipesCoordinator?
    private weak var view: RecipesViewProtocol?
    private var category: Category
    private var recipeCommonInfo: [RecipeCommonInfo]?
    private var sortedCalories = SortedCalories.non
    private var sortedTime = SortedTime.non
    private var networkService = NetworkService()

    var state: ViewState<[RecipeCommonInfo]> = .loading {
        didSet {
            view?.updateStateView()
        }
    }

    // MARK: - Initializers

    init(view: RecipesViewProtocol, category: Category, detailsRecipeCoordinator: RecipesCoordinator) {
        self.view = view
        self.category = category
        self.detailsRecipeCoordinator = detailsRecipeCoordinator
        parseRecipes()
    }

    // MARK: - Public Methods

    /// Метод меняющий состояниие кнопки калорий
    func buttonCaloriesChange(category: [Recipe]) {
        switch sortedCalories {
        case .non:
            sortedCalories = .caloriesLow
            view?.buttonCaloriesState(color: Constants.buttonSortedPressed, image: Constants.fitredLow)
            sortedRecipe(category: category)
        case .caloriesLow:
            sortedCalories = .caloriesHigh
            view?.buttonCaloriesState(color: Constants.buttonSortedPressed, image: Constants.sortedHigh)
            sortedRecipe(category: category)
        case .caloriesHigh:
            sortedCalories = .non
            view?.buttonCaloriesState(color: Constants.backgroundDescription, image: Constants.filterIcon)
            sortedRecipe(category: category)
        }
    }

    /// Метод меняющий состояниие кнопки таймера
    func buttonTimeChange(category: [Recipe]) {
        switch sortedTime {
        case .non:
            sortedTime = .timeLow
            view?.buttonTimeState(color: Constants.buttonSortedPressed, image: Constants.fitredLow)
            sortedRecipe(category: category)
        case .timeLow:
            view?.buttonTimeState(color: Constants.buttonSortedPressed, image: Constants.sortedHigh)
            sortedTime = .timeHigh
            sortedRecipe(category: category)
        case .timeHigh:
            sortedTime = .non
            view?.buttonTimeState(color: Constants.backgroundDescription, image: Constants.filterIcon)
            sortedRecipe(category: category)
        }
    }
}

// MARK: - Extension + RecipeProtocol

extension RecipePresenter: RecipeProtocol {
    func parseRecipes() {
        networkService.getRecipe(type: category.categoryTitle) { [weak self] result in
            guard let self else { return }
            DispatchQueue.main.async {
                switch result {
                case let .success(recipes):
                    self.state = !recipes.isEmpty ? .data(recipes) : .noData
                    self.recipeCommonInfo = recipes
                    self.view?.getRecipes(recipes: self.recipeCommonInfo ?? [])
                case let .failure(error):
                    self.state = .error(error)
                }
            }
        }
    }

    func sortedCaloriesLow(items: [Recipe]) -> [Recipe] {
        if sortedTime == .timeLow {
            return items.sorted(by: { lhs, rhs in
                if lhs.caloriesTitle == rhs.caloriesTitle {
                    return lhs.cookingTimeTitle < rhs.cookingTimeTitle
                }
                return lhs.caloriesTitle < rhs.caloriesTitle
            })
        } else if sortedTime == .timeHigh {
            return items.sorted(by: { lhs, rhs in
                if lhs.caloriesTitle == rhs.caloriesTitle {
                    return lhs.cookingTimeTitle > rhs.cookingTimeTitle
                }
                return lhs.caloriesTitle < rhs.caloriesTitle
            })
        } else {
            return items.sorted(by: { $0.caloriesTitle < $1.caloriesTitle })
        }
    }

    func sortedCaloriesHigh(items: [Recipe]) -> [Recipe] {
        if sortedTime == .timeLow {
            return items.sorted(by: { lhs, rhs in
                if lhs.caloriesTitle == rhs.caloriesTitle {
                    return lhs.cookingTimeTitle > rhs.cookingTimeTitle
                }
                return lhs.caloriesTitle > rhs.caloriesTitle
            })
        } else if sortedTime == .timeHigh {
            return items.sorted(by: { lhs, rhs in
                if lhs.caloriesTitle == rhs.caloriesTitle {
                    return lhs.cookingTimeTitle < rhs.cookingTimeTitle
                }
                return lhs.caloriesTitle > rhs.caloriesTitle
            })
        } else {
            return items.sorted(by: { $0.caloriesTitle > $1.caloriesTitle })
        }
    }

    func sortedTimeLow(items: [Recipe]) -> [Recipe] {
        items.sorted(by: { lhs, rhs in
            if lhs.cookingTimeTitle == rhs.cookingTimeTitle {
                return lhs.caloriesTitle < rhs.caloriesTitle
            }
            return lhs.cookingTimeTitle < rhs.cookingTimeTitle
        })
    }

    func sortedTimeHigh(items: [Recipe]) -> [Recipe] {
        items.sorted(by: { lhs, rhs in
            if lhs.cookingTimeTitle == rhs.cookingTimeTitle {
                return lhs.caloriesTitle < rhs.caloriesTitle
            }
            return lhs.cookingTimeTitle > rhs.cookingTimeTitle
        })
    }

    func sortedRecipe(category: [Recipe]) {
        let defaultRecipes = self.category.recepies
        var sorted = category
        switch (sortedCalories, sortedTime) {
        case (.non, .non):
            sorted = defaultRecipes
            view?.sortedRecip(recipe: sorted)
        case (.caloriesLow, _):
            sorted = sortedCaloriesLow(items: category)
            view?.sortedRecip(recipe: sorted)
        case (.caloriesHigh, _):
            sorted = sortedCaloriesHigh(items: sorted)
            view?.sortedRecip(recipe: sorted)
        case (_, .timeLow):
            sorted = sortedTimeLow(items: sorted)
            view?.sortedRecip(recipe: sorted)
        case (_, .timeHigh):
            sorted = sortedTimeHigh(items: sorted)
            view?.sortedRecip(recipe: sorted)
        }
    }

    func tappedOnCell(recipe: Recipe) {
        detailsRecipeCoordinator?.pushRecipeDetailsViewController(recipe: recipe)
    }

    func getRecipe() {
        view?.getRecipes(recipes: recipeCommonInfo ?? [])
    }
}
