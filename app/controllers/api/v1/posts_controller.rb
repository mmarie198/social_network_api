module Api
    module V1
      class PostsController < ApplicationController

        before_action :set_post, only: [:update, :destroy]
        
        def index
          posts = Post.includes(:user).all
          render json: posts, include: :user
        end
        
        def create
          post = Post.new(post_params)
          
          if post.save
            render json: post, status: :created
          else
            render json: { errors: post.errors.full_messages }, status: :unprocessable_entity
          end
        end
        
        def update
          if @post.update(post_params)
            render json: @post
          else
            render json: { errors: @post.errors.full_messages }, status: :unprocessable_entity
          end
        end
        
        def destroy
          @post.destroy
          head :no_content
        end
        
        private
        
        def set_post
          @post = Post.find(params[:id])
        rescue ActiveRecord::RecordNotFound
          render json: { error: 'Post not found' }, status: :not_found
        end
        
        def post_params
          params.permit(:content, :user_id)
        end
      end
    end
  end