// RecipePresenter.swift
// Copyright © RoadMap. All rights reserved.

/// Протокол получения категории
protocol RecipesViewProtocol: AnyObject {
    /// Получение категории
    func getRecipes(recipes: Category)
    /// Сортировка Рецептов
    func sortedRecip(recipe: [Recipe])
    /// Изменение соятояния кнопки сортировки время
    func buttonTimeState(color: String, image: String)
    /// Изменение соятояния кнопки сортировки каллорий
    func buttonCaloriesState(color: String, image: String)
    /// Меняем состояние шимера
    func changeShimerState()
}

/// Протокол рецептов
protocol RecipeProtocol: AnyObject {
    /// Получить рецепты
    func getRecipe()
    /// Метод для тапа по ячейке
    func tappedOnCell(recipe: Recipe)
    /// Сортировка рецептов
    func sortedRecipe(category: [Recipe])
    /// Меняем состояние шимеров
    func changeShimer()
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
    private var sortedCalories = SortedCalories.non
    private var sortedTime = SortedTime.non

    // MARK: - Initializers

    init(view: RecipesViewProtocol, category: Category, detailsRecipeCoordinator: RecipesCoordinator) {
        self.view = view
        self.category = category
        self.detailsRecipeCoordinator = detailsRecipeCoordinator
    }

    // MARK: - Private Methods

    /// Метод меняющий состояниие кнопки калориев
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
    func changeShimer() {
        view?.changeShimerState()
    }

    func sortedRecipe(category: [Recipe]) {
        let defaultRecipes = self.category.recepies
        var sorted = category
        switch (sortedCalories, sortedTime) {
        case (.non, .non):
            sorted = defaultRecipes
            view?.sortedRecip(recipe: sorted)
        case (.caloriesLow, _):
            if sortedTime == .timeLow {
                sorted = category.sorted(by: { lhs, rhs in
                    if lhs.caloriesTitle == rhs.caloriesTitle {
                        return lhs.cookingTimeTitle < rhs.cookingTimeTitle
                    }
                    return lhs.caloriesTitle < rhs.caloriesTitle
                })
            } else if sortedTime == .timeHigh {
                sorted = category.sorted(by: { lhs, rhs in
                    if lhs.caloriesTitle == rhs.caloriesTitle {
                        return lhs.cookingTimeTitle > rhs.cookingTimeTitle
                    }
                    return lhs.caloriesTitle < rhs.caloriesTitle
                })
            } else {
                sorted = category.sorted(by: { $0.caloriesTitle < $1.caloriesTitle })
            }
            view?.sortedRecip(recipe: sorted)
        case (.caloriesHigh, _):
            if sortedTime == .timeLow {
                sorted = category.sorted(by: { lhs, rhs in
                    if lhs.caloriesTitle == rhs.caloriesTitle {
                        return lhs.cookingTimeTitle > rhs.cookingTimeTitle
                    }
                    return lhs.caloriesTitle > rhs.caloriesTitle
                })
            } else if sortedTime == .timeHigh {
                sorted = category.sorted(by: { lhs, rhs in
                    if lhs.caloriesTitle == rhs.caloriesTitle {
                        return lhs.cookingTimeTitle < rhs.cookingTimeTitle
                    }
                    return lhs.caloriesTitle > rhs.caloriesTitle
                })
            } else {
                sorted = category.sorted(by: { $0.caloriesTitle > $1.caloriesTitle })
            }
            view?.sortedRecip(recipe: sorted)
        case (_, .timeLow):
            sorted = category.sorted(by: { lhs, rhs in
                if lhs.cookingTimeTitle == rhs.cookingTimeTitle {
                    return lhs.caloriesTitle < rhs.caloriesTitle
                }
                return lhs.cookingTimeTitle < rhs.cookingTimeTitle
            })
            view?.sortedRecip(recipe: sorted)
        case (_, .timeHigh):
            sorted = category.sorted(by: { lhs, rhs in
                if lhs.cookingTimeTitle == rhs.cookingTimeTitle {
                    return lhs.caloriesTitle < rhs.caloriesTitle
                }
                return lhs.cookingTimeTitle > rhs.cookingTimeTitle
            })
            sorted = category.sorted(by: { $0.cookingTimeTitle > $1.cookingTimeTitle })
            view?.sortedRecip(recipe: sorted)
        }
    }

    func tappedOnCell(recipe: Recipe) {
        detailsRecipeCoordinator?.pushRecipeDetailsViewController(recipe: recipe)
    }

    func getRecipe() {
        view?.getRecipes(recipes: category)
    }
}
