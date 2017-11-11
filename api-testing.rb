require "httparty"

class TestAPI
  include HTTParty
  base_uri 'http://localhost:5000/api'
end

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

      meuID = response['_id']
      response = TestAPI.get('/series/' + meuID)
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
      response = TestAPI.get('/series/77e0373c6f35bd826f47e977')
      expect(response.code).to eql(200)
      expect(response['name']).to eql("The Flash")
      expect(response['year']).to eql("2014")
      expect(response['season']).to eql("4")
      expect(response['genre']).to eql("action")
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
    updated_serie = {
      'name' => 'Game of Thrones',
      'year' => '2011',
      'season' => '7',
      'genre' => 'Drama'
    }
    begin
      response = TestAPI.put('/series/77e0373c6f35bd826f47e977', body: updated_serie)
      expect(response.code).to eql(204)

      response = TestAPI.get('/series/77e0373c6f35bd826f47e977')
      expect(response['name']).to eql(updated_serie['name'])
      expect(response['year']).to eql(updated_serie['year'])
      expect(response['season']).to eql(updated_serie['season'])
      expect(response['genre']).to eql(updated_serie['genre'])
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
      response = TestAPI.delete('/series/77e0373c6f35bd826f47e977')
      expect(response.code).to eql(204)
    end
  end

  it 'Should to return HttpStatus 404 - NOT FOUND' do
    begin
      response = TestAPI.delete('/series/notExist')
      expect(response.code).to eql(404)
      expect(response['message']).to eql('Not Found')
    end
  end
end
