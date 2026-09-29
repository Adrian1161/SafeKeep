# frozen_string_literal: true

require 'rspec'

RSpec.describe ApplicationController, type: :controller do
  controller do
    def index
      head :ok
    end
  end
end
