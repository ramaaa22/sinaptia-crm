class ClientsTag < ApplicationRecord
  belongs_to :client
  belongs_to :tag
end
