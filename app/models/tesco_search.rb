require "nokogiri"
require "rest-client"

class TescoSearch
  
  @@BASE_URL = "https://ezakupy.tesco.pl/groceries/"
  def initialize(options)
    result_processor = options[:result_processor]
    raise ArgumentError('No result_processor is passed') if result_processor.nil?
    raise ArgumentError('No :launch method in result_processor') unless result_processor.respond_to?(:launch)
     
    @LANGUAGE = options[:lang] || "pl-PL"
    @result_processor = result_processor
  end

  def do(query)
  	begin
	  page = Nokogiri::HTML(RestClient.get(url(query)))
	  parser = IngredientsParser.new
	  data = parser.parse_ingredients_from(page)

	  process_results(data)
	rescue RestClient::InternalServerError
	  []
	end
  end

  def process_results(data)
  	@result_processor.launch(data)	
  end

  def lang=(lang)
  	@LANGUAGE = lang
  end

  private
  def url(query)
  	@@BASE_URL + @LANGUAGE + "/search?query=" + query
  end

end