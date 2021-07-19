class Api::V1::HomeController < ApplicationController
  def create
    DataParserService.run(params).match do
      success do |user|
        # flash[:success] = "Data from CSV loaded successfully!"
        # redirect_to root_path
        render success: { success: "Data from CSV loaded successfully!"}, status: 201
      end

      failure(:invalid_data) do |error_data|
        # render_form_errors("Oops, invalid csv. fix your mistakes and try again")
        render error: { error: "Data from CSV loaded successfully!"}, status: 400
      end

      failure(:dataset_save_failed) do |error_data|
        # render_form_errors("Sorry, something went wrong on our side.")
        render error: { error: "Data from CSV loaded successfully!"}, status: 400
      end

      failure do |exception|
        render error: { error: "Data from CSV loaded successfully!"}, status: 400
        # render_form_errors("something went terribly wrong")
      end
    end
  end
end
