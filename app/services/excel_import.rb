require 'roo'

class ExcelImport
  def initialize(file)
    @spreadsheets = Roo::Spreadsheet.open(file)
    @spread = @spreadsheets.sheet(1)
    @keys = @spreadsheets.sheet(2)
  end

  def key_import

  end

  def data_import

  end
end