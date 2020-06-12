class Admin::CategoriesController < Admin::BaseController


	def index
	    @categories = Category.all.order("weight asc")
	end

	def show 
	end

	def new
		@category = Category.new
		respond_to do |format|
			format.js
		end
	end

	def create
		@category = Category.new(params_category)
		@category.save
		redirect_to admin_categories_path
	end


	def edit
		@category = Category.find(params[:id])
	end

	def update
		@category = Category.find(params[:id])
		@category.update(params_category)
		redirect_to :back
	end

	def destroy
		category = Category.find(params[:id])
		category.destroy
		redirect_to :back
	end

	def update_status
		category = Category.find(params[:id])
		status = category.status == "on" ? 'off' : 'on'
		category.update(:status=>status)
		if category.status == 'on'
		  render :json=> {'message': '上架'}
		else
		  render :json=> {'message': '下架'}
		end
	end

	private
	def params_category
		params.require(:category).permit!
	end


end