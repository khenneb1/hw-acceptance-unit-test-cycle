FactoryGirl.define do
  factory :movie do
    title 'Default Title' 
    rating 'G'
    release_date { 5.years.ago }
  end
end
