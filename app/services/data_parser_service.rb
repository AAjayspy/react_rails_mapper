require 'csv'

class DataParserService
  include SolidUseCase
  @@colours = ["Pri", "Question", "Teaming Stages", "Appears (Day)", "Frequency", "Type", "Role", "Required?", "Conditions", "Mapping"].freeze

  steps :validate_data, :save_data
  # steps :validate_data

  def validate_data(params)
    data = CSV.open(params[:file].path, :headers => true).read
    if !data.headers == @@colours
      fail :invalid_data
    else
      continue(params)
    end
  end

  def save_data(params)
    begin
      questions_dataset = []
      dataset = CSV.open(params[:file].path, :headers => true)
      dataset.each do | data|
        mapping = Mapping.find_or_create_by(name: data['Mapping'])
        role = Role.find_or_create_by(name: data['Role'])
        questions_dataset << {
          title: data['Question'],
          teaming_stage: data['Teaming Stages'],
          appears_day: data['Appears (Day)'].to_i,
          frequency: data['Frequency'].to_i,
          type: data['Type'],
          role_id: role.id,
          is_required: data['Required?'].eql?('Yes') ? true : false,
          conditions: data['Conditions'],
          mapping_id: mapping.id
        }
      end
      Question.insert_all!(questions_dataset)
      continue(params)
    rescue
      fail :dataset_save_failed
    end
  end

end
