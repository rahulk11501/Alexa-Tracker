class Ranking
  include Mongoid::Document

  field :website_name, type: String
  field :global_ranking, type: Integer
  field :india_ranking, type: Integer
  field :date, type: Date
end
