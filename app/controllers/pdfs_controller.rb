class PdfsController < ApplicationController
  layout 'no_binder'
  
  require 'date'
  require 'time'
  
  before_filter :check_subscription_level
  before_filter :load_pdfable
    
  # GET /pdfs
  # GET /pdfs.json  
  def index    
    # this should be @pdfable.pdfs, but whenever I do that
    # there is a postgres error, so some config is wrong 
    @pdfs = @pdfable.pdfs
      
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @pdfs }
      format.js
    end     
  end
  
  # GET /pdfs/new
  # GET /pdfs/new.json
  def new
    @pdf = @pdfable.pdfs.new(created_by: working_user.id)

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @pdf }
      format.js
    end
  end
  
  # POST /pdfs
  # POST /pdfs.json  
  def create
    @content  = generate_html
 
    date      = Date.today
    time      = Time.now
    pdfname   = "HomeBinder_Report_#{working_binder.name}_#{date}_#{time}"
    
    # options won't be user configurable for now
    options   = {
      copies: 1, 
      page_size: "Letter", 
      margin_bottom: 0, 
      margin_left: 0, 
      margin_right: 0, 
      margin_top: 0,
      #footer_html: "http://s3.amazonaws.com/homebinderstatic/pdf/footer.htm",
      minimum_font_size: 11,
      footer_line: true,
      callback: savepdf_binder_pdfs_url(@pdfable, only_path: false),
      #callback: "http://{domain}/{pdfable_type_controller}/#{params[:binder_id]}/pdfs/savepdf",
      test: true 
    }
    
    @callback_url = savepdf_binder_pdfs_url(@pdfable, only_path: false)
    
    hypdf     = HyPDF.new(@content, options)
    
    # download
    #send_data(hypdf.get, filename: pdfname, type: 'application/pdf')
    
    # send to s3
    hypdf.upload_to_s3('homebinderpdf', pdfname, true)
  end
  
  
  def savepdf
    if params[:error]
      puts params[:message]
    else
      #@pdfable        = load_pdfable
      @pdf            = @pdfable.pdfs.new(params[:pdf])
      @pdf.created_by = current_user.id
      
      respond_to do |format|
        if @pdf.save
          # make the current user the owner
          #working_user.add_role :owner, @pdf
          
          @pdf = @pdfable.images
          format.html { redirect_to @pdf, notice: 'PDF was successfully created.' }
          format.json { render json: @pdf, status: :created, location: @pdf }
          format.js
        else
          format.html { render action: "new" }
          format.json { render json: @pdf.errors, status: :unprocessable_entity }
          format.js
        end
      end

    end
  end
  
  
  private
 
  def load_pdfable
    resource, id = request.path.split('/')[1, 2]
    @pdfable = resource.singularize.classify.constantize.find(id)
  end

  def find_pdfable
    params.each do |name, value|
      if name =~ /(.+)_id$/
        return $1.classify.constantize.find(value)
      end
    end
    nil
  end 
  
  def check_subscription_level
    if working_binder.subscription.plan_id == 'free'
      render 'public/401.html', status: :unauthorized
      return false
    end
  end

  
  # base html, which pulls in other pages
  def generate_html 
    @property_page  = generate_property_html
    @structure_page = generate_structure_html
    @maint_page     = generate_maintenance_html
    @project_page   = generate_project_html
    @appliance_page = generate_appliance_html
    @paint_page     = generate_paint_html
    @contactor_page = generate_contractor_html
    @plan_page      = generate_plan_html
    
    @html_start = %Q{
      <html>
        <head>
          <title>HomeBinder.com Report</title>
          <link href="http://s3.amazonaws.com/homebinderstatic/stylesheets/bootstrap.min.css" media="all" rel="stylesheet" type="text/css" />
          <link href="http://fonts.googleapis.com/css?family=Open+Sans" media="all" rel="stylesheet" type="text/css" /> 
          <style>
            body { font-family: 'Open Sans', sans-serif; font-size: 11px; }
            th { background-color: #000; color: #FFF; font-size: 11px; }
            td { font-size: 11px; }
            #report-title { position:absolute; left:140px; top:705px; z-index:10; }
            #report-title h1 { font-size:20px; line-height:18px; padding:0; }
            #report-title h2 { font-size:26px; color:#fc6500; line-height: 2px; padding:0; }
            #report-title h3 { font-size:18px; line-height:16px; padding:0; }
            #toc-block { position:absolute; left:150px; top: 1400px; }
            #toc-block h1 { font-size:30px; color:#fff; line-height:30px; }
            #toc-block h1 span { color: #fc6500; }
            .padme { padding: 50px; }
          </style>
        </head>
        <body>
    }
    
    @title = %Q{
      <img src="http://s3.amazonaws.com/homebinderstatic/pdf/images/title-page.png"/>
      <div id="report-title">
        <h1>HomeBinder Report for</h1>
        <h2>Jon Durante</h2>
        <h3>#{working_binder.property.address1}</h3>
        <h3>#{working_binder.property.city}, <#{working_binder.property.state} #{working_binder.property.zip}</h3>
      </div>
      <p style="page-break-after:always;"></p>
    }
    
    @toc = %Q{
      <img src="http://s3.amazonaws.com/homebinderstatic/pdf/images/toc-page.png"/>
      <div id="toc-block">
        <h1><span>3</span> Property</h1>
        <h1><span>X</span> Structures</h1>
        <h1><span>X</span> Maintenance</h1>
        <h1><span>X</span> Projects</h1>
        <h1><span>X</span> Appliances</h1>
        <h1><span>X</span> Paint</h1>
        <h1><span>X</span> Contractors</h1>
        <h1><span>X</span> Plan</h1>
      </div>
      <p style="page-break-after:always;"></p>       
    }
    
    @html_end = %Q{
        </body>
      </html>
    }
    
    # combine all the html!
    @result = @html_start + 
              @title + 
              @toc + 
              @property_page + 
              @structure_page + 
              @maint_page +
              @project_page + 
              @appliance_page +
              @paint_page + 
              @contactor_page +
              @plan_page +
              @html_end  
  end
  
  
  # html for the property page
  def generate_property_html
    @pr = %Q{
      <img src="http://s3.amazonaws.com/homebinderstatic/pdf/images/property-header.png"/>
      
      <div class="padme">
        <table class="table">
          <tr>
            <th>Name</th>
            <th>Address</th>
            <th>Acreage</th>
            <th>APN Number</th>
          </tr>
          <tr><td style="height:25px;">&nbsp;</td></tr>
          <tr>
            <td>#{working_binder.name}</td>
            <td>
              #{working_binder.property.address1}<br/>
              #{working_binder.property.city}, #{working_binder.property.state} #{working_binder.property.zip}
            </td>
            <td>#{working_binder.property.acres}</td>
            <td>#{working_binder.property.apn}</td>
          </tr>
        </table>
      </div>
      
      <div class="text-center padme">
        <img src="http://maps.googleapis.com/maps/api/staticmap?center=#{working_binder.property.address1} #{working_binder.property.city}, #{working_binder.property.state}&zoom=15&size=900x300&key=AIzaSyBkAHC5xhv7J2CSDJWOgAEAbhEaATTsb1Y&sensor=false&markers=color:red|*|#{working_binder.property.address1} #{working_binder.property.city}, #{working_binder.property.state}" />
      </div>
      
      <p style="page-break-after:always;"></p>
    }
  end
  
  
  # html for the structures page
  def generate_structure_html
    @structures = working_binder.structures
    
    @s = %Q{
      <img src="https://s3.amazonaws.com/homebinderstatic/pdf/images/structure-header.png"/>
      
      <div class="padme">
        <table class="table">
          <tr>
            <th>Year Built</th>
            <th>Construction</th>
            <th>Bedrooms</th>
            <th>Bathrooms</th>
            <th>Heating</th>
            <th>Central Air</th>            
          </tr> 
          <tr><td style="height:25px;">&nbsp;</td></tr>
    }
    
    @structures.each do |structure|
      @s += %Q{
          <tr>
            <td>#{structure.year_built}</td>
            <td>#{structure.construction_style}</td>
            <td>#{structure.beds}</td>
            <td>#{structure.baths}</td>
            <td>#{structure.heat_type}</td>
            <td>#{structure.heat_source}</td>
          </tr>
      }
    end
    
    @s += %Q{
        </table>
      </div>
      <p style="page-break-after:always;"></p>
    }
  end
  

  # html for the maintenance page
  def generate_maintenance_html
    @maint_items = working_binder.maintenance_items.sort_by {|i| i.next_event.do_date}
    
    @m = %Q{
      <img src="https://s3.amazonaws.com/homebinderstatic/pdf/images/maintenance-header.png"/>
      
      <div class="padme">
        <table class="table">
          <tr>
            <th>Project Name</th>
            <th>Date</th>         
          </tr> 
          <tr><td style="height:25px;">&nbsp;</td></tr>
    }
    
    @maint_items.each do |item|
      @m += %Q{
          <tr>
            <td>#{item.name}</td>
            <td>#{item.next_event.do_date}</td>
          </tr>
      }
    end
    
    @m += %Q{
        </table>
      </div>
      <p style="page-break-after:always;"></p>
    }
  end

  
  # html for the projects page
  def generate_project_html
    @projects = working_binder.projects
    
    @p = %Q{
      <img src="https://s3.amazonaws.com/homebinderstatic/pdf/images/projects-header.png"/>
      
      <div class="padme">
        <table class="table">
          <tr>
            <th>Name</th>
            <th>Completion Date</th>
            <th>Status</th>
          </tr>
          <tr><td style="height:25px;">&nbsp;</td></tr>
    }
    
    @projects.each do |project|
      @p += %Q{
          <tr>
            <td>#{project.name}</td>
            <td>#{project.end_date.strftime("%m/%d/%Y") unless project.end_date.nil?}</td>
            <td>#{project.get_status.titleize unless project.get_status.nil?}</td>
          </tr>
      }
    end
    
    @p += %Q{
        </table>
      </div>
      <p style="page-break-after:always;"></p>  
    }    
  end
  
  
  # html for the appliances page
  def generate_appliance_html
    @appliances = working_binder.appliances
    
    @a = %Q{
      <img src="https://s3.amazonaws.com/homebinderstatic/pdf/images/appliances-header.png"/>
      
      <div class="padme">
        <table class="table">
          <tr>
            <th>Appliance</th>
            <th>Make</th>
            <th>Model</th>
            <th>Year</th>
            <th>Warranty</th>          
          </tr> 
          <tr><td style="height:25px;">&nbsp;</td></tr>
    }
    
    @appliances.each do |appliance|
      @a += %Q{
          <tr>
            <td>#{appliance.name}</td>
            <td>#{appliance.manufacturer}</td>
            <td>#{appliance.model}</td>
            <td>#{appliance.purchase.date.strftime("%m/%d/%Y") unless appliance.purchase.date.nil?}</td>
            <td>#{appliance.warranty}</td>
          </tr>
      }
    end
    
    @a += %Q{
        </table>
      </div>
      <p style="page-break-after:always;"></p>
    }
  end
  
  
  # html for the paint page
  def generate_paint_html
    @paints = working_binder.paints
    
    @pa = %Q{
      <img src="https://s3.amazonaws.com/homebinderstatic/pdf/images/paint-header.png"/>
      
      <div class="padme">
        <table class="table">
          <tr>
            <th>Room</th>
            <th>Color</th>
            <th>Brand</th>
            <th>Finish</th>          
          </tr> 
          <tr><td style="height:25px;">&nbsp;</td></tr>
    }
    
    @paints.each do |paint|
      room = ''
      paint.areas.each_with_index do |area, index|
        if index < paint.areas.length - 1
          room = area.name + ","
        else
          room = area.name
        end
      end
        
      @pa += %Q{
          <tr>
            <td>#{room}</td>
            <td>#{paint.name}</td>
            <td>#{paint.paint_manufacturer}</td>
            <td>#{paint.makeup}</td>
          </tr>
      }
    end
    
    @pa += %Q{
        </table>
      </div>
      <p style="page-break-after:always;"></p>
    }
  end


  # html for the contractor page
  def generate_contractor_html
    @contractors = @pdfable.contractors.order("name")
    
    @c = %Q{
      <img src="https://s3.amazonaws.com/homebinderstatic/pdf/images/contractor-header.png"/>
      
      <div class="padme">
        <table class="table">
          <tr>
            <th>Name</th>
            <th>Type</th>
            <th>Phone Number</th>
          </tr> 
          <tr><td style="height:25px;">&nbsp;</td></tr>
    }
    
    @contractors.each do |contractor|
      @c += %Q{
          <tr>
            <td>#{contractor.name.titleize unless contractor.name.nil?}</td>
            <td>#{contractor.contractor_type}</td>
            <td>#{contractor.phone.phony_formatted(:format => :national, :spaces => '-') unless contractor.phone.nil?}</td>
          </tr>
      }
    end
    
    @c += %Q{
        </table>
      </div>
      <p style="page-break-after:always;"></p>
    }
  end


  # html for the plan page
  def generate_plan_html
    @pl = %Q{
      <img src="https://s3.amazonaws.com/homebinderstatic/pdf/images/plan-header.png"/>
      
      <div class="padme">
        <table class="table">
          <tr>
            <th>Name</th>
            <th>Type</th>
            <th>Phone Number</th>
          </tr> 
          <tr><td style="height:25px;">&nbsp;</td></tr>
    }
    
    
    
    @pl += %Q{
        </table>
      </div>
      <p style="page-break-after:always;"></p>
    }
  end

end