require "httparty"

class TestAPI
  include HTTParty
  base_uri 'http://localhost:3000/api'
end

initial_serie = {
  "genre" => "Action",
  "season" => "5",
  "year" => "2012",
  "name" => "Arrow"
}
response_global = TestAPI.post('/series', body: initial_serie)



RSpec.describe 'API Testing  - POST' do
  it 'It is not possible create serie without name' do
    new_serie = {
      'year' => '2011',
      'season' => '7',
      'genre' => 'Drama'
    }
    begin
      response = TestAPI.post('/series', body: new_serie);
      expect(response.code).to eql(400)
      expect(response['message']).to eql('Missing required property: name/year/season or genre')
    end
  end

  it 'It is not possible create serie without year' do
    new_serie = {
      'name' => 'Game of Thrones',
      'season' => '7',
      'genre' => 'Drama'
    }
    begin
      response = TestAPI.post('/series', body: new_serie);
      expect(response.code).to eql(400)
      expect(response['message']).to eql('Missing required property: name/year/season or genre')
    end
  end

  it 'It is not possible create serie without season' do
    new_serie = {
      'name' => 'Game of Thrones',
      'year' => '2011',
      'genre' => 'Drama'
    }
    begin
      response = TestAPI.post('/series', body: new_serie);
      expect(response.code).to eql(400)
      expect(response['message']).to eql('Missing required property: name/year/season or genre')
    end
  end

  it 'It is not possible create serie without genre' do
    new_serie = {
      'name' => 'Game of Thrones',
      'year' => '2011',
      'season' => '7',
    }
    begin
      response = TestAPI.post('/series', body: new_serie);
      expect(response.code).to eql(400)
      expect(response['message']).to eql('Missing required property: name/year/season or genre')
    end
  end

  it 'It is possible create serie' do
    new_serie = {
      'name' => 'New Serie',
      'year' => '2011',
      'season' => '7',
      'genre' => 'New genre'
    }
    begin
      response = TestAPI.post('/series', body: new_serie);
      expect(response.code).to eql(201)
      expect(response['name']).to eql(new_serie['name'])
      expect(response['year']).to eql(new_serie['year'])
      expect(response['season']).to eql(new_serie['season'])
      expect(response['genre']).to eql(new_serie['genre'])
    end
  end
end

RSpec.describe 'API Testing  - GET' do
  it 'Should to return a serie' do

    begin
      response = TestAPI.get('/series/' + response_global["_id"])
      expect(response.code).to eql(200)
      expect(response['name']).to eql(initial_serie['name'])
      expect(response['year']).to eql(initial_serie['year'])
      expect(response['season']).to eql(initial_serie['season'])
      expect(response['genre']).to eql(initial_serie['genre'])
    end
  end

  it 'Should to return HttpStatus 404 - NOT FOUND' do
    begin
      response = TestAPI.get('/series/notExist')
      expect(response.code).to eql(404)
      expect(response['message']).to eql('Not Found')
    end
  end
end

RSpec.describe 'API Testing - PUT' do
  it 'Should update a serie' do
    new_serie = {
      'name' => 'Game of Thrones',
      'year' => '2011',
      'season' => '7',
      'genre' => 'Drama'
    }
    begin
      response = TestAPI.put('/series/' + response_global["_id"])
      expect(response.code).to eql(204)
    end
  end

  it 'Should to return HttpStatus 404 - NOT FOUND' do
    new_serie = {
      'name' => 'Game of Thrones',
      'year' => '2011',
      'season' => '7',
      'genre' => 'Drama'
    }
    begin
      response = TestAPI.put('/series/notExist',  body: new_serie)
      expect(response.code).to eql(404)
      expect(response['message']).to eql('Not Found')
    end
  end
end

RSpec.describe 'API Testing - DELETE' do
  it 'Should delete a serie' do
    begin
      response = TestAPI.delete('/series/' + response_global["_id"])
      expect(response.code).to eql(204)
    end
  end

  it 'Should to return HttpStatus 404 - NOT FOUND' do
    begin
      response = TestAPI.get('/series/notExist')
      expect(response.code).to eql(404)
      expect(response['message']).to eql('Not Found')
    end
  end
end
