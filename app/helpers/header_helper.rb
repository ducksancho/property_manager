module HeaderHelper
  def title(page_title)
    content_for :page_title, " | #{t("page_title.#{page_title}")}"
  end
end