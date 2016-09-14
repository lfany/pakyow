module Pakyow
  module Presenter
    class Form
      attr_reader :view, :context

      PATCH_METHOD_INPUT = <<-HTML
        <input type="hidden" name="_method" value="patch">
      HTML

      def initialize(view, context)
        @view = view
        @context = context
      end

      def create(*binding_args)
        view.bind(*binding_args) do |view, _|
          view.attrs.action = routes.path(:create, request_params) if routes
        end
      end

      def update(*binding_args)
        view.bind(*binding_args) do |view, _|
          if routes
            route_params = request_params.merge(
              :"#{scoped_as}_id" => view.attrs.__send__('data-id').value
            )

            view.attrs.action = routes.path(:update, route_params)
          end

          view.prepend(View.new(PATCH_METHOD_INPUT))
        end
      end

      private

      def routes
        @routes ||= Router.instance.group(scoped_as)
      end

      def scoped_as
        view.scoped_as
      end

      def request_params
        context.request.params
      end
    end
  end
end
