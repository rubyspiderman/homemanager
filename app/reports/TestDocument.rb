class TestDocument < Prawn::Document
  def to_pdf
    text "not poop"
    
    fill_color "00ff00"
    
    start_new_page
    
    text "poop"
    
    repeat(:all, :dynamic => true) do
      draw_text "Page #{page_number} of #{page_count}", :at => [bounds.right-50, 0]
    end        
    
    render
  end
end