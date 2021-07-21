class Api::V1::HomeController < ApplicationController

  def create
    DatabaseCleaner.strategy = :truncation
    DatabaseCleaner.clean
    DataParserService.run(params).match do
      success do |user|
        render success: { success: "Data from CSV loaded successfully!"}, status: 201
      end

      failure(:invalid_data) do |error_data|
        render error: { error: "Data from CSV loaded successfully!"}, status: 400
      end

      failure(:dataset_save_failed) do |error_data|
        render error: { error: "Data from CSV loaded successfully!"}, status: 400
      end

      failure do |exception|
        render error: { error: "Data from CSV loaded successfully!"}, status: 400
      end
    end
  end
end
