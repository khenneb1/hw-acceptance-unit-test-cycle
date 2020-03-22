require 'rails_helper'

describe MoviesController do
  describe 'search by similar director', :type => :controller do
  
    context "when the movie has a director" do
      
      describe "when only one movie has that director" do
        
        let(:id) { "1" }
        let(:movie1) { instance_double('Movie', title: 'Blade Runner', director: 'Ridley Scott') }
        let(:movie2) { instance_double('Movie', title: 'Star Wars', director: 'George Lucas') }
        
        it "retrieves director and only one movie" do 
          allow(Movie).to receive(:find).with(id).and_return(movie1)
          expect(movie1).to receive(:same_director).and_return({director: 'Ridley Scott', movies: [movie1]})
          get :similar, id: id
        end
        
        it "results are made available to the template" do
          allow(Movie).to receive(:find).with(id).and_return(movie1)
          allow(movie1).to receive(:same_director).and_return({director: 'Ridley Scott', movies: [movie1]})
          get :similar, id: id 
          expect(assigns(:movies_with_director)).to eq({director: 'Ridley Scott', movies: [movie1]})
        end 
        
        it "selects the same directors template for rendering" do
          allow(Movie).to receive(:find).with(id).and_return(movie1)
          allow(movie1).to receive(:same_director).and_return({director: 'Ridley Scott', movies: [movie1]})
          get :similar, id: id 
          expect(response).to render_template('similar')
        end
        
      end
      
      
      describe "when multiple movies have that same director" do
        
        let(:id) { "1" }
        let(:id2) { "2" }
        let(:movie1) { instance_double('Movie', title: 'Blade Runner', director: 'Ridley Scott') }
        let(:movie2) { instance_double('Movie', title: 'Star Wars', director: 'George Lucas') }
        let(:movie3) { instance_double('Movie', title: 'THX-1138', director: 'George Lucas') }
        it "retrieves director and collection of movies" do 
          allow(Movie).to receive(:find).with(id2).and_return(movie2)
          expect(movie2).to receive(:same_director).and_return({director: 'George Lucas', movies: [movie2, movie3]})
          get :similar, id: id2
        end
        
        it "results are made available to the template" do
          allow(Movie).to receive(:find).with(id2).and_return(movie2)
          allow(movie2).to receive(:same_director).and_return({director: 'George Lucas', movies: [movie2, movie3]})
          get :similar, id: id2 
          expect(assigns(:movies_with_director)).to eq({director: 'George Lucas', movies: [movie2, movie3]})
        end 
        
        it "selects the same directors template for rendering" do
          allow(Movie).to receive(:find).with(id2).and_return(movie2)
          allow(movie2).to receive(:same_director).and_return({director: 'George Lucas', movies: [movie2, movie3]})
          get :similar, id: id2 
          expect(response).to render_template('similar')
        end
        
      end
    end
    
    context "when the movie has no director" do
      describe "unable to retrieve director" do
        
        let(:id4) { "4" }
        let(:movie4) { instance_double('Movie', title: 'Alien', director: '') }
        
        it "retrieve movie but no director" do 
          allow(Movie).to receive(:find).with(id4).and_return(movie4)
          expect(movie4).to receive(:same_director).and_return({director: '', movies: [movie4]})
          get :similar, id: id4 
        end
        
        it "send the flash message" do 
          allow(Movie).to receive(:find).with(id4).and_return(movie4)
          allow(movie4).to receive(:same_director).and_return({director: '', movies: [movie4]})
          get :similar, id: id4 
          expect(flash[:warning]).to match("#{movie4.title}' has no director info")
        end
        
        it "redirect to movies_path" do 
          allow(Movie).to receive(:find).with(id4).and_return(movie4)
          allow(movie4).to receive(:same_director).and_return({director: '', movies: [movie4]})
          get :similar, id: id4 
          expect(response).to redirect_to(movies_path)
        end
      end
    end 
  end
end