module Api
  module V1
    class PostsController < ApplicationController
      #functions
      def index
        #query database
        #posts = ModelName.order('created_at DESC');
        posts = Post.order('created_at DESC');
        render json: {status: 'SUCCESS', message: 'Loaded posts', data:posts}, status: :ok
        #access postman via http://localhost:3000/api/v1/posts/
      end

      def show
        post = Post.find(params[:id])
        render json: {status: 'SUCCESS', message: 'Loaded post', data:post}, status: :ok
        #access postman via http://localhost:3000/api/v1/posts/1
      end

      def create #to add post from somewhere else
        post = Post.new(post_params)

        if post.save
          render json: {status: 'SUCCESS', message: 'Saved post', data:post}, status: :ok
        else
          render json: {status: 'ERROR', message: 'Post not saved', data:post.error}, status: :unprocessable_entry
        end
      end

      def destroy
        post = Post.find(params[:id])
        post.destroy
        render json: {status: 'SUCCESS', message: 'Deleted post', data:post}, status: :ok
        #access postman via http://localhost:3000/api/v1//1
      end


      def update
        post = Post.find(params[:id])
        if post.update_attributes(post_params)
           render json: {status: 'SUCCESS', message: 'Updated post', data:post}, status: :ok
        else
          render json: {status: 'ERROR', message: 'Post not updated', data:post.errors}, status: :unprocessable_entry
        end
      end



      private
      def post_params
        params.permit(:title, :body)
      end

    end
  end
end