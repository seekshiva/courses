jQuery ->
  class TermSubscriptionView extends Backbone.View
    el: "#term_subscription_status"
    template: Handlebars.compile $("#term-subscription-template").html()

    initialize: (term_view) ->
      return if not term_view
      @term_view = term_view
      @term_id = term_view.term.attributes.id
      @app = term_view.app
      @sub_status = new term_view.app.SubscriptionModel()
      if term_view.term.attributes.subscription.id
        @sub_status.set({id : term_view.term.attributes.subscription.id})
        @sub_status.fetch()
      else
        @sub_status.set({ user_id : term_view.term.attributes.subscription.user_id, term_id : term_view.term.attributes.id })
      @

    updateSubscription: (e, data) ->
      e.preventDefault()
      if not data.value
        @app.menu_view.subscriptions.remove({id: @sub_status.id})
        @sub_status.destroy()
        delete @term_view.term.attributes.subscription.id
        delete @sub_status.id
        delete @sub_status.attributes.id
        delete @sub_status.attributes.attending
        delete @sub_status.attributes.created_at
        delete @sub_status.attributes.updated_at
        @app.hide_loading()
      else 
        @sub_status.set({attending : null})
        @sub_status.save(null, { success: _.bind(@updateCollection, @) })
      @

    updateCollection: (model, resp) ->
      @term_view.term.attributes.subscription.id = @sub_status.id
      @app.menu_view.subscriptions.remove({id: @sub_status.id})
      @app.menu_view.subscriptions.add(@sub_status.attributes)

    render: ->
      sub = false
      if @sub_status.attributes.id
        sub = true

      $(@el).html @template
        subscribed: sub
        term_id: @term_id

      @app.hide_loading()

      $(".make-switch").bootstrapSwitch();
      $("#"+@term_id+"_subscription_status").bind("switch-change", _.bind(@updateSubscription, @))
      @

  @app = window.app ? {}
  @app.TermSubscriptionView = TermSubscriptionView
