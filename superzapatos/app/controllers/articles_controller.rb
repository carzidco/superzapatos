class ArticlesController < ApplicationController
  # GET /articles
  # GET /articles.json

  # Method to evaluate whether or not object is number
  def is_numeric?(obj) 
     obj.to_s.match(/\A[+-]?\d+?(\.\d+)?\Z/) == nil ? false : true
  end

  def index

    # Articles from an specific store
    if params[:store_id]
      @articles = Article.where(:store_id => params[:store_id])
      @articlesJson = Store.joins(:articles).where(:id => params[:store_id]).select('articles.id as "id", articles.description, articles.name, articles.price, articles.total_in_shelf, articles.total_in_vault, stores.name as "store_name"')
    
    #All articles
    else  
      @articles = Article.all
      @articlesJson = Store.joins(:articles).select('articles.id as "id", articles.description, articles.name, articles.price, articles.total_in_shelf, articles.total_in_vault, stores.name as "store_name"')
    end

    respond_to do |format|
      format.html # index.html.erb

      #Exceptions
      if @articlesJson.blank?
        if is_numeric?(params[:store_id])
          format.json { render :json => {:error_msg => "Record not Found", :success => false } }
        else
          format.json { render :json => {:error_msg => "Bad Request", :success => false } }
        end

      #Sent Data
      else
        format.json { render :json => { :articles => @articlesJson, :success => true, :total_elements => @articlesJson.count } }
      end
    end
  end

  # GET /articles/1
  # GET /articles/1.json
  def show
    @article = Article.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @article }
    end
  end

  # GET /articles/new
  # GET /articles/new.json
  def new
    @article = Article.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @article }
    end
  end

  # GET /articles/1/edit
  def edit
    @article = Article.find(params[:id])
  end

  # POST /articles
  # POST /articles.json
  def create
    @article = Article.new(params[:article])

    respond_to do |format|
      if @article.save
        format.html { redirect_to @article, notice: 'Article was successfully created.' }
        format.json { render json: @article, status: :created, location: @article }
      else
        format.html { render action: "new" }
        format.json { render json: @article.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /articles/1
  # PUT /articles/1.json
  def update
    @article = Article.find(params[:id])

    respond_to do |format|
      if @article.update_attributes(params[:article])
        format.html { redirect_to @article, notice: 'Article was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @article.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /articles/1
  # DELETE /articles/1.json
  def destroy
    @article = Article.find(params[:id])
    @article.destroy

    respond_to do |format|
      format.html { redirect_to articles_url }
      format.json { head :no_content }
    end
  end
end
