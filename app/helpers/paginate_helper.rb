module PaginateHelper  
  def paginate_records(records, page_per_default = 20)
    @paginate = {
      :total_count => records.length,
      :page_per_default => page_per_default,
      :page_per => (params[:per] || page_per_default).to_i,
      :page => (params[:page] || 1).to_i,
      :order => params[:order],
      :desc => (params[:order] && params[:desc])
    }
    @paginate[:max_page] = (@paginate[:total_count].to_f / @paginate[:page_per]).ceil
    @paginate[:page] = @paginate[:max_page] if @paginate[:page] > @paginate[:max_page]
    records = records.limit(@paginate[:page_per])
    records = records.offset(@paginate[:page_per] * (@paginate[:page]-1)) if @paginate[:page] > 1
    records = records.order(@paginate[:order]) if @paginate[:order]
    records = records.reverse_order if @paginate[:desc]
    records
  end

  def paginate_list(path, n_of_link, id_array = nil, param_hash = {})
    list = ""
    @paginate[:max_page] ||= (@paginate[:total_count].to_f / @paginate[:page_per]).ceil
    @paginate[:page] = @paginate[:max_page] if @paginate[:page] > @paginate[:max_page] # handle page number too big
    return "" if @paginate[:max_page] <= 1
    # page link
    center = (n_of_link.to_f / 2).ceil
    start = case
            when @paginate[:page] <= center || @paginate[:max_page] <= n_of_link then 1
            when @paginate[:page] >= @paginate[:max_page] - n_of_link + center then @paginate[:max_page] - n_of_link + 1
            else @paginate[:page] - center + 1
            end
    finish = [start+n_of_link-1, @paginate[:max_page]].min
    if start != 1
      hash = param_hash.merge(:page => nil, :per => (@paginate[:page_per] == @paginate[:page_per_default] ? nil : @paginate[:page_per]))
      list += link_to(1, try(path, id_array, hash).to_s)
      list += "<div class='dots'>...</div>"
    end
    (start..finish).each do |p|
      if p == @paginate[:page]
        list += "<div class='current'>#{p.to_s}</div>"
      else
        hash = param_hash.merge(:page => (p > 1 ? p : nil), :per => (@paginate[:page_per] == @paginate[:page_per_default] ? nil : @paginate[:page_per]))
        list += link_to(p, try(path, id_array, hash).to_s)
      end
    end
    if finish != @paginate[:max_page]
      hash = param_hash.merge(:page => @paginate[:max_page], :per => (@paginate[:page_per] == @paginate[:page_per_default] ? nil : @paginate[:page_per]))
      list += "<div class='dots'>...</div>"
      list += link_to(@paginate[:max_page], try(path, id_array, hash).to_s)
    end

    # previous link
    if @paginate[:page] == 1
      previous_link = "<div class='previous'></div>"
    else
      hash = param_hash.merge(:page => (@paginate[:page]-1 > 1 ? @paginate[:page]-1 : nil), :per => (@paginate[:page_per] == @default_page_per ? nil : @paginate[:page_per]))
      previous_link = link_to("", try(path, id_array, hash).to_s, :class => "previous")
    end
    # next link
    if @paginate[:page] == @paginate[:max_page]
      next_link = "<div class='next'></div>"
    else
      hash = param_hash.merge(:page => (@paginate[:page]+1 > 1 ? @paginate[:page]+1 : nil), :per => (@paginate[:page_per] == @default_page_per ? nil : @paginate[:page_per]))
      next_link = link_to("", try(path, id_array, hash).to_s, :class => "next")
    end    
    div_class = "paginateList"
    raw "<div class='#{div_class}'>#{previous_link}#{list}#{next_link}</div>"
  end
end