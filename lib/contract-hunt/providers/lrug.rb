require 'ostruct'

class LRUG < Item
  def title
    @element.css('a:first').inner_text.split("\n").last
  end

  def url
    leaf = @element.css('a:first').attribute('href')
    "http://lists.lrug.org/pipermail/chat-lrug.org/#{Time.now.year}-#{Time.now.strftime('%B')}/#{leaf}"
  end
end

Search.london << OpenStruct.new(
  selector: 'li:contains("[LRUG] [JOBS]")',
  url: "http://lists.lrug.org/pipermail/chat-lrug.org/#{Time.now.year}-#{Time.now.strftime('%B')}/thread.html",
  item_class: LRUG
)
