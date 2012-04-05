class CommentsController < ApplicationController
	helper :all
	before_filter :require_login, :except => :index
	def index
		# HTTP param
		@user_id = params[:user_id]
		@use_case_id = params[:use_case_id]

		# data
		@use_case_favorite = Favorite.where("use_case_id = ?", @use_case_id).length
		@user_favorite = Favorite.where("user_id = ? AND use_case_id = ?", @user_id, @use_case_id).length
		
		@use_case_fun = Fun.where("use_case_id = ?", @use_case_id).length
		@user_fun = Fun.where("user_id = ? AND use_case_id = ?", @user_id, @use_case_id).length
		
		@use_case_metoo = Metoo.where("use_case_id = ?", @use_case_id).length
		@user_metoo = Metoo.where("user_id = ? AND use_case_id = ?", @user_id, @use_case_id).length
		
		# response
		@use_case_comment = Hash.new
		@use_case_comment[:favorite] = @use_case_favorite
		@use_case_comment[:fun] = @use_case_fun
		@use_case_comment[:metoo] = @use_case_metoo
		
		@user_comment = Hash.new
		@user_comment[:favorite] = @user_favorite
		@user_comment[:fun] = @user_fun
		@user_comment[:metoo] = @user_metoo
		
		@comment = Hash.new
		@comment[:use_case] = @use_case_comment
		@comment[:user] = @user_comment

		respond_to do |format|
			format.json { render json: @comment}
		end
	end

	def by_user

	end

	def by_use_case

	end

	def favorite_add
		@params[:favorite][:user_id] = current_user.id
		@params[:favorite][:use_case_id] = params[:use_case_id]

		Favorite.new(@params)
	end

	def favorite_delete
		@user_id = current_user.id
		@use_case_id = params[:use_case_id]

		@favorite = Favorite.where("user_id = ? AND use_case_id = ?", @user_id, @use_case_id)
		@favorite.delete
	end

	def fun_add

	end

	def fun_delete

	end

	def metoo_add

	end

	def metoo_delete

	end

	private

	def make_comments_object(favorites, funs, metoos)
		@comments = Hash.new
		@comments[:favorites] = favorites
		@comments[:favorites_count] = favorites.length
		@comments[:funs] = funs
		@comments[:funs_count] = funs.length
		@comments[:metoos] = metoos
		@comments[:metoos_count] = metoos.length

		return @comments
	end
end
