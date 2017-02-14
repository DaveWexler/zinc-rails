class CharactersController < ApplicationController

def create
  Character.destroy_all
  xml = Nokogiri::XML(open(params["file"]))
  lines_count = count_lines(xml)
  lines_count.each do |character, linecount|
    Character.create(name: character, lines: linecount)
  end
  redirect_to action: "index"
end

def index
  @characters = Character.all
end

private


def count_lines(xml_file)
  chars = xml_file.xpath("//SPEAKER")
  char_lines_count = Hash.new(0)
  chars.map do |char|
    unless char.text == "ALL"
      char_lines_count[char.text] += char.xpath("../LINE").length
    end
  end
  char_lines_count
end

end
