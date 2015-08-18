class HomeBinderReport < Prawn::Document
  def to_pdf
    pdf.fill_color "00ff00"
    
    pdf.start_new_page
    
    pdf.text "poop"
    
    pdf.repeat(:all, :dynamic => true) do
      pdf.draw_text "Page #{page_number} of #{page_count}", :at => [pdf.bounds.right-50, 0]
    end    
    
    pdf.render
  end
end