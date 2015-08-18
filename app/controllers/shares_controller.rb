class SharesController < ApplicationController
  layout 'account'
  
  before_filter :load_sharable, :except => [:by_user, :with_user, :accept, :reject]
  skip_before_filter :authenticate_user!, :only => [:accept, :reject]
  
  # GET /shares
  # GET /shares.json
  def index
    @shares = @sharable.shares

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @shares }
      format.js
    end
  end
  
  # GET /users/{user_id}/shares
  # GET /users/{user_id}/shares.json
  def with_user
    user = User.find(params[:user_id])
    @shared_with_user = Share.where(:shared_with_email => user.email)
    @shared_by_user = Share.where(:shared_by_id => user)
    
    respond_to do |format|
      format.html # index.html.erb
      format.js
    end
  end

  # GET /shares/1
  # GET /shares/1.json
  def show
    @share = Share.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @share }
    end
  end

  # GET /shares/new
  # GET /shares/new.json
  def new
    @share = @sharable.shares.new(shared_by_id: current_user.id, status: 'pending', role_name: 'reader')
    
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @share }
      format.js
    end
  end
  
  # GET /shares/1/edit
  def edit
    @share = Share.find(params[:id])
    
    respond_to do |format|
      format.html
      format.js
    end
  end

  # POST /shares
  # POST /shares.json
  def create
    @share = @sharable.shares.new(params[:share])
    respond_to do |format|
      if @share.save
        format.html { redirect_to @share, notice: 'Share was successfully created.' }
        format.json { render json: @share, status: :created, location: @share }
        format.js
      else
        format.html { render action: "new" }
        format.json { render json: @share.errors, status: :unprocessable_entity }
        format.js
      end
    end
  end

  # PUT /shares/1
  # PUT /shares/1.json
  def update
    @share = Share.find(params[:id])
    
    raise CanCan::AccessDenied if @share.user_id != current_user.id

    respond_to do |format|
      if @share.update_attributes(params[:share])
        format.html { redirect_to @share, notice: 'Share was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @share.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /shares/1
  # DELETE /shares/1.json
  def destroy
    @share = Share.find(params[:id])
    
    raise CanCan::AccessDenied if @share.shared_by_id != current_user.id
    
    @share.stop
    @deleteId = @share.id
    @share.destroy

    respond_to do |format|
      format.html { redirect_to shares_url }
      format.json { head :no_content }
      format.js
    end
  end
  
  def accept
    @share = Share.find(params[:id])
    if @share.status == 'pending'
      @share.accept
      if @share.shared_with_id
        @share.save
        authenticate_user!
        redirect_to @share.get_sharable
      else
        redirect_to signup_from_share_path
        #redirect_to new_user_registration_path
      end
    else
      authenticate_user!
      redirect_to @share.get_sharable
    end
  end
  
  def reject    
    @share = Share.find(params[:id])
    @share.stop
    @share.destroy
    
    respond_to do |format|
      format.html { redirect_to root_url }
      format.js
    end
    
  end
  
private
 
  def load_sharable
    resource, id = request.path.split('/')[1, 2]
    @sharable = resource.singularize.classify.constantize.find(id)
  end

  def find_sharable
    params.each do |name, value|
      if name =~ /(.+)_id$/
        return $1.classify.constantize.find(value)
      end
    end
    nil
  end
end
