require 'rails_helper'

describe Movie do
  describe '#same_director' do

    let!(:movie1) { FactoryGirl.create(:movie, :title => 'Movie 1', :director => 'Kevin') }
    let!(:movie2) { FactoryGirl.create(:movie, :title => 'Movie 2', :director => 'Kevin') }
    let!(:movie3) { FactoryGirl.create(:movie, :title => 'Movie 3', :director => 'Gavin') }
    let!(:movie4) { FactoryGirl.create(:movie, :title => 'Movie 4', :director => 'Evan') }
    let!(:movie5) { FactoryGirl.create(:movie, :title => 'Movie 5', :director => 'Evan') }
    let!(:movie6) { FactoryGirl.create(:movie, :title => 'Movie 6', :director => 'Evan') }
    let!(:movie7) { FactoryGirl.create(:movie, :title => 'Movie 7', :director => '') }
    
    it 'is an instance method' do 
        expect(movie1).to respond_to(:same_director)
    end

    context 'single movie by that director' do 
      it 'returns one movie' do
        allow(movie3).to receive(:director).and_return('Gavin')
        allow(Movie).to receive(:where).with(director: 'Gavin').and_return([movie3])
        expect(movie3.same_director).to eq({director: 'Gavin', movies: [movie3]})
      end
    end
    
    context 'multiple movies by that director' do 
      it 'returns all movies' do
        allow(movie1).to receive(:director).and_return('Kevin')
        allow(Movie).to receive(:where).with(director: 'Kevin').and_return([movie1, movie2])
        expect(movie1.same_director).to eq({director: 'Kevin', movies: [movie1, movie2]})
      end
    end
    
    context 'movie with no director' do 
      it 'returns movie with no director' do
        allow(movie7).to receive(:director).and_return('')
        expect(Movie).not_to receive(:where).with(director: '')
        expect(movie7.same_director).to eq({director: '', movies: [movie7]})
      end
    end
  end
end