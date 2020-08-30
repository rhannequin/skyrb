# frozen_string_literal: true

require "csv"

class Sky::Ngc::ProcessData
  SOURCE_FILE_PATH = Rails.root.join("vendor/ngc.csv")
  TARGET_FILE_PATH = Rails.root.join("vendor/ngc_processed.csv")

  SEPARATOR = ";"
  ACCEPTED_COLUMNS_COUNT = 23

  def self.process!
    File.open(TARGET_FILE_PATH, "w") do |file|
      File.read(SOURCE_FILE_PATH).each_line do |line|
        file.puts(
          line
            .split(SEPARATOR)[0..ACCEPTED_COLUMNS_COUNT]
            .join(SEPARATOR)
        )
      end
    end

    !File.zero?(TARGET_FILE_PATH)
  end
end
