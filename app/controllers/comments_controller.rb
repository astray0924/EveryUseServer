class CommentsController < ApplicationController
	helper :all
	def index
		# HTTP param
		@user_id = params[:user_id]
		@use_case_id = params[:use_case_id]

		# data
		@user_favorite = Favorite.where("user_id = ? AND use_case_id = ?", @user_id, @use_case_id).length
		@user_fun = Fun.where("user_id = ? AND use_case_id = ?", @user_id, @use_case_id).length
		@user_metoo = Metoo.where("user_id = ? AND use_case_id = ?", @user_id, @use_case_id).length

		# response
		@comment = Hash.new
		@comment[:favorites_count] = @user_favorite
		@comment[:funs_count] = @user_fun
		@comment[:metoos_count] = @user_metoo

		respond_to do |format|
			format.json { render json: @comment}
		end
	end

	def favorite_add
		@favorite = Favorite.new(params[:favorite])

		respond_to do |format|
			if @favorite.save
				format.json { render json: Favorite.count, status: :created }
			else
				format.json { render json: @favorite.errors, status: :unprocessable_entity }
			end
		end
	end

	def favorite_delete
		@user_id = params[:favorite][:user_id]
		@use_case_id = params[:favorite][:use_case_id]

		@favorite = Favorite.where("user_id = ? AND use_case_id = ?", @user_id, @use_case_id).first
		@favorite.destroy if !@favorite.blank? 

		respond_to do |format|
			format.json { render json: Favorite.count }
		end
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
