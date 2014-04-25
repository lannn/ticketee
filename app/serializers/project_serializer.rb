class ProjectSerializer < ActiveModel::Serializer
  attributes :id, :name, :description

  has_many :tickets

  embed :ids
end
