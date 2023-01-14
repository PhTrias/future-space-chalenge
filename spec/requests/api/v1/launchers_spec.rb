require 'swagger_helper'

RSpec.describe 'api/v1/launchers', type: :request do
  include ApiAsJsonHelper

  path '/api/v1' do
    get('Return message') do
      tags("Launchers")
      security([ bearer_auth: [] ])
      description('Return the backend challenge message')
      consumes('application/json')
      produces('application/json')

      response('200', 'Successful') do
        schema type: :object, properties: { message: { type: :string, example: 'REST Back-end Challenge 20201209 Running'}}
        run_test! do |response|
          data = JSON.parse(response.body)
          expect(data['message']).to eq('REST Back-end Challenge 20201209 Running')
        end
      end

      response('401', 'Authentication failed') do
        schema type: :object, properties: { error: { type: :string, example: 'Invalid token'}}
        run_test!
      end
    end
  end

  path '/api/v1/import_launchers' do
    get('Import launchers') do
      tags("Launchers")
      security([ bearer_auth: [] ])
      description('Import launchers data assyncronously')
      consumes('application/json')
      produces('application/json')

      response('200', 'Successful') do
        schema type: :object, properties: { message: { type: :string, example: 'Running launchers import asyncronously'}}
        run_test! do |response|
          data = JSON.parse(response.body)
          expect(data['message']).to eq('Running launchers import asyncronously')
        end
      end

      response('401', 'Authentication failed') do
        schema type: :object, properties: { error: { type: :string, example: 'Invalid token'}}
        run_test!
      end
    end
  end

  path '/api/v1/launchers' do
    get('List launchers') do
      tags("Launchers")
      security([ bearer_auth: [] ])
      description('Return the list of launchers. 100 per page')
      consumes('application/json')
      produces('application/json')

      response('200', 'Successful') do
        run_test! do |response|
          expect(JSON.parse(response.body).except('meta')).to include(
            {'launchers' => Launch.all.map { |launch| launch_as_json(launch) }}
          )
        end
      end

      response('401', 'Authentication failed') do
        schema type: :object, properties: { error: { type: :string, example: 'Invalid token'}}
        run_test!
      end
    end

    post('Create launcher') do
      tags("Launchers")
      security([ bearer_auth: [] ])
      description('Create a launcher')
      consumes('application/json')
      produces('application/json')
      parameter(name: :launcher, in: :body, schema: { '$ref' => '#/components/schemas/launch' })

      response('200', 'Successful') do
        schema type: :object,
          properties:{
            id: { type: :integer },
            url: { type: :string },
            launch_library_id: { type: :string },
            slug: { type: :string },
            name: { type: :string },
            net: { type: :string },
            window_end: { type: :string },
            window_start: { type: :string },
            inhold: { type: :boolean },
            tbdtime: { type: :boolean },
            tbddate: { type: :boolean },
            probability: { type: :integer },
            holdreason: { type: :string },
            failreason: { type: :string },
            hashtag: { type: :string },
            webcast_live: { type: :boolean },
            image: { type: :string },
            infographic: { type: :string },
            imported_t: { type: :string },
            import_status: { type: :string },
            launch_service_provider: { type: :hash },
            mission: { type: :hash },
            pad: { type: :hash },
            program: { type: :array },
            rocket: { type: :hash },
            status: { type: :hash },
            import_id: { type: :string },
            last_import_code: { type: :string }
          }

        run_test! do |response|
          data = JSON.parse(response.body)
          expect(data).to eq(launch_as_json(data))
        end
      end

      response('401', 'Authentication failed') do
        schema type: :object, properties: { error: { type: :string, example: 'Invalid token'}}
        run_test!
      end

      response('422', 'Unprocessable entity') do
        schema type: :object, properties: { error: { type: :string, example: "Name can't be blank"}}
        run_test! do |response|
          data = JSON.parse(response.body)
          expect(data).to include("error")
        end
      end
    end
  end

  path '/api/v1/launchers/{launcher_id}' do
    parameter name: 'launcher_id', in: :path, type: :string, description: 'id'

    get('Show launcher') do
      tags("Launchers")
      security([ bearer_auth: [] ])
      description('Return an secific launcher by id')
      consumes('application/json')
      produces('application/json')

      response('200', 'Successful') do
        schema type: :object,
          properties:{
            id: { type: :integer },
            url: { type: :string },
            launch_library_id: { type: :string },
            slug: { type: :string },
            name: { type: :string },
            net: { type: :string },
            window_end: { type: :string },
            window_start: { type: :string },
            inhold: { type: :boolean },
            tbdtime: { type: :boolean },
            tbddate: { type: :boolean },
            probability: { type: :integer },
            holdreason: { type: :string },
            failreason: { type: :string },
            hashtag: { type: :string },
            webcast_live: { type: :boolean },
            image: { type: :string },
            infographic: { type: :string },
            imported_t: { type: :string },
            import_status: { type: :string },
            launch_service_provider: { type: :hash },
            mission: { type: :hash },
            pad: { type: :hash },
            program: { type: :array },
            rocket: { type: :hash },
            status: { type: :hash },
            import_id: { type: :string },
            last_import_code: { type: :string }
          }

        run_test! do |response|
          data = JSON.parse(response.body)
          expect(data).to eq(launch_as_json(data))
        end
      end

      response('401', 'Authentication failed') do
        schema type: :object, properties: { error: { type: :string, example: 'Invalid token'}}
        run_test!
      end

      response('404', 'Return message') do
        schema type: :object, properties: { error: { type: :string, example: 'Launcher not found'}}
        run_test! do |response|
          data = JSON.parse(response.body)
          expect(data).to include("error" => "Launcher not found")
        end
      end
    end

    put('Update launcher') do
      tags("Launchers")
      security([ bearer_auth: [] ])
      description('Update an specific launcher')
      consumes('application/json')
      produces('application/json')
      parameter(name: :launcher, in: :body, schema: { '$ref' => '#/components/schemas/launch' })

      response('200', 'Successful') do
        schema type: :object,
          properties:{
            id: { type: :integer },
            url: { type: :string },
            launch_library_id: { type: :string },
            slug: { type: :string },
            name: { type: :string },
            net: { type: :string },
            window_end: { type: :string },
            window_start: { type: :string },
            inhold: { type: :boolean },
            tbdtime: { type: :boolean },
            tbddate: { type: :boolean },
            probability: { type: :integer },
            holdreason: { type: :string },
            failreason: { type: :string },
            hashtag: { type: :string },
            webcast_live: { type: :boolean },
            image: { type: :string },
            infographic: { type: :string },
            imported_t: { type: :string },
            import_status: { type: :string },
            launch_service_provider: { type: :hash },
            mission: { type: :hash },
            pad: { type: :hash },
            program: { type: :array },
            rocket: { type: :hash },
            status: { type: :hash },
            import_id: { type: :string },
            last_import_code: { type: :string }
          }

        run_test! do |response|
          data = JSON.parse(response.body)
          expect(data).to eq(launch_as_json(data))
        end
      end

      response('401', 'Authentication failed') do
        schema type: :object, properties: { error: { type: :string, example: 'Invalid token'}}
        run_test!
      end

      response('404', 'Return message') do
        schema type: :object, properties: { error: { type: :string, example: 'Launcher not found'}}
        run_test! do |response|
          data = JSON.parse(response.body)
          expect(data).to include("error" => "Launcher not found")
        end
      end

      response('422', 'Unprocessable entity') do
        schema type: :object, properties: { error: { type: :string, example: "Name can't be blank"}}
        run_test! do |response|
          data = JSON.parse(response.body)
          expect(data).to include("error")
        end
      end
    end

    delete('Delete launcher') do
      tags("Launchers")
      security([ bearer_auth: [] ])
      description('Delete an specficic launcher')
      consumes('application/json')
      produces('application/json')

      response('200', 'Successful') do
        schema type: :object,
          properties:{
            id: { type: :integer },
            url: { type: :string },
            launch_library_id: { type: :string },
            slug: { type: :string },
            name: { type: :string },
            net: { type: :string },
            window_end: { type: :string },
            window_start: { type: :string },
            inhold: { type: :boolean },
            tbdtime: { type: :boolean },
            tbddate: { type: :boolean },
            probability: { type: :integer },
            holdreason: { type: :string },
            failreason: { type: :string },
            hashtag: { type: :string },
            webcast_live: { type: :boolean },
            image: { type: :string },
            infographic: { type: :string },
            imported_t: { type: :string },
            import_status: { type: :string },
            launch_service_provider: { type: :hash },
            mission: { type: :hash },
            pad: { type: :hash },
            program: { type: :array },
            rocket: { type: :hash },
            status: { type: :hash },
            import_id: { type: :string },
            last_import_code: { type: :string }
          }

        run_test! do |response|
          data = JSON.parse(response.body)
          expect(data).to eq(:no_content)
        end
      end

      response('401', 'Authentication failed') do
        schema type: :object, properties: { error: { type: :string, example: 'Invalid token'}}
        run_test!
      end

      response('404', 'Return message') do
        schema type: :object, properties: { error: { type: :string, example: 'Launcher not found'}}
        run_test! do |response|
          data = JSON.parse(response.body)
          expect(data).to include("error" => "Launcher not found")
        end
      end

      response('422', 'Unprocessable entity') do
        schema type: :object, properties: { error: { type: :string, example: "Name can't be blank"}}
        run_test! do |response|
          data = JSON.parse(response.body)
          expect(data).to include("error")
        end
      end
    end
  end
end
