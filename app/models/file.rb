# create files for your ruby classes in this directory
require 'pry'

class Bakery

    attr_reader :name
    @@all = []

    def initialize(name)
        @name = name
        @desserts = []
        @@all << self
    end

    def self.all
        @@all
    end

    def average_calories
        sum = 0.0
        average = 0.0
        self.desserts.each do |dessert|
            sum += dessert.calories
        end
        average = sum / self.desserts.length
    end

    def shopping_list

    end

    def ingredients
        self.desserts.map do |dessert|
            dessert.ingredients
        end
    end
    
    def desserts
        Dessert.all.select do |dessert|
            dessert.bakery == self
        end
    end
end

class Dessert

    attr_reader :bakery, :calories, :name

    def initialize(bakery, name, calories)
        @bakery = bakery
        @name = name
        @calories = calories
    end

    def add_ingredient(ingredient)
        DessertIngredient.new(self, ingredient)
    end

    def self.all
        DessertIngredient.all.map do |dessert_ingredient|
            dessert_ingredient.dessert
        end
    end

    def ingredients
        Ingredient.all.select do |ingredient|
            ingredient.dessert == self
        end
    end

end

class Ingredient

    attr_reader :dessert

    def initialize(name)
        @name = name
    end

    def add_dessert(dessert)
        DessertIngredient.new(dessert, self)
    end

    def bakeries
        Bakery.all
    end

    def self.all
        DessertIngredient.all.map do |dessert_ingredient|
            dessert_ingredient.ingredient
        end
    end

    def self.find_all_by_name(ingredient_check)
        DessertIngredient.all.select do |relationship|
            relationship.ingredient.include?(ingredient_check)
        end
    end

end

class DessertIngredient

    attr_reader :dessert, :ingredient

    @@all = []

    def initialize(dessert, ingredient)
        @dessert = dessert
        @ingredient = ingredient
        @@all << self
    end

    def self.all
        @@all
    end

end

bakery1 = Bakery.new("new_bakery")
dessert1 = Dessert.new(bakery1, "cheesecake", 200)
dessert2 = Dessert.new(bakery1, "apple pie", 150)

binding.pry