require 'search_object/plugin/graphql'

class Resolvers::MovieSearch
  # include SearchObject for GraphQL
  include SearchObject.module(:graphql)

  # scope is starting point for search
  scope { Movie.all }

  # return type
  type !types[Types::MovieType]

  # inline input type definition for the advance filter
  MovieFilter = GraphQL::InputObjectType.define do
    name 'MovieFilter'
    argument :OR, -> { types[MovieFilter] }
    argument :name, types.String
    argument :summary, types.String
  end

  # when "filter" is passed "apply_filter" would be called to narrow the scope
  option :filter, type: MovieFilter, with: :apply_filter

  # apply_filter recursively loops through "OR" branches
  def apply_filter(scope, value)
    # normalize filters from nested OR structure, to flat scope list
    branches = normalize_filters(value).reduce { |a, b| a.or(b) }
    scope.merge branches
  end

  def normalize_filters(value, branches = [])
    # add like SQL conditions
    scope = Link.all
    scope = scope.where('description LIKE ?', "%#{value['description_contains']}%") if value['description_contains']
    scope = scope.where('url LIKE ?', "%#{value['url_contains']}%") if value['url_contains']

    branches << scope

    # continue to normalize down
    value['OR'].reduce(branches) { |s, v| normalize_filters(v, s) } if value['OR'].present?

    branches
  end
end
