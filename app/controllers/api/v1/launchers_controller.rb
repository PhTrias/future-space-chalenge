module Api
  module V1
    class LaunchersController < Api::ApiController
      before_action :set_launch, only: [:show, :update, :destroy]

      # GET api/v1/launchers
      def index
        launchers = Launch.all
          .page(params[:page] || 1)
          .per(100)

        render(
          json: {
            launchers: launchers,
            meta: pagination_meta(launchers)
            each_serializer: Api::LauncherSerializer,
          }
        )
      end

      # GET api/v1/launchers/:launcher_id
      def show
        render json: { launcher: @launch, serializer: Api::LauncherSerializer }
      end

      # POST api/v1/launchers
      def create
        launch = Launch.new(launch_params)

        if launch.save
          render(
            json: { launcher: launch, serializer: Api::LauncherSerializer },
            status: :ok
          )
        else
          render(
            json: { error: @launch.errors.full_messages },
            status: :unprocessable_entity
          )
        end
      end

      # POST api/v1/launchers/:launcher_id
      def update
        if @launch.update(launch_params)
          render(
            json: { launcher: @launch, serializer: Api::LauncherSerializer },
            status: :ok
          )
        else
          render(
            json: { error: @launch.errors.full_messages },
            status: :unprocessable_entity
          )
        end
      end

      # DELETE api/v1/launchers/:launcher_id
      def destroy
        if @launch.destroy
          head :no_content
        else
          render(
            json: { successful: false, error: @launch.errors.full_messages },
            status: :unprocessable_entity
          )
        end
      end

      private

      def set_launch
        @launch = Launch.find(params[:id])

        return @launch if @launch.present?

        render json: { successful: false, error: I18n.t("api.launch.not_found"), status: :not_found }
      end

      def launch_params
        params
          .require(:launch)
          .permit(
            :url
            :launch_library_id
            :slug
            :name
            :net
            :window_end
            :window_start
            :inhold
            :tbdtime
            :tbddate
            :probability
            :holdreason
            :failreason
            :hashtag
            :webcast_live
            :image
            :infographic
            :imported_t
            :import_status
          )
      end
    end
  end
end
