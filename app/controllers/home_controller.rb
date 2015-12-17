class HomeController < ApplicationController
    def index
        @questions = Question.all
        @friendships = Friendship.all
    end
end
