class PDFConverterCustomTitlePage < (Asciidoctor::Converter.for 'pdf')
  register_for 'pdf'
  
  def ink_title_page doc
    table_data = [
      ['承認', '調査', '担当'],
      [doc.attributes['approver'], doc.attributes['reviewer'], doc.attributes['author']]
    ]
    table(table_data, header: true, :position => :right, :width => 150) do
      columns(0..-1).align = :center
      rows(1).height = 50
      rows(1).style :valign => :center
    end

    move_cursor_to page_height * 0.6
    theme_font :title_page do
      doctitle = doc.doctitle partition: true
      theme_font :title_page_title do
        ink_prose doctitle.main, align: :center, margin: 0
      end
      if doctitle.subtitle?
        theme_font :title_page_subtitle do
          ink_prose doctitle.subtitle, align: :center, margin: 0
        end
      end
      if !doc.attributes['revision'].nil?
        theme_font :title_page_revision do
          ink_prose "Revision : #{doc.attributes['revision']}", align: :center
        end
      end
    end

    move_down 50
    table_data = [
      ['Software Component', ':', doc.attributes['software-component']],
      ['Software Component Group', ':', doc.attributes['software-component-group']],
      ['Development team', ':', doc.attributes['development-team']],
      ['Project', ':', doc.attributes['project']]
    ]
    table(table_data, :position => :center) do
      columns(0..-1).align = :left
      columns(0..-1).borders = []
    end
  end

  def ink_running_content periphery, doc, skip = [1, 1], body_start_page_number = 1
    case periphery
    when :header
#      skip_pages, skip_pagenums = skip
      # NOTE: find and advance to first non-imported content page to use as model page
#      return unless (content_start_page_number = state.pages[skip_pages..-1].index {|it| !it.imported_page? })


#     skip = opts[:skip] || 0
#     start = skip + 0

      start = 1
      top_margin, bottom_margin, left_margin, right_margin = @theme.page_margin
      p top_margin

      top_bounds = page_height - (page.margins[:top] / 2.0 + @theme.vertical_rhythm / 2.0)
      move_cursor_to top_bounds
#if false
      repeat (start..page_count), dynamic: true do
        # don't stamp pages which are imported / inserts
        next if page.imported_page?
        theme_font :header do
          canvas do
            move_down top_margin



            # if @theme.header_border_color && @theme.header_border_color != 'transparent'
            #   save_graphics_state do
            #     line_width @theme.base_border_width
            #     stroke_color @theme.header_border_color
            #     stroke_horizontal_line left_margin, bounds.width - right_margin, at: top_bounds
            #   end
            # end
            #indent left_margin + 20, right_margin + 20 do
              table_data = [
                ['PIYO', '[Software Hogehoge Document]', 'Status', 'DRAFT'],
              ]
              table(table_data, :position => left_margin, :width => 594.35 - left_margin - right_margin) do
                columns(0..-1).align = :center
                #columns(0..-1).borders = []
              end
              # if doc.attr? 'header'
              #   formatted_text_box [text: "aaa", color: @theme.footer_font_color], at: [0, top_bounds + (page.margins[:top] / 2.0)], align: :center
              # end
              # if doc.attr? 'header-right'
              #   formatted_text_box [text: "bbb", color: @theme.footer_font_color], at: [0, top_bounds + (page.margins[:top] / 2.0)], align: :right
              # end
              # if doc.attr? 'header-left'
              #   formatted_text_box [text: "ccc", color: @theme.footer_font_color], at: [0, top_bounds + (page.margins[:top] / 2.0)], align: :left
              # end
            #end
          end
        end
      end
#end
      # table_data = [
      #   ['a', 'b', 'c', 'd'],
      #   ['a', 'b', 'c', 'd'],
      # ]
      # table(table_data, :position => :center) do
      #   columns(0..-1).align = :left
      #   columns(0..-1).borders = []
      # end
    when :footer
      puts "FOOT"
      super      
    else
      raise "UNREACHABLE HERE!"
    end
  end
end
