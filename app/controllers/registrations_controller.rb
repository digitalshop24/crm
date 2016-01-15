class RegistrationsController < Devise::RegistrationsController
  before_action :set_specialities, only: [:new, :edit]
end
