class Admin::ArticlesController < Admin::BaseController
    
	  def index
      @articles = Article.includes(:category).order("weight desc")
	  end

    def search
      @id = params[:id]
      @articles = @id.present? ? Category.find(params[:id]).articles.order("category_id asc") : Article.all
      render :action => :index
    end

	  def new
      @article = Article.new(video_name: RandomCode.generate_order_uuid)
	  end


	  def edit
      @article = Article.find params[:id]
    end

	  def create
      @article = Article.new(params_articles)
      @article.save
      redirect_to admin_articles_path
    end

    def update
      article = Article.find params[:id]
      article.update(params_articles)
      redirect_to admin_articles_path
    end

	  def destroy
	    article = Article.find(params[:id])
	    article.destroy
	    redirect_to :back
	  end
 
    private 

	  def params_articles
      params.require(:article).permit!
    end
end
